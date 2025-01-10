extends TileEntity

@onready
var sprite:AnimatedSprite2D = get_node("Sprite")

@onready
var nav_agent:NavigationAgent2D = get_node("NavAgent")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	sprite.play("default")
	pass

func _process(delta: float) -> void:
	nav_agent.target_position = world_tiles.player_entity.global_position
	print(nav_agent.get_next_path_position())
	pass

func _on_turn():
	print("Turned")
	pass
