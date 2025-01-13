extends Node2D

#const Player = preload("res://Player.tscn")
#const Exit = preload("res://ExitDoor.tscn")

var borders = Rect2(1, 1, 38, 21)

@onready var tileMap = get_parent().get_node("WorldTiles")

func _ready():
	randomize()
	generate_level()


func generate_level():

	var walker = Walker.new(Vector2(19, 11), borders)

	var map = walker.walk(500)

	#var player = Player.instantiate()
	#add_child(player)
	#player.position = map.front()*32
	
	#var exit = Exit.instantiate()
	#add_child(exit)
	#exit.position = walker.get_end_room().position*32
	#exit.connect("leaving_level", Callable(self, "reload_level"))

	walker.queue_free()

	

	for location in map:

		var walked = []

		walked.append(location)

		tileMap.set_cells_terrain_connect(walked, 0, 0)
		#print(tileMap)

		#await get_tree().create_timer(0.001).timeout

func reload_level():
	get_tree().reload_current_scene()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()
