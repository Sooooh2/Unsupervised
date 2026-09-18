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
	return linear_velocity + angular_velocity.cross(
		point - global_position
	)


func _do_single_wheel_acceleration(ray: rayCastWheel) -> void:
	if not ray.is_colliding():
		return

	if not ray.is_motor:
		return

	if motor_input == 0:
		return

	var forward_dir := -ray.global_basis.z
	var force_vector := forward_dir * accelaration * motor_input

	# Use the actual ground contact point
	var contact := ray.get_collision_point()
	var force_pos := contact - global_position

	apply_force(force_vector, force_pos)


func _do_single_wheel_suspension(ray: rayCastWheel) -> void:
	if not ray.is_colliding():
		return

	var contact := ray.get_collision_point()

	var spring_up_dir := Vector3.UP

	var ray_length := ray.global_position.distance_to(contact)

	var spring_len := ray_length - ray.wheel_r

	var offset := ray.rest_dist - spring_len

	var spring_force := ray.spring_strength * offset

	var world_vel := _get_point_velocity(ray.global_position)

	var relative_vel := spring_up_dir.dot(world_vel)

	var damping_force := ray.spring_damping * relative_vel

	var force_magnitude := spring_force - damping_force
	var force_vector := spring_up_dir * force_magnitude

	var force_pos := contact - global_position

	apply_force(force_vector, force_pos)

	ray.wheel.global_position = (
		ray.global_position +
		Vector3.DOWN * spring_len
	)
