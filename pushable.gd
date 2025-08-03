extends Node3D

func _ready():
	add_to_group("pushable")
	$Body.connect("body_entered", push)
	
func push (body):
	print("being pushed on by:", body)
