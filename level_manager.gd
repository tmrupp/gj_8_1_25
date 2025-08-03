extends Node3D

var locked_down : bool = true
var current_lockdown_grace_timer : float = 0

var motion_tracked_objects = []
var all_audio_clips : Array[Node] = []

func _ready() -> void:
	all_audio_clips = $Audio.find_children("Sound*")
	
func _process(delta: float) -> void:
	current_lockdown_grace_timer -= delta
	if not locked_down and not current_lockdown_grace_timer > 0:
		var at_least_one_moving_object = false
		for object in motion_tracked_objects:
			if object.linear_velocity.length() > 1e-1:
				at_least_one_moving_object = true
		if not at_least_one_moving_object:
			set_lockdown(true)
			#print("locking down")

func report_player_foul():
	#print("Foul: player touched a ball directly")
	pass

func set_lockdown(value):
	locked_down = value
	if locked_down == false:
		current_lockdown_grace_timer = 0.2

func add_object_to_motion_tracking(object):
	motion_tracked_objects.append(object)

func remove_object_from_motion_tracking(object):
	motion_tracked_objects.erase(object)

func play_sound_ball_hit(_other):
	all_audio_clips[randi_range(0, len(all_audio_clips) - 1)].play()
