class_name SpawnObject
extends TileEntity

#var slime_prefab = preload("res://scenes/instantiable/tile entities/slime.tscn")
#var bat_prefab = preload("res://scenes/instantiable/tile entities/bat.tscn")




@onready var caveGen : CaveGenerator = get_parent().get_node("CaveGenerator")

func _on_start():
	world_tiles =  get_parent().get_node("WorldTiles")
	
	pass



func _on_turn(): 
	
	
	
	var enemy_list = [load("res://scenes/instantiable/tile entities/slime.tscn"), load("res://scenes/instantiable/tile entities/bat.tscn"), load("res://scenes/instantiable/tile entities/rat.tscn")]
	print("test 2")
	var spawn_enemy = enemy_list[randi()%(enemy_list.size())].instantiate()
	world_tiles.tile_entities.erase(tile_pos)
	spawn_enemy.world_tiles = world_tiles
	spawn_enemy.spawn_tile = tile_pos
	
	get_parent().get_parent().add_child.call_deferred(spawn_enemy)
	
	queue_free()
	
	pass
