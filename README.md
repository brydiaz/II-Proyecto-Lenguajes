# Juego del laberinto

<br><br>

## :notebook: Descripción del proyecto
EL presente proyecto desarrolla un juego de un laberinto, el cual es generado de forma aleatoria cada vez que se inicia, donde la idea principal es que el usuario sea capaz de llegar desde un punto de inicio en el laberinto hasta un punto final (el punto final no es precisamente una salida, puede ser un objeto o algo representativo de victoria), sin embargo, para lograr esto deberá cruzar el camino del laberinto que estará compuesto por 2 tipos de obstáculos formando así un camino complicado de recorrer para conseguir el objetivo. No obstante, el sistema es lo suficientemente amigable cómo para tener la opción de proporcionar ayuda para encontrar el camino más corto para llegar a la casilla final o en caso de no existir ruta para llegar el programa también le informará de ello. Cabe agregar que el usuario se límita a moverse en las direcciones izquierda, derecha, arriba y abajo.

Este trabajo busca representar dicho juego a través del lenguaje de programación Racket, utilizando medios gráficos (imágenes para mostrar los elementos del juego cómo el personaje, los obstáculos y la meta final) para que luzca de forma más amena para el usuario y también tiene la intención de desarrollar en los programadores encargados un aprendizaje en el mencionado lenguaje con el propósito de ampliar el conocimiento en lo que sería un lenguaje funcional.

<br><br><br><br>


## :video_game: Pasos necesarios para poder iniciar el laberinto

El primer paso a tener en cuenta es que debe tener instalado el ambiente de DrRacket junto con paquetes de la biblioteca _graph_ (en caso de no tenerlos, el mismo sistema le dirá cómo instalarlos). Por otro lado, si se encuentra con un código incomprensible (símbolos, números, ...) en este GitHub no hay nada de que preocuparse, a la hora de abrirlo en DrRacket este se encargará de darle forma al código, es ahí donde se verá cómo realmente quedó este.  
<br><br>
Ahora bien, para iniciar y observar el laberinto basta con: 

1. _clickar_ sobre el archivo __maze__ y esperar a que DrRacket lo abra.
2. Darle click sobre _run_ para que ejecute el código.
3. Colocar en las entradas de texto las respectivas coordenadas de donde se va iniciar a resolver el laberinto.
      - En la primera entrada colocar la posición en el eje Y (arriba-abajo, iniciando en 1 y terminando en 6)
      - En la segunda entrada colocar la posición en el eje X (derecha-izquierda, iniciado en 1 y terminando en 6)

4. Dar click en el botón presente para iniciar la ejecución de la solución del algoritmo, aquí pueden suceder los siguientes casos:
      - Mostrar un mensaje de error porque las entradas del usuario fueron erróneas
      - Mostrar un mensaje diciendo que es imposible llegar a la solución (no hay ningún camino que lleve a la meta)
      - Dibujar el camino sobre el laberinto hasta llegar a la meta, mostrando así la ruta más corta

5. En caso de que se muestre la solución en el laberinto, esta se mostrará poco a poco, para que el usuario pueda apreciar paso a paso el camino y observar la genialidad del algoritmo aquí implementado por los desarrolladores, ya que en realidad la solución fue generada en cuestión de 1 segundo o menos. :smiley:

6. Si desea volver a ver el funcionamiento del laberinto basta con cerrar la ventana y volver al punto 2 de estas instrucciones.

<br> 

__Nota:__ Se resalta lo que significan las imágenes en el laberinto:

- El fuego es la meta a la que hay que llegar
- Los escudos (independientemente del color) son los obstáculos
- Las otras imágenes representan el camino que se puede atravesar
- Los bombillos muestran el camino generado por el programa para tener la ruta más corta


<br><br><br><br>

## :video_camera: Links a los vídeos explicativos de los integrantes del grupo
**Jose Alexander Artavia Quesada:** https://www.youtube.com/watch?v=IyHqfnsVw-Q
<br>

**Bryan Andrey Díaz Barrientos:** https://youtu.be/T50E661TSio
<br> 

**Josué Gerardo Gutiérrez Mora:** https://youtu.be/ggfGsCVpE2w
