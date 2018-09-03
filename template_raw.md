
## Template para crear Definición de lectura de interfaces de DataLake
El primer paso para crear una solución de BigData es crear la definición de las interfaces de entrada.

Los pasos para usar este template se detallan a continuación:
1.   Crear un objeto de scala (Scala object) en el package [[com.yourcompany]].[[entidad]].datalake
2.   Pegar el siguiente código en el nuevo objeto creado.
3.   Reemplazar todo el texto que está entre corchetes

El significado de los comodines de reemplazo es el siguiente:
* [[com.yourcompany]]: Nombre de tu organización
* [[yourapplication]]: Nombre de tu aplicativo (ejemplo: sbif) 
* [[entidad]]: nombre de la interfaz en particular (ejemplo: planCuentas)
* [[per]]: periodicidad de actualización de la interfaz (mes, dia). Si los datos no tiene periodicidad, borrar este parámetro
* [[name{{yyyy}}{{mm}}{{dd}}.TXT]]: Nombre físico de la interfaz
* [[nombre de contacto del origen]]: Nombre de la persona responsable de la interfaz

```scala
package [[com.yourcompany]].[[yourapplication]].datalake
        
import [[com.yourcompany]].[[yourapplication]].globalSettings._
import com.huemulsolutions.bigdata.common._
import com.huemulsolutions.bigdata.control._
import com.huemulsolutions.bigdata.datalake._
import com.huemulsolutions.bigdata.tables._

/**
 * Clase que permite abrir un archivo de texto, devuelve un objeto huemul_dataLake con un DataFrame de los datos
 * ejemplo de nombre: raw_institucion_mes
 */
class raw_[[entidad]]_[[per]](huemulBigDataGov: huemul_BigDataGovernance, Control: huemul_Control) extends huemul_DataLake(huemulBigDataGov, Control) with Serializable  {
   this.LogicalName = "[[yourapplication]]_[[entidad]]_[[per]]"
   this.Description = "Decripción de la interfaz"
   this.GroupName = "[[yourapplication]]"
   
   //Crea variable para configuración de lectura del archivo
   val CurrentSetting = new huemul_DataLakeSetting(huemulBigDataGov)
   //setea la fecha de vigencia de esta configuración
   CurrentSetting.StartDate = huemulBigDataGov.setDateTime(2010,1,1,0,0,0)
   CurrentSetting.EndDate = huemulBigDataGov.setDateTime(2050,12,12,0,0,0)

   //Configuración de rutas globales
   CurrentSetting.GlobalPath = huemulBigDataGov.GlobalSettings.RAW_SmallFiles_Path
   //Configura ruta local, se pueden usar comodines
   CurrentSetting.LocalPath = "[[yourapplication]]/"
   //configura el nombre del archivo (se pueden usar comodines)
   CurrentSetting.FileName = "[[name{{yyyy}}{{mm}}{{dd}}.TXT]]"
   //especifica el tipo de archivo a leer
   CurrentSetting.FileType = huemulType_FileType.TEXT_FILE
   //expecifica el nombre del contacto del archivo en TI
   CurrentSetting.ContactName = "[[nombre de contacto del origen]]"

   //Indica como se lee el archivo
   CurrentSetting.DataSchemaConf.ColSeparatorType = huemulType_Separator.CHARACTER  //POSITION;CHARACTER
   //separador de columnas
   CurrentSetting.DataSchemaConf.ColSeparator = "\t"    //SET FOR CARACTER
   //forma rápida de configuración de columnas del archivo
   //CurrentSetting.DataSchemaConf.setHeaderColumnsString("institucion_id;institucion_nombre")
   //Forma detallada
   CurrentSetting.DataSchemaConf.AddColumns("mes", "mes", IntegerType, "Mes de los datos que vienen en el archivo")
   CurrentSetting.DataSchemaConf.AddColumns("campo2", "campo_2_ti_nombre", StringType, "descripcion del campo")
    
   //Seteo de lectura de información de Log (en caso de tener)
   CurrentSetting.LogSchemaConf.ColSeparatorType = huemulType_Separator.CHARACTER  //POSITION;CHARACTER;NONE
   CurrentSetting.LogNumRows_FieldName = null
   CurrentSetting.LogSchemaConf.ColSeparator = ";"    //SET FOR CARACTER
   CurrentSetting.LogSchemaConf.setHeaderColumnsString("VACIO") 
   this.SettingByDate.append(CurrentSetting)
  
    /***
   * open(ano: Int, mes: Int) <br>
   * método que retorna una estructura con un DF de detalle, y registros de control <br>
   * ano: año de los archivos recibidos <br>
   * mes: mes de los archivos recibidos <br>
   * dia: dia de los archivos recibidos <br>
   * Retorna: true si todo está OK, false si tuvo algún problema <br>
  */
  def open(Alias: String, ControlParent: huemul_Control, ano: Integer, mes: Integer, dia: Integer, hora: Integer, min: Integer, seg: Integer): Boolean = {
    //Crea registro de control de procesos
     val control = new huemul_Control(huemulBigDataGov, ControlParent)
    //Guarda los parámetros importantes en el control de procesos
    control.AddParamInfo("Ano", ano.toString())
    control.AddParamInfo("Mes", mes.toString())
       
    try { 
      //NewStep va registrando los pasos de este proceso, también sirve como documentación del mismo.
      control.NewStep("Abre archivo RDD y devuelve esquemas para transformar a DF")
      if (!this.OpenFile(ano, mes, dia, hora, min, seg, null)){
        //Control también entrega mecanismos de envío de excepciones
        control.RaiseError(s"Error al abrir archivo: ${this.Error.ControlError_Message}")
      }
   
      control.NewStep("Aplicando Filtro")
      //Si el archivo no tiene cabecera, comentar la línea de .filter
      val rowRDD = this.DataRDD
            //filtro para considerar solo las filas que los tres primeros caracteres son numéricos
            .filter { x => x.length()>=4 && huemulBigDataGov.isAllDigits(x.substring(0, 3) )  }
            //filtro para dejar fuera la primera fila
            //.filter { x => x != this.Log.DataFirstRow  }
            .map { x => this.ConvertSchema(x) }
            
      control.NewStep("Transformando datos a dataframe")      
      //Crea DataFrame en Data.DataDF
      this.DF_from_RAW(rowRDD, Alias)
        
      //****VALIDACION DQ*****
      //**********************
      control.NewStep("Valida que cantidad de registros esté entre 10 y 100")    
      //validacion cantidad de filas
      val validanumfilas = this.DataFramehuemul.DQ_NumRowsInterval(this, 10, 100)      
      if (validanumfilas.isError) control.RaiseError(s"user: Numero de Filas fuera del rango. ${validanumfilas.Description}")
                        
      control.FinishProcessOK                      
    } catch {
      case e: Exception => {
        control.Control_Error.GetError(e, this.getClass.getName, null)
        control.FinishProcessError()   
      }
    }         
    return control.Control_Error.IsOK()
  }
}


/**
 * Este objeto se utiliza solo para probar la lectura del archivo RAW
 * La clase que está definida más abajo se utiliza para la lectura.
 */
object raw_[[entidad]]_[[per]]_test {
   /**
   * El proceso main es invocado cuando se ejecuta este código
   * Permite probar la configuración del archivo RAW
   */
  
  def main(args : Array[String]) {
    
    //Creación API
    val huemulBigDataGov  = new huemul_BigDataGovernance(s"Testing DataLake - ${this.getClass.getSimpleName}", args, Global)
    //Creación del objeto control, por default no permite ejecuciones en paralelo del mismo objeto (corre en modo SINGLETON)
    val Control = new huemul_Control(huemulBigDataGov, null)
    
    /*************** PARAMETROS **********************/
    var param_ano = huemulBigDataGov.arguments.GetValue("ano", null, "Debe especificar el parámetro año, ej: ano=2017").toInt
    var param_mes = huemulBigDataGov.arguments.GetValue("mes", null, "Debe especificar el parámetro mes, ej: mes=12").toInt
    
    //Inicializa clase RAW  
    val DF_RAW =  new raw_[[entidad]]_[[per]](huemulBigDataGov, Control)
    if (!DF_RAW.open("DF_RAW", null, param_ano, param_mes, 0, 0, 0, 0)) {
      println("************************************************************")
      println("**********  E  R R O R   E N   P R O C E S O   *************")
      println("************************************************************")
    } else
      DF_RAW.DataFramehuemul.DataFrame.show()
      
    Control.FinishProcessOK
   
  }  
}
```

[back](./)
