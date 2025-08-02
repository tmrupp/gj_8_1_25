extends StaticBody3D

@onready var ray_cast_3d: RayCast3D = $CollisionShape3D/RayCast3D

func shoot():
	if ray_cast_3d.is_colliding():
		var collider = ray_cast_3d.get_collider()
		print("cue hit against: ", collider.get_node("..").name)
		collider.get_node("..").hit(ray_cast_3d.get_collision_point())
