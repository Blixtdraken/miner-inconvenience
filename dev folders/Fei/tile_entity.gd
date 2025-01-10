
class_name TileEntity
extends Node2D


@export
var world_tiles: WorldTiles
@export
var spawn_tile:Vector2i = Vector2.ZERO
@export
var tile_pos:Vector2i = Vector2.ZERO:
	get:
		return tile_pos
	set(value):
		world_tiles.tile_entities.erase(tile_pos)
		if !force_tile_pos:
			var check_data:WorldTiles.TileCheckData = world_tiles.tile_check(value)
			tile_pos = _on_try_walk(value, check_data)
		else:
			tile_pos = value
		world_tiles.tile_entities[tile_pos] = self
		update_tile_pos(tile_pos)

var force_tile_pos:bool = false

var pos_list:Array = []

func _enter_tree() -> void:
	if %WorldTiles:
		world_tiles = %WorldTiles
	world_tiles.tile_entities[spawn_tile] = self
	force_tile_pos = true
	tile_pos = spawn_tile
	force_tile_pos = false
	pass

func _on_try_walk(value:Vector2i, check_data:WorldTiles.TileCheckData) -> Vector2i:
	return value

func update_tile_pos(new_tile:Vector2i):
	global_position = world_tiles.map_to_local(new_tile)

func _on_turn():
	pass
