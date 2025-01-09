class_name CameraHandler
extends Camera2D

@export
var pixel_limit:float = 500

func _process(delta):
	var zoom_level:float = get_viewport().size.x/pixel_limit
	zoom = Vector2(zoom_level, zoom_level)
	pass
