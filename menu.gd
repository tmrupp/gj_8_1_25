extends Control
@onready var level = $".."

func set_pause():
	
	level.process_mode = Node.PROCESS_MODE_DISABLED if visible else Node.PROCESS_MODE_INHERIT
	

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_pause()
	
func toggle ():
	visible = not visible
	$CanvasLayer.visible = visible
	set_pause()
	
	
func _input(event):
	if event.is_action_pressed("ESC"):
		#print("pressed")
		toggle()
