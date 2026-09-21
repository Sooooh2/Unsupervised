extends VehicleBody3D


@export var max_rpm := 500
@export var max_torque := 300
@export var turn_speed := 10
@export var turn_amt := 0.7
@export var boost_multiplier := 100.0

func _ready():
	center_of_mass_mode = RigidBody3D.CENTER_OF_MASS_MODE_CUSTOM
	center_of_mass = Vector3(0, -0.2, 0)

func _input(event):
	if event.is_action_pressed("flip"):
		reset_car()
	

func _physics_process(delta: float) -> void:
	$camRig.position = position
	
	var dir = Input.get_action_strength("deaccelerate") - Input.get_action_strength("accelerate")
	var streeing_dir = Input.get_action_strength("left") - Input.get_action_strength("right")
	
	var rpm_left = abs($wheelRL.get_rpm())
	var rpm_right = abs($wheelRR.get_rpm())
	
	var avg_rpm = (rpm_left + rpm_right) / 2.0
	
	var torque = dir * max_torque * (1.0 - avg_rpm / max_rpm)
	
	# BOOST
	if Input.is_action_pressed("boost"):
		print(';sfsvdfvdcb fedfsgbnvfgdseqwd')
		torque *= boost_multiplier
	
	engine_force = torque
	
	steering = lerp(
		steering,
		streeing_dir * turn_amt,
		turn_speed * delta
	)
	
	if dir == 0:
		brake = 2
	else:
		brake = 0

func reset_car():
	var current_position = global_position
	var current_y_rotation = rotation.y

	rotation = Vector3.ZERO
	rotation.y = current_y_rotation

	global_position = current_position + Vector3.UP * 2.0

	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
