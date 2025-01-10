class_name WorldTiles
extends TileMapLayer


enum TileCheckData {FLOOR, BREAKABLE, BORDER, ENEMY, PLAYER}

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
		#print("Turned for " + str(entity))
	pass
	

var astar:AStarGrid2D = AStarGrid2D.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var tilemap_size = get_used_rect().end - get_used_rect().position
	var map_rect = Rect2i(Vector2i.ZERO, tilemap_size)
	
	var tile_size = tile_set.tile_size
	
	astar.region = get_used_rect()
	astar.cell_size = tile_size
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	
	for i in tilemap_size.x:
		for j in tilemap_size.y:
			var coords = Vector2i(i, j)
			var tile_data = get_cell_tile_data(coords)
			if tile_data and tile_data.get_custom_data("wall") == true:
				astar.set_point_solid(coords)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func tile_check(tile_pos:Vector2i)->TileCheckData:
	
	if get_cell_source_id(tile_pos) == 2:

		erase_cell(tile_pos)
		return TileCheckData.BREAKABLE
	
	var tile_entity:TileEntity = get_entity_at_tile(tile_pos)

	if tile_entity:
		print("Found Tile Entity")
		print(tile_entity)
		match tile_entity.get_script():
			EnemyEntity:
				return TileCheckData.ENEMY
			Player:
				return TileCheckData.PLAYER
		
		

	return TileCheckData.FLOOR
	
	
