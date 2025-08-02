extends RigidBody3D

@onready var collider = $Collider

func _ready():
	connect("body_entered", collision)
	#apply_impulse(Vector3.FORWARD*1200)
	
func _process(delta):
	print("position=", position)
	pass
	
func collision(_other):
	# Get body rid
	var rid := get_rid()
	# Get body physics state
	var state := PhysicsServer3D.body_get_direct_state(rid)
	hit(state.get_contact_local_position(0))

func hit (point):
	var direction = point - position
	print("hit @ ", point, " from ", position, " direction ", direction)
	apply_impulse(direction.normalized()*100)
	print(linear_velocity)
	
func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var mouse_pos = get_viewport().get_mouse_position()
		var space_state = get_world_3d().direct_space_state
		# use global coordinates, not local to node
		var query = PhysicsRayQueryParameters3D.create(Vector3(mouse_pos.x, 0, mouse_pos.y), position)
		var result = space_state.intersect_ray(query)
		if "position" in result:
			hit(result["position"])
		print("Mouse clicked at: ", mouse_pos, " - Applying force to body")
