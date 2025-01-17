class_name CameraHandler
extends Camera2D

@export
var pixel_limit:float = 500

@export
var follow_speed:float = 10

@export var random_strength : float = 30
@export var shake_fade : float = 5

var shake_strength : float = 0.0

var rng = RandomNumberGenerator.new()

var functional_pos:Vector2 = Vector2.ZERO
func _process(delta):
	var zoom_level:float = get_viewport().size.x/GlobalSettings.pixel_limit
	zoom = Vector2(zoom_level, zoom_level)
	
	functional_pos = functional_pos.lerp(get_parent().global_position, delta*follow_speed)
	
	global_position = functional_pos.round()
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
	
	pass

func _screen_shake():
	shake_strength = random_strength

func _shake_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
	
