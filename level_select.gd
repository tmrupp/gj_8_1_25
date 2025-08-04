extends Button

@export var next_level: PackedScene
@onready var main = $/root/Main
@onready var container = $".."

var strokes = 10000000
@onready var title = text

func render ():
	text = title + " Strokes: " + str(strokes)
	container.render()

func _pressed():
	main.end(self)
