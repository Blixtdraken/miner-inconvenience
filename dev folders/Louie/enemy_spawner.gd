class_name EnemySpawner
extends Node2D




@export var worldTiles : WorldTiles
@export var caveGen : CaveGenerator

const slime_prefab = preload("res://scenes/instantiable/tile entities/slime.tscn")

var spawn_time : int = 0
var time_to_spawn : int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	
	_spawn_enemies()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
	

func _on_turn():
	if spawn_time>= time_to_spawn:
		_spawn_enemies()
		spawn_time = 0
		
	else:
		spawn_time+=1
	


func _spawn_enemies():
	
	## KAN TEKNISKT SÄTT BARA SPAWNA PÅ PREGENERATED AREAS, INTE DÄR DU GRÄVT RN
	randomize()
	## FIXA DET HÄR
	#caveGen.map
	#var spawn_x = RandomNumberGenerator.new().randi_range(1,38)
	#var spawn_y = RandomNumberGenerator.new().randi_range(1,21)
	
	var spawnpos_ = Vector2i(RandomNumberGenerator.new().randi_range(1,38), RandomNumberGenerator.new().randi_range(1,21))
	
	while (worldTiles.tile_check(Vector2i(spawnpos_)).tile_type != TileInfo.TileType.FLOOR) || (worldTiles.tile_check(Vector2i(spawnpos_)).tile_entity != null):
		spawnpos_ = Vector2i(RandomNumberGenerator.new().randi_range(1,38), RandomNumberGenerator.new().randi_range(1,21))
		print("test")
	#tile_check(Vector2i(spawn_x, spawn_y)).tile_type == tile_check(tile_pos).TileType.GROUND
		pass
	
	#var rand_index:int = randi() % caveGen.map.size()
	
	if (worldTiles.tile_check(Vector2i(spawnpos_)).tile_type == TileInfo.TileType.FLOOR) || (worldTiles.tile_check(Vector2i(spawnpos_)).tile_entity == null):
		var slime_enemy = slime_prefab.instantiate()
		slime_enemy.world_tiles = worldTiles
		slime_enemy.spawn_tile = spawnpos_
	
		get_parent().add_child.call_deferred(slime_enemy)
		

	
	
	
	
	pass
