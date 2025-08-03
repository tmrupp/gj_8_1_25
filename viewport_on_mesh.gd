extends MeshInstance3D

@onready var sub_viewport: SubViewport = $"../SubViewport"
@onready var camera_3d: Camera3D = $"../ThirdPersonLocation/Camera3D"

func _ready() -> void:
	sub_viewport.set_clear_mode(SubViewport.CLEAR_MODE_ALWAYS)
	
	material_override.albedo_texture = sub_viewport.get_texture()

func _process(delta: float) -> void:
	rotation.x = camera_3d.rotation.x
