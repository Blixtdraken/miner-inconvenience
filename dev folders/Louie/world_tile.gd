class_name WorldTiles
extends TileMapLayer


enum TileCheckData {FLOOR, BREAKABLE, BORDER, ENEMY}

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
	
	
