extends CharacterBody3D

@onready var level: Node3D = $"/root/Level"
@onready var camera: Camera3D # found in ready

@onready var first_person_location: Node3D = $FirstPersonLocation
@onready var third_person_location: Node3D = $ThirdPersonLocation
var first_person_is_active : bool = false

const SPEED = 5.0
var mouse_sensitivity = 0.002

const CUE_ROTATE_SPEED : float = 0.1
const CUE_ROTATION_NORMAL_CHECK : float = 0.7

func _ready() -> void:
	camera = find_child("Camera3D")

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	var collision_results : KinematicCollision3D = move_and_collide(velocity * delta)
	if collision_results:
		
		if collision_results.get_collider().name == "Cue":
			var collider : StaticBody3D = collision_results.get_collider()
			var local_collision_position = collider.to_local(collision_results.get_position())
			# print("local collision point: ", local_collision_position)
			
			var local_collision_normal : Vector3 = collision_results.get_normal().rotated(Vector3.UP, -collider.rotation.y)
			#print("local_collision normal/pos: ", local_collision_normal, " ", local_collision_position)
			
			if local_collision_position.x < -0.4:
				if local_collision_normal.z > CUE_ROTATION_NORMAL_CHECK:
					#print("spot1 (clockwise)")
					collider.rotate(Vector3.UP, -CUE_ROTATE_SPEED)
				elif local_collision_normal.z < -CUE_ROTATION_NORMAL_CHECK:
					#print("spot2 (counterclockwise)")
					collider.rotate(Vector3.UP, CUE_ROTATE_SPEED)
				else:
					# use the cue to shoot
					collider.shoot()
			elif local_collision_position.x > 0.4:
				if local_collision_normal.z > CUE_ROTATION_NORMAL_CHECK:
					#print("spot3 (counterclockwise)")
					collider.rotate(Vector3.UP, CUE_ROTATE_SPEED)
				elif local_collision_normal.z < -CUE_ROTATION_NORMAL_CHECK:
					#print("spot4 (clockwise)")
					collider.rotate(Vector3.UP, -CUE_ROTATE_SPEED)
			else:
				# translate in direction of player movement
				collider.position += velocity * delta
				
				# translate along opposite of normal
				#acollider.position += collision_results.get_normal() * -SPEED * delta
		
		if collision_results.get_collider().get_node("..").is_in_group("balls"):
			level.report_player_foul()
			#velocity = Vector3.ZERO


func _input(event):
	# toggle mouse look
	if event is InputEventKey and event.keycode == KEY_ESCAPE and event.pressed:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# rotate player/camera view with mouse movement
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clampf(camera.rotation.x, -deg_to_rad(85), deg_to_rad(85))
	
	if event is InputEventKey and event.keycode == KEY_Q and event.pressed:
		if first_person_is_active:
			first_person_location.remove_child(camera)
			third_person_location.add_child(camera)
			first_person_is_active = false
		else:
			third_person_location.remove_child(camera)
			first_person_location.add_child(camera)
			first_person_is_active = true
