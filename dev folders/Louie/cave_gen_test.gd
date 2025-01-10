extends Node2D


const TESTTILE = Vector2i(1,1)



@export var tileMap : TileMapLayer
#@onready var tileMap = get_node("TileMapLayer")
@export var camera : Camera2D


@onready var levelMaker : LevelMaker = LevelMaker.new()


func _input(event:InputEvent)->void:

	if event.is_action_pressed("ui_accept"):
		print(tileMap)
		get_viewport().set_input_as_handled()
		make_level()
		return
	if event.is_action_pressed("ui_up"):
		get_viewport().set_input_as_handled()
		camera.zoom *= 2
		pass
	if event.is_action_pressed("ui_down"):
		get_viewport().set_input_as_handled()
		camera.zoom /=2
		pass
	


func make_level()-> void:
	tileMap.clear()
	
	for tile in levelMaker.make_level():
		tileMap.set_cell(tile, 0, TESTTILE)
		
