extends HSlider

func _ready():
	value = 75
	connect("value_changed", dragged)

func dragged(val):
	value = val
	$/root/Main/Music.volume_db =  linear_to_db(val/100.0)
	
