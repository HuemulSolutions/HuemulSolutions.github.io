---
title: Adiós Datamart. Bienvenidos SandBox ;-)
subtitle: Huemul y la evolución de los datos.
excerpt: >-
  ¿Qué viene después de los datamart?. En un ambiente BigData, es importante que las áreas de negocio tengan flexibilidad para poder crear modelos, análisis y generar valor al negocio, pero también es necesario mejorar el control y calidad de los datos.
date: '2018-11-06'
thumb_img_path: images/huemul_metodologia_mini.png
content_img_path: images/huemul_metodologia.png
layout: post
---

Los datamart nos ayudaron a impulsar procesos analíticos en los últimos 15 años, antes de estos ambientes habían planillas excel con complejas fórmulas, y con suerte procesos en MS Access semi automáticos. La creación de soluciones departamentales sin lugar a dudas fueron un avance significativo. Sin embargo las áreas donde los Datamarts han alcanzado cierto nivel de madurez se ven estancados, limitados en su crecimiento, y con alta complejidad en su uso y administración, debido principalmente a la capacidad de procesamiento, almacenamiento, y que el alcance de los datos está limitado, complementar la información con otras fuentes internas es todo un desafío.


Los datamart solo tienen información departamental, y para acceder a datos que residen en otros datamart se generan complejas telarañas de ir y venir de interfaces, copiar y replicar datos, lo que incrementa el riesgo de tener información desactualizada y repetida. ¿se actualizó el dato de MIS y no actualizamos el proceso en nuestro datamart comercial?... problema habitual, ¿les suena conocido?....

![Branching](/images/huemul_datamart_relacion.png )

Un ejemplo concreto es la industria financiera, en ella existen por lo menos 3 datamart, uno de finanzas, otro de riesgos y un tercero comercial, podríamos decir que en promedio estos tres ambientes poseen cerca del 80% de información repetida, y solo un 20% de información "propia". Por ejemplo el datamart de finanzas calcula las rentabilidades a partir de la **actividad de los clientes** y sus costos, el datamart de riesgos calcula las perdidas esperadas y modelos de provisiones a partir de la información de **actividad de los clientes**, y adivinen como el área comercial genera campañas... si, a partir la **actividad de los clientes**.

## Los tiempos cambian...

Hace 15 años era complejo generar una estrategia de dato único y consolidar la información de actividad de los clientes, desde una perspectiva tecnológica las pocas herramientas que lo permitían era extremadamente costosas. Desde una perspectiva de cambio cultural el desafío era aún mayor, cada área estaba acostumbrada a manejar su propio computador bajo el escritorio y ejecutar sus macros en "access" o "excel", por tanto crear un Datamart con una base de datos más robustas era una solución intermedia que estaba al alcance de la mayoría de las organizaciones.

Sin embargo hoy el escenario es diametralmente distinto, existen múltiples herramientas open-source que pueden ser implementadas en infraestructura on-premise o en la nube, que permiten procesar un volumen enorme de datos a un costo razonable, y las áreas de negocio tienen experiencia trabajando con datos y soluciones analíticas. **El siguiente paso es generar eficiencias en los procesos, llevando ese 80% de datos comunes en un ambiente corporativo**, y que todos tengan un mismo dato validado. Con esto las áreas de negocio podrán trabajen en forma colaborativa usando sus SandBox.

## El Análisis.

Entonces, ¿cual es la diferencia entre un SandBox y un Datamart?, mientras un Datamart es departamental y contiene los datos del negocio duplicados en otros Datamart, **el SandBox es un ambiente donde se crean las lógicas de negocio de cada área, y todos los datos necesarios para ejecutar estas lógicas de negocio están en un ambiente compartido y productivo**, pudiendo ser estos ambientes un "DataLake" con datos en bruto, un ambiente "master" donde hay datos limpios y validados, un ambiente "Dimensional" donde está la versión única del dato (golden record), o un ambiente "analítico" donde está el resultante de la ejecución de distintos modelos. Dependiendo del caso de uso, los datos se pueden obtener desde distintos lugares, esto permite entregar mayor flexibilidad a los analistas de las áreas de negocio, y asegura que los datos utilizados por toda la organización son los mismos. En el ejemplo anterior de la industria financiera, la carga de datos de la "actividad de los clientes" se hace una sola vez en el ambiente "Master", y desde ahí MIS puede usar su SandBox particular para calcular las rentabilidades, el área de riesgos usa su SandBox particular para calcular los modelos de provisiones y el área comercial usa su Sandbox particular para calcular las ofertas comerciales.

La siguiente figura muestra un framework flexible que establece la relación entre estos ambientes, y dependiendo del caso de uso se pueden usar datos directamente desde el DataLake (Time to Market rápido, sin transformaciones, sin datos validados) o desde un ambiente dimensional (Time to Market más lento, datos transformados, datos validados). El usuario es el que elige como usar los datos en función de las políticas corporativas definidas.

![Branching](/images/huemul_metodologia.png)

## Características
Este modelo tiene las siguientes características

- **Eficiencia**: antes hablamos que cerca del 80% de la información en los datamart está repetida, esto significa que la carga de nuevos datos comunes, o las correcciones y ajustes de los datos que ya están en producción se hará solo 1 vez, y será visible para toda la organización.
- **Control de accesos**: se controla el acceso a datos sensibles en un solo ambiente, las áreas de perfilado no tendrán que ingresar a 4 o 5 ambientes distintos.
- **Consistencia**: al estar todos los datos base disponibles en un solo ambiente, se asegura que la misma versión del dato es la que toda la organización utiliza para desarrollar sus procesos de negocio.
- **Control**: Los ambientes comunes son productivos, eso quiere decir que las áreas de TI son las encargadas de asegurar la disponibilidad de los datos comunes, y las áreas negocio los consumen sin preocuparse de su ejecución.
- **Flexibilidad**: los SandBox son ambientes administrados por las áreas de negocio, donde pueden hacer experimentos, análisis, investigación, modelos y procesos usando los datos comunes, sin depender de otras áreas.

## Resumen
La era de los datamarts está llegando a su fin, sin lugar a dudas fueron una tremenda solución que permitió el desarrollo de muchas áreas analíticas, y simplificaron la ejecución de procesos departamentales, a la vez entregaron autonomía a las áreas de negocio y liberaron de tensión a las áreas de TI. Es hora de una merecida jubilación!.

Ahora que las áreas de datos y analíticas tienen más experiencia y una mayor madurez, exigen un nuevo nivel de colaboración, y las tecnologías actuales son habilitantes para que esta colaboración ocurra. Utilizar un framework dinámico permite generar mayores eficiencias, mejor time to market de las soluciones y análisis más robustos con información más completa y diversa. Los SandBox permiten mayor flexibilidad a las áreas de negocio, en un ambiente mucho más robusto, y con procesos productivos que aseguran la correcta ejecución en ambientes más complejos.

Gracias Datamarts!, **Bienvenidos SandBox!**
