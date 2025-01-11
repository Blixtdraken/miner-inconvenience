extends TileEntity
class_name OreEntity


@export var ore_value : int



func _on_damage(damage:int):
	
	GlobalScore.collected_ore+=ore_value
	print(GlobalScore.collected_ore) #TEST
	world_tiles.tile_entities.erase(tile_pos)
	
	var hole_scene:PackedScene = preload("res://scenes/instantiable/hole.tscn")
	
	var hole:HoleEntity = hole_scene.instantiate()
	hole.world_tiles = world_tiles
	hole.spawn_tile = tile_pos
	get_parent().add_child(hole)
	
	queue_free()
	pass
