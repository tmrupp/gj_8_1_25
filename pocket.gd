extends Node3D

@onready var area = $Area3D

func _ready():
	area.connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	var entity = body.get_parent()
	if entity.is_in_group("balls"):
		if not entity.is_cue:
			entity.queue_free()
		else:
			body.linear_velocity = Vector3.ZERO
			# print("reseting position from=", entity.global_position, " to=", entity.start_position)
			body.global_position = entity.start_position
