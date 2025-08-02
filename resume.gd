extends Button
@onready var menu = $"../../../.."
func _pressed() -> void:
	menu.toggle()
