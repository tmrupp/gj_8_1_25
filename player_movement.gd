extends CharacterBody3D

const SPEED : float = 20
@onready var marker: Sprite3D = $"../Marker"
@onready var cue: StaticBody3D = $"../Cue"

const CUE_ROTATE_SPEED : float = 0.1
const CUE_ROTATION_NORMAL_CHECK : float = 0.7

func _physics_process(delta: float) -> void:
	var direction : Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = Vector3(direction.x, 0, direction.y) * SPEED
	
	var collision_results : KinematicCollision3D = move_and_collide(velocity * delta)
	if collision_results:
		marker.position = collision_results.get_position()
		
		var collider : StaticBody3D = collision_results.get_collider()
		var local_collision_position = collider.to_local(collision_results.get_position())
		# print("local collision point: ", local_collision_position)
		
		var local_collision_normal : Vector3 = collision_results.get_normal().rotated(Vector3.UP, -collider.rotation.y)
		print("local_collision normal/pos: ", local_collision_normal, " ", local_collision_position)
		
		if local_collision_position.x < -2:
			if local_collision_normal.z > CUE_ROTATION_NORMAL_CHECK:
				print("spot1 (clockwise)")
				collider.rotate(Vector3.UP, -CUE_ROTATE_SPEED)
			elif local_collision_normal.z < -CUE_ROTATION_NORMAL_CHECK:
				print("spot2 (counterclockwise)")
				collider.rotate(Vector3.UP, CUE_ROTATE_SPEED)
		elif local_collision_position.x > 2:
			if local_collision_normal.z > CUE_ROTATION_NORMAL_CHECK:
				print("spot3 (counterclockwise)")
				collider.rotate(Vector3.UP, CUE_ROTATE_SPEED)
			elif local_collision_normal.z < -CUE_ROTATION_NORMAL_CHECK:
				print("spot4 (clockwise)")
				collider.rotate(Vector3.UP, -CUE_ROTATE_SPEED)
		else:
			#translate along opposite of normal
			collider.position += velocity * delta
