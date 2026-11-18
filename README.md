# Ficha del dispositivo: teclado

## Tecnología de captura
Debajo de las teclas hay una matriz de contactos. Al presionar una tecla se cierra un contacto, ya sea una membrana con cúpula de goma o un interruptor mecánico. El microcontrolador del teclado explora la matriz, detecta qué tecla cambió de estado y envía a la computadora un código que la identifica (*scan code*). Godot recibe ese cambio como un `InputEventKey`.

## Tipo de señal: Digital
Cada tecla tiene solo dos estados, pulsada o suelta, sin valores intermedios. Por eso el HUD muestra `get_action_strength("move_right")` únicamente como `0.00` o `1.00`, y nunca un valor como `0.50`.

## Ventaja
La respuesta es inequívoca: una tecla está pulsada o no lo está, sin zonas muertas ni desviaciones (*drift*) como las de un joystick analógico. Además, ofrece decenas de teclas para asignar acciones distintas.

## Limitación
Al ser digital, no permite dosificar la intensidad. Con la misma tecla no se puede caminar despacio o correr según cuánto se presione: para eso hay que asignar teclas o modificadores extra (por ejemplo, `Shift` para correr).

## Juego ejemplo
*Minecraft* (Java Edition): el jugador se mueve con `W`, `A`, `S`, `D` y salta con `Space`, las mismas acciones digitales que usa este reto.

## Fuentes
- Wikipedia. "Teclado (informática)". https://es.wikipedia.org/wiki/Teclado_(inform%C3%A1tica)
- Godot Engine Documentation. "Using InputEvent". https://docs.godotengine.org/en/stable/tutorials/inputs/inputevent.html
