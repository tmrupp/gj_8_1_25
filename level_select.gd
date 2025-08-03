extends Button

@export var next_level: PackedScene
@onready var main = $/root/Main

func _pressed():
	main.end(next_level)
