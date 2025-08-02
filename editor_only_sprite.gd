@tool
extends Sprite3D

func _ready() -> void:
	if Engine.is_editor_hint():
		show()
	else:
		hide()
