extends AnimatedSprite2D

@onready
var player_sprite:AnimatedSprite2D = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	flip_h = !player_sprite.flip_h
	pass
