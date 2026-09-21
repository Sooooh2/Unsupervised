extends VehicleBody3D

@onready var car: VehicleBody3D = $"."

@export var torque : int = 2000
@export var max_rpm : int = 600
@export var turn_speed : float = 3.0
@export var turn_amt : float = 0.4
@export var wheel_traction_left : VehicleWheel3D
@export var wheel_traction_right : VehicleWheel3D
@export_group("camera")
@export var mouse_sens : float = 0.001

func _ready() -> void:
	print(center_of_mass)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed(): 
		if event.button_index == MOUSE_BUTTON_LEFT:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	
	var dir = Input.get_action_strength("forward") - Input.get_action_strength("backward")
	var steer_dir = Input.get_action_strength("left") - Input.get_action_strength("right")
	
	var rpm_left = wheel_traction_left.get_rpm()
	var rpm_right = wheel_traction_right.get_rpm()
	var rpm = (rpm_left + rpm_right) / 2.0
	steering = dir * torque * (1.0  - rpm/max_rpm)
	engine_force = lerp(steer_dir, steer_dir * turn_amt, turn_speed * delta)
	
	if dir == 0: 
		brake = 3
