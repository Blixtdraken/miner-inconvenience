class_name SpawnObject
extends TileEntity

#var slime_prefab = preload("res://scenes/instantiable/tile entities/slime.tscn")
#var bat_prefab = preload("res://scenes/instantiable/tile entities/bat.tscn")



@onready var worldTiles : WorldTiles = get_parent().get_node("WorldTiles")
@onready var caveGen : CaveGenerator = get_parent().get_node("CaveGenerator")

#func _ready():
#	randomize()
	
#	pass



func _on_turn(): 
	
	
	var enemy_list = [load("res://scenes/instantiable/tile entities/slime.tscn"), load("res://scenes/instantiable/tile entities/bat.tscn")]
	print("test 2")
	var spawn_enemy = enemy_list[randi()%(enemy_list.size())].instantiate()
	
	spawn_enemy.world_tiles = worldTiles
	spawn_enemy.spawn_tile = worldTiles.map_to_local(self.position)
	
	get_parent().add_child.call_deferred(spawn_enemy)
	
	#self.queue_free()
	
	pass
