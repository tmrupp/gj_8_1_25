extends Node3D

@onready var area = $Area3D
@onready var level = $/root/Main/Level

func _ready():
	area.connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	var entity = body.get_parent()
	if entity.is_in_group("balls"):
		if not entity.is_cue:
			if entity.is_8_ball:
				level.call_deferred("end")
				# print("hooray you win")
			level.remove_object_from_motion_tracking(body)
			entity.queue_free()
		else:
			body.linear_velocity = Vector3.ZERO
			# print("reseting position from=", entity.global_position, " to=", entity.start_position)
			body.global_position = entity.start_position
