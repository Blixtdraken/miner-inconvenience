class_name EnemyEntity
extends TileEntity

@onready
var sprite:AnimatedSprite2D = get_node("Sprite")

@onready
var nav_agent:NavigationAgent2D = get_node("NavAgent")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	sprite.global_position = global_position
	pass

func _on_try_walk(value:Vector2i, check_data:WorldTiles.TileCheckData) -> Vector2i:
	#print(WorldTiles.TileCheckData.keys()[check_data])
	if  check_data == WorldTiles.TileCheckData.FLOOR:
		return value
		
	return tile_pos

var path_points:Array[Vector2i] = []

func _process(delta: float) -> void:
	queue_redraw()
	pass
	
func _draw() -> void:
	if !world_tiles:
		return
	
	var new_points:Array[Vector2i] = []
	for point in path_points:
		var real_pos:Vector2 = world_tiles.map_to_local(point) - global_position
		draw_circle(real_pos, 1, Color.RED)
		new_points.append(real_pos)
	if new_points.size() > 2:
		draw_polyline(new_points,Color.RED)
	
	pass

func _on_turn():
	
	#print("Slime Navigating")
	path_points = world_tiles.astar.get_id_path(
		tile_pos,
		world_tiles.player_entity.tile_pos
		)
	print(path_points)
	var dir:Vector2 = nav_agent.get_next_path_position() - global_position
	dir = dir.normalized()
	return
	tile_pos += dir as Vector2i
	#print(dir)
	pass
