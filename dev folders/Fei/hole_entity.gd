extends TileEntity

class_name HoleEntity
@onready
var sprite:AnimatedSprite2D = get_node("Sprite")

func _on_start():
	sprite.play("break")
	pass
