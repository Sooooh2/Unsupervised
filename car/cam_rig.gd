extends SpringArm3D

@export var mouse_sens := 0.06
@export var zoom_speed := 0.5


func _ready() -> void:
	spring_length = 3.0
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

	set_as_top_level(true)

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * mouse_sens
		rotation_degrees.y -= event.relative.x * mouse_sens
		
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, -1.0)
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			spring_length -= zoom_speed
		
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			spring_length += zoom_speed
		
		spring_length = clamp(spring_length, 1.0, 7.0)
