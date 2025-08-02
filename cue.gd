extends StaticBody3D

@onready var ray_cast_3d: RayCast3D = $CollisionShape3D/RayCast3D

const max_cooldown_time : float = 1
var remaining_cooldown_time = 0

func _process(delta: float) -> void:
	if remaining_cooldown_time > 0:
		remaining_cooldown_time -= delta

func shoot():
	if ray_cast_3d.is_colliding() and not remaining_cooldown_time > 0:
		var collider = ray_cast_3d.get_collider()
		if collider.get_node("..").is_cue:
			#print("cue hit against: ", collider.get_node("..").name, " in direction: ", global_basis.x)
			collider.get_node("..").hit_via_vector(global_basis.x)
			remaining_cooldown_time = max_cooldown_time
