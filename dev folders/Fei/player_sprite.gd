@tool
extends EntityAnimatedSprite


@export
var speed:float = 15

@onready
var parent:Node2D = get_parent()

var functional_pos:Vector2 = Vector2.ZERO

func _setup():
	functional_pos = parent.global_position
	pass
func _ready():
	functional_pos = parent.global_position
	play("default")
	animation_finished.connect(animation_stopped)
	pass
func animation_stopped():
	play("default")
	pass

func _process(delta):
	
	var prev_pos:Vector2 = global_position
	functional_pos = functional_pos.lerp(get_parent().global_position, delta*speed)
	
	global_position = functional_pos.round()
	return
	pass
