---
layout: default
---
**Huemul BigDataGovernance**, es una librería que trabaja sobre Spark, Hive y HDFS. Permite la implementación de una **estrategia corporativa de dato único**, basada en buenas prácticas de Gobierno de Datos.

### ¿Cómo Funciona?
El diseño de Huemul BigDataGovernance está pensado en optimizar el tiempo de desarrollo de los analistas de datos, y al mismo tiempo aumentar la calidad y gobierno de los datos. 

Utilizando una metodología sólida que permite a los ingenieros de tu equipo centrar sus esfuerzos en la definición de las interfaces de entrada, la definición de las tablas y la construcción de los procesos de masterización robustos.

![Branching](huemul_pasos.png)

### ¿Cómo se genera el código?
Hay dos formas de generar el código de tu solución

1.  La primera forma es generar el código desde cero utilizando los [template que están disponibles acá](template).
2.  En la segunda forma solo debes crear la definición de tu interfaz de entrada utilizando este [template sencillo](template_raw), y luego puedes generar el código de tu tabla y el código de masterización en forma automática!. En el código de la tabla se implementa en forma automática validaciones de calidad de datos, y te permite agregar fácilmente otras validaciones más complejas.

![Branching](huemul_flujo_genera_codigo.png)

### Acelera los desarrollos en 5X y mejora la calidad de datos!
¿Sabías que, en promedio, deberías aplicar como mínimo 3 reglas de calidad de datos por cada columna?, es decir, en una tabla con 10 columnas deberías programar más de 30 reglas de validación (son más de 300 líneas de código si programas cada regla en 10 líneas). y esto es solo para asegurar la validez de tus datos, sin contar reglas de integridad, completitud y precisión.... **y aún no has aplicado ninguna regla de transformación de negocio**

Con Huemul BigDataGovernance, esas 300 líneas de código se reducen a 30 (1 línea por cada validación)... y además te entrega de forma automática documentación de tu proyecto.

### Simplicidad y Eficiencia
Huemul BigDataGovernance permite reducir en forma importante el tiempo de desarrollo de tus proyectos BigData, aumentando la calidad de los datos, **en el mismo código se definen las estructuras de datos, se crea automáticamente el diccionarios de datos, trazabilidad de la información, reglas de data quality, planes de pruebas y criterios de negocio, TODO AL MISMO TIEMPO!** 

Toda la **documentación del proyecto siempre estará actualizada**, cada vez que se ejecuta el código en producción se actualizan los diccionarios y respositorios de trazabilidad, nunca más tendrás que preocuparte por actualizar manualmente la documentación.



### Modelo de Operación Basado en Buenas Prácticas de Gobierno de Datos
La implementación de todas estas etapas puede tardar más de una semana, con Huemul BigDataGovernance lo puedes hacer en unas pocas horas. 

![Branching](huemul_ciclocompleto.png)

Debido al tiempo que demora implementar todas estas estapas, en la práctica solo se logra trabajar en la lógica de negocio sin DataQuality, los planes de pruebas y documentación de los procesos nunca se complentan adecuadamente, esto poniendo en riesgo el éxito de las soluciones analíticas.

La construcción de Huemul BigDataGovernance está basada en las buenas prácticas descritas en el DAMA-DMBOK2 ([Data Management Body Of Knowledge](www.dama.org)), y permite agilizar el desarrollo de proyectos de BigData a nivel corporativo.

### Metodología Flexible
El uso de la librería permite desarrollar en forma flexible tus proyectos de BigData. Trabajar directamente sobre los datos en bruto es una buena opción si tienes un proyecto puntual sobre una interfaz en particular, las transformaciones y validaciones que hagan no serán utilizadas por el resto de la organización (desde "A" hasta "D"). Si quieres juntar muchos datos desde distintas fuentes, la mejor estrategia será generar una base consolidada, donde el DataQuality sea implementado una sola vez, y toda la organización pueda acceder a los datos a validados. 

Nuestra metodología permite implementar ambas estrategias a la vez

![Branching](huemul_metodologia.png)

