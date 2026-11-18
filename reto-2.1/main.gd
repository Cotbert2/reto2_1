extends Node2D

const WHEEL_BUTTONS: Array[MouseButton] = [
	MOUSE_BUTTON_WHEEL_UP,
	MOUSE_BUTTON_WHEEL_DOWN,
	MOUSE_BUTTON_WHEEL_LEFT,
	MOUSE_BUTTON_WHEEL_RIGHT,
]

var last_event_class: String = "-"
var last_device: String = "-"
var last_signal: String = "-"
var right_pressed_frames: int = 0
var right_events_received: int = 0

@onready var hud: Label = $Hud


func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		right_pressed_frames += 1
	hud.text = _build_hud_text()


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_echo():
		return
	if event.is_action("move_right"):
		right_events_received += 1
	_classify(event)


func _classify(event: InputEvent) -> void:
	last_event_class = event.get_class()
	var device_name: String = "Otro"
	var signal_type: String = "-"

	if event is InputEventMouseButton and event.button_index in WHEEL_BUTTONS:
		device_name = "Ratón (rueda)"
		signal_type = "Digital (por pasos)"
	elif event is InputEventMouseButton:
		device_name = "Ratón (clic)"
		signal_type = "Digital"
	elif event is InputEventMouseMotion:
		device_name = "Ratón (movimiento)"
		signal_type = "Posición"
	elif event is InputEventPanGesture:
		device_name = "Trackpad (desplazamiento)"
		signal_type = "Analógica"
	elif event is InputEventKey:
		device_name = "Teclado"
		signal_type = "Digital"
	elif event is InputEventJoypadButton:
		device_name = "Mando (botón)"
		signal_type = "Digital"
	elif event is InputEventJoypadMotion:
		device_name = "Mando (eje)"
		signal_type = "Analógica"
	elif event is InputEventScreenTouch or event is InputEventScreenDrag:
		device_name = "Pantalla táctil"
		signal_type = "Posición"

	last_device = "%s (id %d)" % [device_name, event.device]
	last_signal = signal_type


func _build_hud_text() -> String:
	var lines: PackedStringArray = [
		"jump: %s" % Input.is_action_pressed("jump"),
		"get_axis: %.2f" % Input.get_axis("move_left", "move_right"),
		"get_action_strength(\"move_right\"): %.2f" % Input.get_action_strength("move_right"),
		"",
		"Último evento: %s" % last_event_class,
		"Dispositivo: %s" % last_device,
		"Tipo de señal: %s" % last_signal,
		"",
		"move_right - cuadros con la acción pulsada: %d" % right_pressed_frames,
		"move_right - eventos recibidos: %d" % right_events_received,
	]
	return "\n".join(lines)
