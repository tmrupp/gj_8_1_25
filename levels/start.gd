extends Button

func _pressed():
	$"..".visible = false
	$"/root/Main/Menu".toggle()
