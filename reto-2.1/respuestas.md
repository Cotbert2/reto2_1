# Respuestas

## 1. Mantener `D` dos segundos y soltarla: ¿qué contador subió más y por qué?

Subió mucho más **"cuadros con la acción pulsada"**: llegó a [completa con el valor que viste en el HUD], mientras que **"eventos recibidos"** solo subió 2.

La diferencia está en cómo se lee cada contador:

- **Cuadros (sondeo):** se incrementa en `_process`, que se ejecuta una vez por cuadro. Durante dos segundos, `Input.is_action_pressed("move_right")` responde `true` en cada cuadro, así que el contador sube aproximadamente *2 s × FPS* (unos 120 a 60 FPS).
- **Eventos:** se incrementa en `_input`, que solo se ejecuta cuando el sistema operativo reporta un cambio. Mantener la tecla genera dos cambios: uno al presionar y otro al soltar. Las repeticiones automáticas del sistema (eco) se ignoran con `event.is_echo()`, porque no son una pulsación nueva.

## 2. Mantener `A`: ¿qué valores muestran `get_axis` y `get_action_strength("move_right")`, y por qué difieren?

- `get_axis`: **-1.00**
- `get_action_strength("move_right")`: **0.00**

`Input.get_axis("move_left", "move_right")` combina dos acciones en un solo eje: calcula la fuerza de `move_right` menos la de `move_left`, con un rango de -1 a 1. Con `A` pulsada da 0 - 1 = -1, es decir, "hacia la izquierda".

`get_action_strength("move_right")` mira una sola acción y su rango va de 0 a 1. `A` no pertenece a `move_right`, así que su fuerza es 0. Uno responde "¿hacia qué lado?" y el otro "¿cuánto se presiona esta acción?".

## 3. Girar la rueda del ratón: ¿qué clase de evento aparece y por qué su rama va antes que la del clic?

Aparece **`InputEventMouseButton`**. Godot trata cada paso de la rueda como un botón del ratón (`MOUSE_BUTTON_WHEEL_UP` o `MOUSE_BUTTON_WHEEL_DOWN`) que se presiona y se suelta.

Como la rueda y el clic comparten la misma clase, la rama más específica (rueda, que revisa `button_index`) debe ir antes que la general (`event is InputEventMouseButton`). Si la del clic fuera primero, también atraparía la rueda y el HUD la mostraría como un clic: la rama de la rueda nunca se ejecutaría.
