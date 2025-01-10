class_name WorldTiles
extends TileMapLayer


enum TileCheckData {FLOOR, BREAKABLE, BORDER, ENEMY}

var tile_entities:Dictionary = {}

var player_entity:TileEntity = null

func get_tile_entiteties()->Array[TileEntity]:
	var temp_array:Array[TileEntity] = []

	temp_array.assign(tile_entities.values())
	return temp_array

func get_entity_at_tile(tile_value:Vector2i)->TileEntity:
	return tile_entities.get(tile_value)
	pass
func trigger_turns():
	
	for entity in get_tile_entiteties():
		entity._on_turn()
		print("Turned for " + str(entity))
	pass
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func tile_check(tile_pos:Vector2i)->TileCheckData:
	
	if get_cell_source_id(tile_pos) == 2:

		erase_cell(tile_pos)
		return TileCheckData.BREAKABLE
		

	return TileCheckData.FLOOR
	
	
