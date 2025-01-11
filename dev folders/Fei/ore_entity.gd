extends TileEntity

class_name OreEntity

func _on_damage(damage:int):
	world_tiles.tile_entities.erase(tile_pos)
	
	var hole_scene:PackedScene = preload("res://scenes/instantiable/hole.tscn")
	
	var hole:HoleEntity = hole_scene.instantiate()
	hole.world_tiles = world_tiles
	hole.spawn_tile = tile_pos
	get_parent().add_child(hole)
	
	queue_free()
	pass
