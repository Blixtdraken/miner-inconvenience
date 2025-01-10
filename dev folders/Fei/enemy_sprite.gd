@tool
extends AnimatedSprite2D


@export
var speed:float = 15

@onready
var parent:Node2D = get_parent()

var functional_pos:Vector2 = Vector2.ZERO
func _ready():
	#global_position = parent.global_position
	play("default")
	pass

func _process(delta):
	var prev_pos:Vector2 = global_position
	functional_pos = functional_pos.lerp(get_parent().global_position, delta*speed)
	
	global_position = functional_pos.round()
	return
	pass
