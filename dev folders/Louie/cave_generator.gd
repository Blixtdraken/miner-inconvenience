class_name CaveGenerator
extends Node2D

#const Player = preload("res://Player.tscn")
#const Exit = preload("res://ExitDoor.tscn")

var borders = Rect2(1, 1, 38, 21)

const PlayerPrefab = preload("res://scenes/instantiable/tile entities/player.tscn")
#@onready var _player : Player = get_parent().get_node("Player")
@onready var tileMap : WorldTiles = get_parent().get_node("WorldTiles")

@export var land_sound : AudioStreamPlayer

var map : Array
var player_spawn_pos : Vector2i
var gen_finished : bool
var hole_chosen : bool

var instantiated_ore : OreEntity

func _ready():
	
	
	gen_finished=false
	hole_chosen=false
	randomize()
	generate_level()
	
	
	#spawn_ore()
	
	


func generate_level():

	var walker = Walker.new(Vector2(19, 11), borders)

	map = walker.walk(500)
	
	walker.queue_free()

	for location in map:

		var walked = []
		
		#print(size)
		
		
		walked.append(location)
		
		tileMap.destroy_tile(location)
		
		#_player.tile_pos = location
		## IFALL DU VILL KUNNA SE DEN GENERERAS


	_generate_ore(2, preload("res://scenes/instantiable/ores/gem.tscn"))
	_generate_ore(5, preload("res://scenes/instantiable/ores/metal.tscn"))
	_generate_ore(10, preload("res://scenes/instantiable/ores/coal.tscn"))
	
	_spawn_player()
	land_sound.play(0)
	
	GlobalScore.floor+=1

func reload_level():
	get_tree().reload_current_scene()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()
		
		

func _generate_ore(amount_modifier, type):
	var ore_amount = RandomNumberGenerator.new().randi_range(0,3)
	
	for amount in range(ore_amount+amount_modifier):
		
		
		var ore_x = RandomNumberGenerator.new().randi_range(1,38)
		var ore_y = RandomNumberGenerator.new().randi_range(1,21)
		
		var hole_chance = RandomNumberGenerator.new().randi_range(1,amount_modifier)
		
		
		while tileMap.tile_check(Vector2i(ore_x, ore_y)).tile_entity != null:
			print(tileMap.tile_check(Vector2i(ore_x, ore_y)).tile_entity)
			ore_x = RandomNumberGenerator.new().randi_range(1,38)
			ore_y = RandomNumberGenerator.new().randi_range(1,21)
			
			
		
		if tileMap.tile_check(Vector2i(ore_x, ore_y)).tile_entity == null:
			
			print("ore spawn: ",tileMap.tile_check(Vector2i(ore_x, ore_y)).tile_entity)
			tileMap.destroy_tile(Vector2i(ore_x, ore_y))
		
			instantiated_ore = type.instantiate()
			instantiated_ore.world_tiles = tileMap
			instantiated_ore.spawn_tile = Vector2i(ore_x, ore_y)
			
			#print(tileMap.tile_check(Vector2i(ore_x, ore_y)).tile_entity)	
			instantiated_ore._ready()
			
			if hole_chance == 1 && hole_chosen != true:
				instantiated_ore.has_hidden_hole = true
				hole_chosen = true
			
			
			get_parent().add_child.call_deferred(instantiated_ore)
			
			
				
		
	if hole_chosen != true && amount_modifier == 10:
		instantiated_ore.has_hidden_hole = true
		hole_chosen = true
	return


func _spawn_player():
	
	
	player_spawn_pos = Vector2i(RandomNumberGenerator.new().randi_range(1,38), RandomNumberGenerator.new().randi_range(1,21))
	
	while (tileMap.tile_check(Vector2i(player_spawn_pos)).tile_type != TileInfo.TileType.FLOOR) || tileMap.tile_check(Vector2i(player_spawn_pos)).tile_entity != null:
		
		player_spawn_pos = Vector2i(RandomNumberGenerator.new().randi_range(1,38), RandomNumberGenerator.new().randi_range(1,21))
		pass
	
	
	if (tileMap.tile_check(Vector2i(player_spawn_pos)).tile_type == TileInfo.TileType.FLOOR) || (tileMap.tile_check(Vector2i(player_spawn_pos)).tile_entity == null):
		var _player = PlayerPrefab.instantiate()
		_player.world_tiles = tileMap
		_player.spawn_tile = player_spawn_pos
	
		get_parent().add_child.call_deferred(_player)
	
	pass
