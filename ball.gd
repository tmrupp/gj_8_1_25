extends RigidBody3D

@onready var collider = $Collider

@onready var hit_point = $"../HitPoint"
@export var is_cue = true
@export var friction = 100.0

func _ready():
	connect("body_entered", collision)
	#apply_impulse(Vector3.FORWARD*1200)
	
func _process(delta):
	#print("position=", position)
	pass
	
func _physics_process(delta):
	apply_force(-linear_velocity.normalized()*friction*delta)
	
func collision(_other):
	# Get body rid
	var rid := get_rid()
	# Get body physics state
	var state := PhysicsServer3D.body_get_direct_state(rid)
	print("collision, self=", self, " other=", _other)
	hit(state.get_contact_local_position(0))

func hit (point):
	var direction = position - point
	print("hit @ ", point, " from ", position, " direction ", direction)
	apply_impulse(direction.normalized()*10)
	print(linear_velocity)
	
func _input(event):
	if is_cue and event is InputEventMouseButton and event.is_pressed():
		var space_state = get_world_3d().direct_space_state
		# use global coordinates, not local to node
		print("global_position=", global_position)
		var query = PhysicsRayQueryParameters3D.create(hit_point.global_position, global_position)
		var result = space_state.intersect_ray(query)
		if "position" in result:
			hit(result["position"])
		else:
			print("No hit detected")
		print("Mouse clicked at: ", hit_point.global_position, " - Applying force to body")
