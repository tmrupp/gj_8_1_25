extends GridContainer

@onready var levels = get_children()
@onready var stroke_label = $"../HBoxContainer/Label2"

func render ():
	var total_strokes = 0
	for level in levels:
		total_strokes += level.strokes
	
	if total_strokes < 10000:
		stroke_label.text = "Total Strokes: " + str(total_strokes)
