class_name Player
extends TileEntity

var hp:int = 3
@export
var distance_to_move:float = 180

var pressing:bool = false

var start_finger_pos:Vector2 = Vector2.ZERO

var waiting_on_release:bool = false

var current_finger_pos:Vector2 = Vector2.ZERO


@onready
var player_sprite:AnimatedSprite2D = get_node("Sprite")



func _on_try_walk(value:Vector2i, tile_info:TileInfo) -> Vector2i:
	
	if tile_info.tile_entity:
		if tile_info.tile_entity is EnemyEntity:
			var enemy: EnemyEntity = world_tiles.get_entity_at_tile(value)
			player_sprite.play("attack")
			enemy._on_damage(1)
		return tile_pos
		pass
	
	if tile_info.tile_type == TileInfo.TileType.FLOOR:
		return value
	elif tile_info.tile_type == TileInfo.TileType.GROUND:
		print("Wowie")
		world_tiles.destroy_tile(value)
		return tile_pos
		
	return tile_pos

func _on_after_walked(value:Vector2i,  tile_info:TileInfo):
	if tile_info.tile_type != TileInfo.TileType.BORDER:	
		world_tiles.trigger_turns()
	pass

func _on_damage(damage:int):
	player_sprite.play("hurt")
	pass

func _ready():
	world_tiles.player_entity = self
	player_sprite.global_position = global_position
	pass
func _input(event):
	if !world_tiles.waiting_for_turn:
		return
	if event is InputEventScreenTouch:
		event = event as InputEventScreenTouch
		if event.is_pressed():
			start_finger_pos = event.position
			current_finger_pos = start_finger_pos
			pressing = true
		elif event.is_released():
			start_finger_pos = Vector2.ZERO
			current_finger_pos = Vector2.ZERO
			pressing = false
			waiting_on_release = false
		
	elif event is InputEventScreenDrag:
		event = event as InputEventScreenDrag
		current_finger_pos = event.position
		
		
		var delta_vec:Vector2 = (current_finger_pos-start_finger_pos)
		if delta_vec.length() >= distance_to_move and !waiting_on_release:
			waiting_on_release = true
			
			
			var vec:Vector2 = Vector2.from_angle(snappedf(delta_vec.angle(), PI / 2))
			
			
		
			
			tile_pos += Vector2i(vec)
			change_player_direction(vec)
		pass
	
	elif Input.get_vector("ui_left","ui_right","ui_up","ui_down") !=  Vector2.ZERO:
		var dir:Vector2i = Vector2.ZERO
		
		if Input.is_action_just_pressed("ui_left"):
			dir = Vector2i.LEFT
		elif Input.is_action_just_pressed("ui_right"):
			dir = Vector2i.RIGHT
		elif Input.is_action_just_pressed("ui_up"):
			dir = Vector2i.UP
		elif Input.is_action_just_pressed("ui_down"):
			dir = Vector2i.DOWN
		
		if dir != Vector2i.ZERO:
			tile_pos += Vector2i(dir)
		change_player_direction(dir)
			

func change_player_direction(dir:Vector2):
	dir = dir.round()
	if dir.x == 1:
		#player_sprite.play("right")
		player_sprite.scale.x = 1
	elif dir.x == -1:
		#player_sprite.play("left")
		player_sprite.scale.x = -1
	pass
	
		
		
	
