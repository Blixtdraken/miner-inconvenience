extends TileEntity

@export var ore_value : int

func _on_damage(damage:int):
	
	GlobalScore.collected_ore+=ore_value
	print(GlobalScore.collected_ore) #TEST
	world_tiles.tile_entities.erase(tile_pos)
	
	pass
