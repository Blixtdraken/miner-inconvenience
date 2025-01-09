
class_name TileEntity
extends Node2D


@export
var walking_tile_map: WorldTiles

var spawn_tile:Vector2 = Vector2.ZERO
@export
var tile_pos:Vector2i = Vector2.ZERO:
	get:
		return tile_pos
	set(value):
		var check_data:WorldTiles.TileCheckData = walking_tile_map.tile_check(value)
		tile_pos = _on_try_walk(value, check_data)
		update_tile_pos(tile_pos)
var pos_list:Array = []

func _on_try_walk(value:Vector2i, check_data:WorldTiles.TileCheckData) -> Vector2i:
	return value

func update_tile_pos(new_tile:Vector2i):
	global_position = walking_tile_map.map_to_local(new_tile)
