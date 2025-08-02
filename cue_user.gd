extends Node

@onready var cue: StaticBody3D = $"../Cue"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		cue.shoot()
