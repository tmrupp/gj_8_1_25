extends Node2D

@export var velocity_haver : Node3D
@onready var animation_player: AnimationPlayer = $polly_back/polygons/sprite/AnimationPlayer

func _process(delta: float) -> void:
	if velocity_haver.velocity.length() > 1e-1:
		animation_player.play("polly_back")
	else:
		animation_player.play("RESET")
