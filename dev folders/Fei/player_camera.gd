class_name CameraHandler
extends Camera2D

@export
var pixel_limit:float = 500

@export
var follow_speed:float = 10

var functional_pos:Vector2 = Vector2.ZERO
func _process(delta):
	var zoom_level:float = get_viewport().size.x/GlobalSettings.pixel_limit
	zoom = Vector2(zoom_level, zoom_level)
	
	functional_pos = functional_pos.lerp(get_parent().global_position, delta*follow_speed)
	
	global_position = functional_pos.round()
	pass
