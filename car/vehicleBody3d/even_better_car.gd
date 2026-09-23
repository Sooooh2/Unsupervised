extends VehicleBody3D


@onready var powerups_manager: PowerupManager = $"../Managers/PowerupsManager"

@export var max_rpm := 500
@export var max_torque := 300
@export var turn_speed := 10
@export var turn_amt := 0.7

@export var boost_multiplier := 100.0
@export var jump_force := 1500.0
@export var air_boost_multiplier := 1900.0

@export var boost_recharge_time := 5.0

var has_speedboost := false
var boost_available := true
var boost_recharging := false

var has_jumpboost := false

func _ready() -> void:
	powerups_manager.powerup_collected.connect(_on_powerup_collected)

	center_of_mass_mode = RigidBody3D.CENTER_OF_MASS_MODE_CUSTOM
	center_of_mass = Vector3(0, -0.2, 0)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flip"):
		reset_car()


func _physics_process(delta: float) -> void:
	$camRig.position = position

	var dir = (
		Input.get_action_strength("deaccelerate")
		- Input.get_action_strength("accelerate")
	)

	var streeing_dir = (
		Input.get_action_strength("left")
		- Input.get_action_strength("right")
	)

	var rpm_left = abs($wheelRL.get_rpm())
	var rpm_right = abs($wheelRR.get_rpm())

	var avg_rpm = (rpm_left + rpm_right) / 2.0

	var torque = dir * max_torque * (1.0 - avg_rpm / max_rpm)


	# JUMP POWERUP
	if has_jumpboost:
		if Input.is_action_just_pressed("jump") and is_on_ground():
			apply_central_impulse(Vector3.UP * jump_force)


	# SPEED BOOST
	if has_speedboost and boost_available:
		if Input.is_action_pressed("boost"):
			torque *= boost_multiplier

		if Input.is_action_just_released("boost"):
			start_boost_recharge()
		if not is_on_ground():
			apply_central_force(
				-global_transform.basis.z * air_boost_multiplier
			)


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


func reset_car() -> void:
	var current_position := global_position
	var current_y_rotation := global_rotation.y

	freeze = true
	global_position = current_position + Vector3.UP * 2.0
	global_rotation = Vector3(0.0, current_y_rotation, 0.0)

	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO

	freeze = false
	sleeping = false


func is_on_ground() -> bool:
	for wheel in get_children():
		if wheel is VehicleWheel3D and wheel.is_in_contact():
			return true

	return false


func _on_powerup_collected(type: PowerupManager.PowerupType) -> void:
	print("Powerup collected: ", type)

	match type:
		PowerupManager.PowerupType.speedBoost:
			
			activate_speed_boost()

		PowerupManager.PowerupType.jump:
			activate_jump_boost()


func activate_speed_boost() -> void:
	has_speedboost = true
	boost_available = true


func activate_jump_boost() -> void:
	has_jumpboost = true


func start_boost_recharge() -> void:
	boost_available = false
	boost_recharging = true

	$boostRechargeTimer.start(boost_recharge_time)


func _on_boost_recharge_timer_timeout() -> void:
	print("recharge happening")
	boost_available = true
	boost_recharging = false
