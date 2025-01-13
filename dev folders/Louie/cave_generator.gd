extends Node2D

#const Player = preload("res://Player.tscn")
#const Exit = preload("res://ExitDoor.tscn")

var borders = Rect2(1, 1, 38, 21)

const Player = preload("res://scenes/instantiable/tile entities/player.tscn")
@onready var _player : Player = get_parent().get_node("Player")
@onready var tileMap : WorldTiles = get_parent().get_node("WorldTiles")

func _ready():
	
	randomize()
	generate_level()
	#spawn_ore()
	
	_generate_ore(2, preload("res://scenes/instantiable/ores/gem.tscn"))
	_generate_ore(5, preload("res://scenes/instantiable/ores/metal.tscn"))
	_generate_ore(10, preload("res://scenes/instantiable/ores/coal.tscn"))


func generate_level():

	var walker = Walker.new(Vector2(19, 11), borders)

	var map = walker.walk(500)


### DE HÄR 2 ÄR KVAR "just in case" från tutorialen. ta bort nån gång
	#var player = Player.instantiate()
	#getparentadd_child(player)
	#player.position = map.front()*32
	
	#var exit = Exit.instantiate()
	#add_child(exit)
	#exit.position = walker.get_end_room().position*32
	#exit.connect("leaving_level", Callable(self, "reload_level"))

	
	walker.queue_free()

	

	for location in map:

		var walked = []
		
		#print(size)
		
		
		walked.append(location)
		
		tileMap.destroy_tile(location)
		
		_player.tile_pos = location
		## IFALL DU VILL KUNNA SE DEN GENERERAS
		#await get_tree().create_timer(0.0001).timeout

func reload_level():
	get_tree().reload_current_scene()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()
		
		
func spawn_ore():
	var ore_amount = RandomNumberGenerator.new().randi_range(111,202)
	var metals_amount = RandomNumberGenerator.new().randi_range(2,5)
	var coal_amount = RandomNumberGenerator.new().randi_range(5,10)
	
	## HÄR FIXA TACK TACK JAG SKA GÖRA DET (LOUIE)
	
	print(_int_to_array(0,ore_amount)+3)
	print(_int_to_array(1,ore_amount)+5)
	print(_int_to_array(2,ore_amount)+7)
	#print(gem_amount)
	var test =1
	for amount in range(_int_to_array(0,ore_amount)+3):
		var gem_scene : PackedScene = preload("res://scenes/instantiable/ores/gem.tscn")
		
		var ore_x = RandomNumberGenerator.new().randi_range(1,38)
		var ore_y = RandomNumberGenerator.new().randi_range(1,21)
		
		var gem : OreEntity = gem_scene.instantiate()
		gem.world_tiles = tileMap
		gem.spawn_tile = Vector2i(ore_x, ore_y)
		get_parent().add_child.call_deferred(gem)
		test +=1
	
	
	pass
	
	
	
func _int_to_array(index, temp):
	return int(str(temp)[index])

	#print(_int_to_array(1, 123)) # prints 2

func _generate_ore(amount_modifier, type):
	var ore_amount = RandomNumberGenerator.new().randi_range(0,3)
	
	for amount in range(ore_amount+amount_modifier):
		
		
		var ore_x = RandomNumberGenerator.new().randi_range(1,38)
		var ore_y = RandomNumberGenerator.new().randi_range(1,21)
		
		
		#var tile_info:TileInfo = tileMap.tile_check(Vector2i(ore_x, ore_y))
		
		##while tile_info.tile_type != TileInfo.TileType.GROUND || tile_info.tile_type != TileInfo.TileType.NULL :
			
			##ore_x = RandomNumberGenerator.new().randi_range(1,38)
			##ore_y = RandomNumberGenerator.new().randi_range(1,21)
			
			##tile_info = tileMap.tile_check(Vector2i(ore_x, ore_y))
			
			##return
		
		##if tile_info.tile_type == TileInfo.TileType.GROUND || tile_info.tile_type == TileInfo.TileType.NULL :
		tileMap.destroy_tile(Vector2i(ore_x, ore_y))
		
		var instantiated_ore : OreEntity = type.instantiate()
		instantiated_ore.world_tiles = tileMap
		instantiated_ore.spawn_tile = Vector2i(ore_x, ore_y)
		
		
		get_parent().add_child.call_deferred(instantiated_ore)
		
		
		
		

		

	return
