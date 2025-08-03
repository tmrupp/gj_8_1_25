extends Node3D

var locked_down : bool = true

func report_player_foul():
	print("Foul: player touched a ball directly")
	
func end ():
	print("reseting level")
	get_tree().change_scene_to_file("res://level.tscn")
