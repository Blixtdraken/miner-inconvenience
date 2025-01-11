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

@onready
var turn_wait_timer:Timer = get_node("TurnWait")
var waiting_for_turn:bool = true
func call_turns():
	
	for entity in get_tile_entiteties():
		entity._on_turn()
		#print("Turned for " + str(entity))
	pass
	waiting_for_turn = true
func trigger_turns():
	waiting_for_turn = false
	turn_wait_timer.start()
	pass
	

var astar:AStarGrid2D = AStarGrid2D.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	turn_wait_timer.timeout.connect(call_turns)
	var tilemap_size = get_used_rect().size
	var map_rect = Rect2i(Vector2i.ZERO,tilemap_size)
	
	var tile_size = tile_set.tile_size
	
	astar.region = get_used_rect()
	#astar.cell_size = tile_size
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.jumping_enabled = false
	astar.update()
	
	
	update_navmesh()
	
	pass # Replace with function body.


func update_navmesh():
	var tilemap_size = get_used_rect().size
	var map_rect = Rect2i(Vector2i.ZERO,tilemap_size)
	astar.region = get_used_rect()
	
	for i in get_used_rect().size.x:
		for j in get_used_rect().size.y:
			var coords = Vector2i(i, j) + get_used_rect().position
			var tile_data = get_cell_tile_data(coords)
			
			if tile_data and tile_data.get_custom_data("type") == "ground":
				
				
				astar.set_point_solid(coords, true)
			else:
				astar.set_point_solid(coords, false)
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func tile_check(tile_pos:Vector2i)->TileInfo:
	
	var tile_data:TileData = get_cell_tile_data(tile_pos)
	var tile_entity:TileEntity = get_entity_at_tile(tile_pos)
	
	return TileInfo.new(tile_pos, tile_entity, tile_data)

func destroy_tile():
	pass	
