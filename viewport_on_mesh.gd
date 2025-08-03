extends MeshInstance3D

@onready var sub_viewport: SubViewport = $"../SubViewport"

func _ready() -> void:
	sub_viewport.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)
	
	material_override.albedo_texture = sub_viewport.get_texture()
