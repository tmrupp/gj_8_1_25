extends Node3D

func load_level (level):
	print("reseting level to", level)
	var old = $Level
	remove_child(old)
	old.queue_free()
	
	var ins = level.instantiate()
	add_child(ins)
	$Menu._ready()
	# Use get_tree() to access the SceneTree's change_scene_to_packed method

func end(level):
	call_deferred("load_level", level)
