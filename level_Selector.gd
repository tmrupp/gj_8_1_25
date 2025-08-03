extends GridContainer

@onready var levels = [$Button, $Button2, $Button3, $Button4, $Button5, $Button6, $Button7, $Button8, $Button9]
@onready var stroke_label = $"../HBoxContainer/Label2"

func render ():
	var total_strokes = 0
	for level in levels:
		total_strokes += level.strokes
	
	if total_strokes < 10000:
		stroke_label.text = "Total Strokes: " + str(total_strokes)
