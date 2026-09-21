extends RigidBody3D

@export var wheels: Array[rayCastWheel]
@export var accelaration: float = 600.0

var motor_input := 0


func _ready() -> void:
	for wheel in wheels:
		wheel.target_position.y = -(
			wheel.rest_dist +
			wheel.wheel_r +
			wheel.over_extend
		)
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("accelerate"):
		motor_input = 1
	elif event.is_action_released("accelerate"):
		motor_input = 0

	if event.is_action_pressed("deaccelerate"):
		motor_input = -1
	elif event.is_action_released("deaccelerate"):
		motor_input = 0


func _physics_process(delta: float) -> void:
	for wheel in wheels:
		_do_single_wheel_suspension(wheel)
		_do_single_wheel_acceleration(wheel)



func _get_point_velocity(point: Vector3) -> Vector3:
	return linear_velocity + angular_velocity.cross(point - global_position)


func _do_single_wheel_acceleration(ray: rayCastWheel) -> void:
	if ray.is_colliding() and ray.is_motor and motor_input:
		var forward_dir := -ray.global_basis.z
		var force_vector := forward_dir * accelaration * motor_input
		var contact := ray.get_collision_point()
		var force_pos := contact - global_position

		apply_force(force_vector, force_pos)

func _do_single_wheel_suspension(ray: rayCastWheel) -> void:
	if not ray.is_colliding():
		return

	var contact := ray.get_collision_point()

	# Suspension is vertical.
	var spring_up_dir := Vector3.UP

	# World-space distance from RayCast to ground.
	var ray_length := ray.global_position.distance_to(contact)

	# Distance from RayCast to wheel centre.
	var spring_len := ray_length - ray.wheel_r

	# Compression relative to rest length.
	var offset := ray.rest_dist - spring_len

	# Spring force.
	var spring_force := ray.spring_strength * offset

	# Velocity of suspension point.
	var world_vel := _get_point_velocity(ray.global_position)

	# Only vertical velocity affects suspension damping.
	var relative_vel := spring_up_dir.dot(world_vel)

	# Damping force.
	var damping_force := ray.spring_damping * relative_vel

	# Final suspension force.
	var force_magnitude := spring_force - damping_force
	var force_vector := spring_up_dir * force_magnitude

	# Apply at wheel contact point.
	var force_pos := contact - global_position

	apply_force(force_vector, force_pos)

	# Put visual wheel at the actual suspension position.
	ray.wheel.global_position = (
		ray.global_position +
		Vector3.DOWN * spring_len
	)
