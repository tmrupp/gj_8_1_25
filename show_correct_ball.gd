@tool
extends Node3D

@onready var ball: Node3D = $"../../.."
var children = []
var held_visible_index = -1

func _ready():
	children = get_children()
	fixup_ball()

func _process(delta) -> void:
	if Engine.is_editor_hint():
		fixup_ball()


func fixup_ball():
	if held_visible_index != ball.ball_number:
		for i in range(len(children)):
			if i == ball.ball_number:
				children[i].show()
			else:
				children[i].hide()
		held_visible_index = ball.ball_number
