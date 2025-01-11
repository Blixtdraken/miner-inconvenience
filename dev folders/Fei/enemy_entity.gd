class_name EnemyEntity
extends TileEntity

var hp:int = 2

@onready
var sprite:AnimatedSprite2D = get_node("Sprite")

@onready
var nav_agent:NavigationAgent2D = get_node("NavAgent")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	sprite.global_position = global_position
	pass

func _on_try_walk(value:Vector2i, tile_info:TileInfo) -> Vector2i:
	print(TileInfo.TileType.keys()[tile_info])
	if  tile_info.tile_type == TileInfo.TileType.FLOOR:
		return value
	elif tile_info.tile_entity and tile_info.tile_entity is Player:
		print("HIT THE HTING")
		var player:Player = world_tiles.get_entity_at_tile(value)
		player._on_damage(1)
		sprite.play("attack")
		return tile_pos
		
	return tile_pos

var path_points:Array[Vector2i] = []

func _process(delta: float) -> void:
	queue_redraw()
	pass
	
func _draw() -> void:
	if !world_tiles:
		return
	
	var new_points:Array[Vector2] = []
	for point in path_points:
		var real_pos:Vector2 = world_tiles.map_to_local(point) - global_position
		draw_circle(real_pos, 1, Color.RED)
		new_points.insert(0,real_pos)

	if new_points.size() > 2:
		draw_polyline(new_points,Color.RED, 0.5)
	
	pass

func _on_turn():
	
	world_tiles.update_navmesh()
	#print("Slime Navigating")
	path_points = world_tiles.astar.get_id_path(
		tile_pos,
		world_tiles.player_entity.tile_pos
		)
	if path_points.size() > 2:
		var dir:Vector2 = path_points[1] - tile_pos
		dir = dir.normalized()
		tile_pos += dir as Vector2i
	elif path_points.size() > 1:
		var dir:Vector2 = path_points[1] - tile_pos
		dir = dir.normalized()
		tile_pos += dir as Vector2i
	#print(dir)
	pass

func _on_damage(damage:int):
	sprite.play("hurt")
	hp -= damage
	pass
