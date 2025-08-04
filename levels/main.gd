extends Node3D

var current_level = 0
var current_strokes = 0
@onready var menu = $Menu
@onready var level_container = $Menu/CanvasLayer/VBoxContainer/GridContainer
@onready var current_stroke_label = $HUD/CanvasLayer/HBoxContainer/CurrentStroke

func add_stroke ():
	current_strokes += 1
	current_stroke_label.text = "Stroke: " + str(current_strokes)

func load_level (level):
	print("reseting level to", level)
	current_strokes = 0
	current_stroke_label.text = "Stroke: " + str(current_strokes)
	var old = $Level
	remove_child(old)
	old.queue_free()
	
	var ins = level.instantiate()
	add_child(ins)
	$Menu._ready()
	# Use get_tree() to access the SceneTree's change_scene_to_packed method

func _input(event):
	if event.is_action_pressed("SPACE"):
		complete()

func complete():
	var button = level_container.levels[current_level]
	if current_strokes < button.strokes:
		button.strokes = current_strokes
	button.render()
	current_level = (current_level + 1) % len(level_container.levels)
	load_level(level_container.levels[current_level].next_level)

func end(level):
	call_deferred("load_level", level)
