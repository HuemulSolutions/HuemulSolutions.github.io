## Template para crear Definición de Tabla.
El segundo paso para crear una solución de BigData es crear la definición de las tablas.

Los pasos para usar este template se detallan a continuación:
1.   Crear una clase de scala (Scala class) en el package [[com.yourcompany]].[[entidad]].tables.[[master]]
2.   Pegar el siguiente código en el nuevo objeto creado.
3.   Reemplazar todo el texto que está entre corchetes

El significado de los comodines de reemplazo es el siguiente:
* [[com.yourcompany]]: Nombre de tu organización
* [[yourapplication]]: Nombre de tu aplicativo (ejemplo: sbif) 
* [[entidad]]: nombre de la interfaz en particular (ejemplo: planCuentas)
* [[per]]: periodicidad de actualización de la interfaz (mes, dia). Si los datos no tiene periodicidad, borrar este parámetro
* [[master]]: es el espacio donde se creará la tabla, puede ser master,dimensional, analytics o reporting

```scala
package [[com.yourcompany]].[[yourapplication]].tables.[[master]]
        
/**
 * Clase que permite definir una estructura de tabla.
 * ejemplo de nombre: tbl_sbif_eerr_mes
 */

import [[com.yourcompany]].[[yourapplication]].globalSettings._
import com.huemulsolutions.bigdata.common._
import com.huemulsolutions.bigdata.control._
import com.huemulsolutions.bigdata.tables._
import com.huemulsolutions.bigdata.dataquality._
import org.apache.spark.sql.types._


class tbl_[[yourapplication]]_[[entidad]]_[[per]](huemulBigDataGov: huemul_BigDataGovernance, Control: huemul_Control) extends huemul_Table(huemulBigDataGov, Control) with Serializable {
  /**********   C O N F I G U R A C I O N   D E   L A   T A B L A   ****************************************/
  //Tipo de tabla, Master y Reference son catalogos sin particiones de periodo
  this.setTableType(huemulType_Tables.Transaction)
  //Base de Datos en HIVE donde sera creada la tabla
  this.setDataBase(huemulBigDataGov.GlobalSettings.MASTER_DataBase)
  //Tipo de archivo que sera almacenado en HDFS
  this.setStorageType(huemulType_StorageType.PARQUET)
  //Ruta en HDFS donde se guardara el archivo PARQUET
  this.setGlobalPaths(huemulBigDataGov.GlobalSettings.MASTER_SmallFiles_Path)
  //Ruta en HDFS especifica para esta tabla (Globalpaths / localPath)
  this.setLocalPath("[[yourapplication]]/")
    //columna de particion
  this.setPartitionField("periodo_mes")
  /**********   S E T E O   I N F O R M A T I V O   ****************************************/
  //Nombre del contacto de TI
  this.setDescription("[[LLENAR ESTE CAMPO]]")
  //Nombre del contacto de negocio
  this.setBusiness_ResponsibleName("[[LLENAR ESTE CAMPO]]")
  //Nombre del contacto de TI
  this.setIT_ResponsibleName("[[LLENAR ESTE CAMPO]]")
   
  /**********   D A T A   Q U A L I T Y   ****************************************/
  //DataQuality: maximo numero de filas o porcentaje permitido, dejar comentado o null en caso de no aplicar
  //this.setDQ_MaxNewRecords_Num(null)  //ej: 1000 para permitir maximo 1.000 registros nuevos cada vez que se intenta insertar
  //this.setDQ_MaxNewRecords_Perc(null) //ej: 0.2 para limitar al 20% de filas nuevas
    
  /**********   S E G U R I D A D   ****************************************/
  //Solo estos package y clases pueden ejecutar en modo full, si no se especifica todos pueden invocar
  this.WhoCanRun_executeFull_addAccess("process_[[entidad]]_[[per]]", "[[com.yourcompany]].[[yourapplication]]")
  //Solo estos package y clases pueden ejecutar en modo solo Insert, si no se especifica todos pueden invocar
  //this.WhoCanRun_executeOnlyInsert_addAccess("[[MyclassName]]", "[[my.package.path]]")
  //Solo estos package y clases pueden ejecutar en modo solo Update, si no se especifica todos pueden invocar
  //this.WhoCanRun_executeOnlyUpdate_addAccess("[[MyclassName]]", "[[my.package.path]]")
  

  /**********   C O L U M N A S   ****************************************/

    //Columna de periodo
  val periodo_mes = new huemul_Columns (StringType, true,"periodo de los datos")
  periodo_mes.setIsPK(true)
    
    
  val [[entidad]]_id = new huemul_Columns (StringType, true, "Código") 
  [[entidad]]_id.setARCO_Data(false)  
  [[entidad]]_id.setSecurityLevel(huemulType_SecurityLevel.Public)  
  //planCuenta_id.setDQ_MinLen(5) 
  //planCuenta_id.setDQ_MaxLen(100)  
  
  val [[entidad]]_nombre = new huemul_Columns (StringType, true, "nombre") 
  [[entidad]]_nombre.setARCO_Data(false)  
  [[entidad]]_nombre.setSecurityLevel(huemulType_SecurityLevel.Public)  
  //planCuenta_nombre.setDQ_MinLen(5) 
  //planCuenta_nombre.setDQ_MaxLen(100) 

  val [[entidad]]_Monto = new huemul_Columns (DecimalType(20,2), true, "Monto") 
  [[entidad]]_Monto.setARCO_Data(false)  
  [[entidad]]_Monto.setSecurityLevel(huemulType_SecurityLevel.Public)  

  //**********Atributos adicionales de DataQuality
  //yourColumn.setIsPK(true) //valor por default en cada campo es false
  //yourColumn.setIsUnique(true) //valor por default en cada campo es false
  //yourColumn.setNullable(true) //valor por default en cada campo es false
  //yourColumn.setIsUnique(true) //valor por default en cada campo es false
  //yourColumn.setDQ_MinDecimalValue(Decimal.apply(0))
  //yourColumn.setDQ_MaxDecimalValue(Decimal.apply(200.0))
  //yourColumn.setDQ_MinDateTimeValue("2018-01-01")
  //yourColumn.setDQ_MaxDateTimeValue("2018-12-31")
  //yourColumn.setDQ_MinLen(5)
  //yourColumn.setDQ_MaxLen(100)
  //**********Otros atributos
  //yourColumn.setDefaultValue("'string'") // "10" // "'2018-01-01'"
  //yourColumn.setEncryptedType("tipo")
    
  //**********Ejemplo para aplicar DataQuality de Integridad Referencial
  //val i[[tbl_PK]] = new [[tbl_PK]](huemulBigDataGov,Control)
  //val fk_[[tbl_PK]] = new huemul_Table_Relationship(i[[tbl_PK]], false)
  //fk_[[tbl_PK]].AddRelationship(i[[tbl_PK]].[[PK_Id]], [[LocalField]_Id)
    
  //**********Ejemplo para agregar reglas de DataQuality Avanzadas  -->ColumnXX puede ser null si la validacion es a nivel de tabla
  //**************Parametros
  //********************  ColumnXXColumna a la cual se aplica la validacion, si es a nivel de tabla poner null
  //********************  Descripcion de la validacion, ejemplo: "Consistencia: Campo1 debe ser mayor que campo 2"
  //********************  Formula SQL En Positivo, ejemplo1: campo1 > campo2  ;ejemplo2: sum(campo1) > sum(campo2)  
  //********************  CodigoError: Puedes especificar un codigo para la captura posterior de errores, es un numero entre 1 y 999
  //********************  QueryLevel es opcional, por default es "row" y se aplica al ejemplo1 de la formula, para el ejmplo2 se debe indicar "Aggregate"
  //********************  Notification es opcional, por default es "error", y ante la aparicion del error el programa falla, si lo cambias a "warning" y la validacion falla, el programa sigue y solo sera notificado
  //val DQ_NombreRegla: huemul_DataQuality = new huemul_DataQuality(ColumnXX,"Descripcion de la validacion", "Campo_1 > Campo_2",1)
  //**************Adicionalmeente, puedes agregar "tolerancia" a la validacion, es decir, puedes especiicar 
  //************** numFilas = 10 para permitir 10 errores (al 11 se cae)
  //************** porcentaje = 0.2 para permitir una tolerancia del 20% de errores
  //************** ambos parametros son independientes (condicion o), cualquiera de las dos tolerancias que no se cumpla se gatilla el error o warning
  //DQ_NombreRegla.setTolerance(numfilas, porcentaje)
    
  this.ApplyTableDefinition()
}

```

[back](./)
