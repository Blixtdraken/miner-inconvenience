extends TileEntity


func _on_damage(damage:int):
	world_tiles.tile_entities.erase(tile_pos)
	
	pass
