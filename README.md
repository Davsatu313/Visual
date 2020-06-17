# Repositorio Computacion Visual 2020-1

## Integrantes

|       Integrante      |                 github                        |
|-----------------------|-----------------------------------------------|
| David Fajardo| [davsatu313](https://github.com/davsatu313) |
| Angel Corredor   | [adcorredorm](https://github.com/adcorredorm)       |


## Propósito

Hacer una pequeña introduccion a temas de computacion visual como análisis de imágenes/video utilizando [Processing](https://processing.org/).

Hacer un demo exploratorio de visualizacion de datos, utilizando datos libres sobre el uso de bicicletas en la ciudad de NY

## Trabajos Realizados

Analisis de Imagen:

* Conversión a escala de grises.
* Aplicación de algunas [máscaras de convolución](https://en.wikipedia.org/wiki/Kernel_(image_processing)).
* Conversión a ascii.
* (solo para imágenes) Despliegue del histograma.
* (solo para video) Medición de la eficiencia computacional para las operaciones realizadas.

Visualizacion de datos:

* El sistema de bicicletas CitiBike hace disponible la información de todos sus viajes así como alguna información de sus usuarios. Al igual que el punto anterior, se debe visualizar información geográfica y de usuario pero con un componente temporal mucho más marcado al tener información minuto a minuto. 


## Metodologia
**Procesamiento por software:**

*  **Conversión a escala de grises**: 
**Imagen**: Pixel a pixel en la imagen se aplican dos tipos de filtros, siendo el primero el más sencillo de todos puesto que es el progmedio de los valores RGB del pixel en dicho punto de la imagen y el segundo corresponda a LUMA, donde el RGB del pixel es multiplicado por coheficientes luma para generar un valor de gris más brillante y homogeneo.

**Video**: Gracias a la libreria de video de processing se puede importar el video para ser tratado frame a frame dentro del entorno de desarrollo, lo que nos permite hacer operaciones pixel a pixel sobre cada frame

*  **Máscaras de convolución**: 

**Imagen**: Se  aplican  5 mascaras de convolución recorriendo la imagen pixel a pixel, aplicando a cada uno la matriz de convolución respectiva, las mascaras usadas fueron:

* GaussianBlur: El desenfoque gaussiano es un efecto de suavizado para mapas de bits generado por software de edición gráfica.

* Edge detection: Tiene como objetivo la identificación de puntos en una imagen digital en la que el brillo de la imagen cambia drásticamente o, más formalmente tiene discontinuidades.

* Saturation: Tecnica para aumentar el brillo y saturacion de la imagen.

* SSaturation : Tecnica para aumentar el brillo y saturacion de la imagen, esta aun que es similar a la anterior mencionada tiene un efecto mucho más visible y salio de pruebas de los programadores con el kernel.

* Sharpen: Tecnica para aumentar la nitidez aparente de una imagen.


**Video**: Se toma un video extrayendo sus frames para poder ser tratados como imagenes independientes, se les aplican los kernel de  las mascaras escogidas, se guardan en un vector del tamaño del video y es este vector el que se dibujara en el canvas.


*  **ASCII**: 
**Imagen**:Se pasa la imagen a escala de grises usando luma para tomar la intensidad de su color, con esta escala de grises se mapean los 256 posibles valores a caracteres los cuales van a usar una fuente monoespaciada previamente importada y se reescala la imagen  a su tamaño original debido a que esta se deforma por el tamaño de los caracteres, ya que en este punto no se toma encuenta dividir la imagen en secciones recontando pixeles para tener un tamaño similar al original.

**Video**:Gracias a la libreria de video de processing se puede importar el video para ser tratado frame a frame dentro del entorno de desarrollo, lo que nos permite hacer operaciones pixel a pixel sobre cada frame, en este caso la complejidad computacional es enorme debido a la cantidad de operaciones por frame que tiene que hacer, esto se evidencia en la cantidad de FPS que se tienen, de hecho, en este punto fue necesario utilizar un video extremadamente pequeño en resolucion, de lo contrario los tiempos de carga serian demasiado altos para apreciar el efecto en el tiempo.

* **Histograma de intensidad**: Se agrega un histograma a una imagen  que nos va a representar  distribución de frecuencia de los niveles de gris con el número de valores de negro puro que se muestran a la izquierda y el número de valores de blanco puro representados a la derecha.


**Procesamiento por hardware:**

*  **Conversión a escala de grises**: 
**Imagen**: Se crean tres shaders diferentes, El primero  tendra definido una operacion que calculara el promedio del RGB del pixel y este resultado se pasa como textura de salida y se sobreescribe en la imagen de salida, el segundo shader tiene definida una operacion punto a punto entre un vector luma de tres posicion con el RGB del pixel, este resultado se pasa como textura de salida y se sobreescribe en la imagen de salida y finalmente el tercero hace una transformacion total y radical del blanco y negro obviando cualquer matiz de gris.

**Video**: Se usan los tres shaders anteriores  y se opera  cada frame  del video como  una imagen..


*  **Máscaras de convolución**: 

**Imagen**: Se creo un shader que recibe nueve valores que van a ser operados con los valores de las texturas de la imagen, los nueve valores que se reciben, variaran dependiendo del efecto que se quiera conseguir.


* GaussianBlur: El desenfoque gaussiano es un efecto de suavizado para mapas de bits generado por software de edición gráfica.

* Edge detection: Tiene como objetivo la identificación de puntos en una imagen digital en la que el brillo de la imagen cambia drásticamente o, más formalmente tiene discontinuidades.

* Saturation: Tecnica para aumentar el brillo y saturacion de la imagen.

* SSaturation : Tecnica para aumentar el brillo y saturacion de la imagen, esta aun que es similar a la anterior mencionada tiene un efecto mucho más visible y salio de pruebas de los programadores con el kernel.

* Sharpen: Tecnica para aumentar la nitidez aparente de una imagen.

**Video**: Al poder usar la libreria de video para poder hacer analisis de cada uno de los frames es posible aplicar el mismo shader que se uso para las imagenes.

*  **ASCII**: 
**Imagen**: Para la implementacion de ASCII por hardware, se uso como base el siguiente [shader](https://www.shadertoy.com/view/lssGDj#) donde se mapeara la imagen basandonos en rangos de pixeles, para evitar el sobre escalado como se vio en la implementacion por sofware, lo que nos permite tener una calidad mayor y disminuir la complejidad, a su vez gracias a la evidente mejora en la capacdidad computacional se decidio dejar a los caracteres representados con los colores de base que trae la imagen input.

**Video**:l poder usar la libreria de video para poder hacer analisis de cada uno de los frames es posible aplicar el mismo shader que se uso para las imagenes, aqui es importante resaltar el hecho de que no es necesario el hecho de tener que tener como input un video extremadamente pequeño en resolucion, puesto que la capacidad computacional por hardware hace que sea mucho más rapido el calculo, pero el consumo de recursos de la misma manera aumenta considerablemente.

## Resultados

+ ![Escala de grises por hardware] (/Images/HGrey.png)