@tool
extends AnimatedSprite2D

@export
var speed:float = 200

@onready
var tail:Node2D = get_child(0)
@onready
var parent:Node2D = get_parent()
func _ready():
	global_position = parent.global_position
	play("right")
	pass

func _process(delta):
	var prev_pos:Vector2 = global_position
	global_position = global_position.lerp(get_parent().global_position, delta*speed)
	global_position = Vector2i(global_position+ Vector2.ONE*0.5)
	return
	var delta_vec:Vector2 = ( tail.global_position - global_position)
	(material as ShaderMaterial).set_shader_parameter("dir", delta_vec/64)
	(material as ShaderMaterial).set_shader_parameter("offset", delta_vec/2)
	pass
