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
	spawn_ore()


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
	var gem_amount = RandomNumberGenerator.new().randi_range(1,3)
	var metals_amount = RandomNumberGenerator.new().randi_range(2,5)
	var coal_amount = RandomNumberGenerator.new().randi_range(5,10)
	
	## HÄR FIXA TACK TACK JAG SKA GÖRA DET (LOUIE)
	
	print(gem_amount)
	
	for amount in gem_amount:
		
		print(amount)
		return
	
	
	
	pass
