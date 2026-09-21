extends RayCast3D
class_name  rayCastWheel


@export var spring_strength : int = 100
@export var spring_damping : int = 2
@export var rest_dist : float = 0.5
@export var over_extend : float = 0.0
@export var wheel_r : float = 0.4
@export var is_motor : bool = false
 

@onready var wheel : Node3D = get_child(0)
