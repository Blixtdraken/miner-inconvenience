
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
		
		var old_pos:Vector2i = tile_pos
		var tile_info:TileInfo
		if !force_tile_pos:
			tile_info = world_tiles.tile_check(value)
			tile_pos = _on_try_walk(value, tile_info)
		else:
			tile_pos = value
		if old_pos != tile_pos:
			world_tiles.tile_entities.erase(old_pos)
			world_tiles.tile_entities[tile_pos] = self
		update_tile_pos(tile_pos)
		if !force_tile_pos:
			_on_after_walked(tile_pos, tile_info)

var force_tile_pos:bool = true



func _ready() -> void:
	
	##if %WorldTiles:
	##	world_tiles = %WorldTiles
	if world_tiles:
		world_tiles.tile_entities[spawn_tile] = self
		force_tile_pos = true
		tile_pos = spawn_tile
		force_tile_pos = false
	pass
	_on_start()

func _on_start():
	pass
func _on_try_walk(value:Vector2i, tile_info:TileInfo) -> Vector2i:
	return value
func _on_after_walked(value:Vector2i, tile_info:TileInfo):
	pass
func update_tile_pos(new_tile:Vector2i):
	global_position = world_tiles.map_to_local(new_tile)

func _on_turn():
	pass

func _on_damage(damage:int):
	pass

func kill():
	world_tiles.tile_entities.erase(tile_pos)
	GlobalScore.amount_killed+=1
	queue_free()
	pass
