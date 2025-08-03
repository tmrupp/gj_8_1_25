extends Node3D

@onready var collider = $Body/Collider
@onready var body = $Body
@onready var hit_point = $/root/Level/HitPoint
@export var is_cue = true
@export var is_8_ball = false
@export var friction = 100.0
@export var ball_number : int = 1
@export var debugging = false
var start_position

func _ready():
	body.connect("body_entered", collision)
	add_to_group("balls")
	
	start_position = global_position
	#print("start_position=", start_position)
	
	# ENABLE TO DO MANUAL
	#body.contact_monitor = true
	#body.max_contacts_reported = 2
	
	#apply_impulse(Vector3.FORWARD*1200)
	
func _process(_delta):
	# if is_cue:
	# 	print("position=", position, " body.global_position=", body.global_position)
		
	pass
	
func _physics_process(delta):
	#body.apply_force(-body.linear_velocity.normalized()*friction*delta)
	pass
	
func collision(_other):
	# Get body rid
	var rid = body.get_rid()
	# Get body physics state
	var state := PhysicsServer3D.body_get_direct_state(rid)
	print("collision, self=", self, " other=", _other)
	hit(state.get_contact_local_position(0))

func hit (point):
	var direction = body.global_position - point
	#print("hit @ ", point, " from ", position, " direction ", direction)
	body.apply_impulse(direction.normalized()*10)
	#print(linear_velocity)

func hit_via_vector(direction : Vector3):
	body.apply_impulse(direction.normalized()*35)

func _input(event):
	if debugging and hit_point != null and is_cue and event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_RIGHT:
			print("Hit point originally set to: ", hit_point.global_position)
			var mouse_position = get_viewport().get_mouse_position()
			var new_position = get_viewport().get_camera_3d().project_position(mouse_position, 10)
			new_position.y = 0  # Keep the y-coordinate of the hit point
			hit_point.global_position = new_position
			print("Hit point set to: ", hit_point.global_position)
		else:
			var space_state = get_world_3d().direct_space_state
			# use global coordinates, not local to node
			print("global_position=", global_position)
			var query = PhysicsRayQueryParameters3D.create(hit_point.global_position, body.global_position)
			var result = space_state.intersect_ray(query)
			if "position" in result:
				hit(result["position"])
			else:
				print("No hit detected")
			print("Mouse clicked at: ", hit_point.global_position, " - Applying force to body")
