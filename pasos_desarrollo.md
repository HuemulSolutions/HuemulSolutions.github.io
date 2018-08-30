---
layout: default
---

# ¿Como se hace el Desarrollo?
Es muy fácil!, todo gira alrededor de las tablas de datos, es ahí donde debemos empezar.

## Paso 1: Define tu tabla.
![Octocat](huemul_pasos_01_define_tu_tabla.png)
¿Como se define la tabla?, muy similar a como la harías en SQL tradicional.
Debes crear una clase en Scala que herede de la clase huemul_tables, y las columnas deben heredar de huemul_columns, tal como el siguiente ejemplo:


```scala
//Define campo pais_id
val pais_id = new huemul_Columns(StringType,true,"Codigo internacional del país. Ejemplo: chile codigo 056")
    //Largo del campo debe ser siempre 3, por tanto definimos largo máximo y mínimo como 3
    pais_id.DQ_MinLen = 3
    pais_id.DQ_MaxLen = 3
    
    //Además, definimos que el campo no puede tener valores nulos
    pais_id.Nullable = false
```
> Listo!, con 3 simples líneas de código estamos asegurando la validez de nuestros datos.

### DQ: Integridad de Datos y Valores Únicos

> Puedes especificar que los valores en tu tabla sean únicos, ya sea identificando una Primary Key, o indicando en cada campo si el valor es único o no.

```scala
//Define campo pais_id
val pais_id = new huemul_Columns(StringType,true,"Codigo internacional del país. Ejemplo: chile codigo 056")
    //el campo pais_id es la clave primaria de la tabla tbl_pais.
    pais_id.IsPK = true
    
val pais_nombre = new huemul_Columns(StringType,true,"Nombre del país. Ejemplo: chile")
    //adicionalmente, podemos identificar el campo pais_nombre como único, es decir, no se pueden repetir los valores en la tabla
    pais_nombre.IsUnique = true
   
```

> Listo!, integridad de datos aplicada.


## Tracking de cambios de datos en tablas maestras

> Siempre es complejo agregar control de cambios a las tablas, por eso hemos incluido funciones especiales para hacer esta tarea algo sencillo.
>En las tablas maestras, puedes marcar en cada atributo qué tipo de tracking quieres hacer, puedes guardar el valor anterior, la última fecha de cambio y el proceso que hizo ese cambio
> Esto es equivalente a implementar el SCD tipo 2 de kimball.

```scala
  val pais_nombre = new huemul_Columns(StringType,true,"Nombre del país. Ejemplo: chile")
    //En caso de tener modificaciones, creará en forma automática un campo llamado "pais_nombre_old" con el valor anterior
    pais_nombre.MDM_EnableOldValue = true
    //En caso de tener cambios, guardará la fecha/hora de modificación en el campo "pais_nombre_fhChange"
    pais_nombre.MDM_EnableDTLog = true
    //En caso de tener cambios, guardará el proceso que hizo el cambio en el campo "pais_nombre_ProcessLog"
    pais_nombre.MDM_EnableProcessLog = true
    
    ...
  ```



##### Header 5

1.  This is an ordered list following a header.
2.  This is an ordered list following a header.
3.  This is an ordered list following a header.

###### Header 6

| head1        | head two          | three |
|:-------------|:------------------|:------|
| ok           | good swedish fish | nice  |
| out of stock | good and plenty   | nice  |
| ok           | good `oreos`      | hmm   |
| ok           | good `zoute` drop | yumm  |

### There's a horizontal rule below this.

* * *

### Here is an unordered list:

*   Item foo
*   Item bar
*   Item baz
*   Item zip

### And an ordered list:

1.  Item one
1.  Item two
1.  Item three
1.  Item four

### And a nested list:

- level 1 item
  - level 2 item
  - level 2 item
    - level 3 item
    - level 3 item
- level 1 item
  - level 2 item
  - level 2 item
  - level 2 item
- level 1 item
  - level 2 item
  - level 2 item
- level 1 item

### Small image

![Octocat](https://assets-cdn.github.com/images/icons/emoji/octocat.png)

### Large image

![Branching](https://guides.github.com/activities/hello-world/branching.png)


### Definition lists can be used with HTML syntax.

<dl>
<dt>Name</dt>
<dd>Godzilla</dd>
<dt>Born</dt>
<dd>1952</dd>
<dt>Birthplace</dt>
<dd>Japan</dd>
<dt>Color</dt>
<dd>Green</dd>
</dl>

```
Long, single-line code blocks should not wrap. They should horizontally scroll if they are too long. This line should be long enough to demonstrate this.
```

```
The final element.
```
