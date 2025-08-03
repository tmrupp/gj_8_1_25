extends Node3D

var locked_down : bool = true
var current_lockdown_grace_timer : float = 0

var motion_tracked_objects = []

func _process(delta: float) -> void:
	current_lockdown_grace_timer -= delta
	if not locked_down and not current_lockdown_grace_timer > 0:
		var at_least_one_moving_object = false
		for object in motion_tracked_objects:
			if object.linear_velocity.length() > 1e-1:
				at_least_one_moving_object = true
		if not at_least_one_moving_object:
			set_lockdown(true)
			print("locking down")

func report_player_foul():
	print("Foul: player touched a ball directly")
	
func end ():
	print("reseting level")
	get_tree().change_scene_to_file("res://level.tscn")

func set_lockdown(value):
	locked_down = value
	if locked_down == false:
		current_lockdown_grace_timer = 0.2

func add_object_to_motion_tracking(object):
	motion_tracked_objects.append(object)

func remove_object_from_motion_tracking(object):
	motion_tracked_objects.erase(object)
