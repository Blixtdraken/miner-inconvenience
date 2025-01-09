@tool
extends CharacterBody2D

@export
var distance_to_move:float = 180
@export
var debug_render: bool:
	get:
		return debug_render
	set(value):
		queue_redraw()
		debug_render = value
		pos_list.append(global_position)
@export
var walking_tile_map: WorldTiles

var pressing:bool = false

var start_finger_pos:Vector2 = Vector2.ZERO

var waiting_on_release:bool = false

var current_finger_pos:Vector2 = Vector2.ZERO

var spawn_tile:Vector2 = Vector2.ZERO
@onready
var player_sprite:AnimatedSprite2D = get_node("PlayerSprite")




var tile_pos:Vector2i = Vector2.ZERO:
	get:
		return tile_pos
	set(value):
		if walking_tile_map.tile_check(value):
			tile_pos = value
			update_tile_pos(value)
		

var pos_list:Array = []

func _set(property:StringName, value) -> bool:
	print(property)
	if property == "global_position":
		print(global_position)
		value = value as Vector2
		tile_pos = walking_tile_map.local_to_map(value)
	return true

func _draw():
	
	if !debug_render or Engine.is_editor_hint():
		pos_list.clear()
		return
	
	var delta_vec:Vector2 = (current_finger_pos-start_finger_pos)
	
	var cirlce_color:Color = Color.RED
	if pressing:
		cirlce_color = Color.GREEN
		if waiting_on_release:
			cirlce_color = Color.AQUA
		
	
	draw_line(Vector2.ZERO, Vector2.ZERO + delta_vec, Color.GREEN)
	draw_circle(Vector2.ZERO, distance_to_move, cirlce_color , false)
	draw_circle(walking_tile_map.map_to_local(spawn_tile)-global_position, 10, Color.AQUA*Color(1,1,1,0.5), true)
	
	var new_list:PackedVector2Array
	
	if pos_list.size() == 10:
		pos_list.remove_at(0)
	for pos in pos_list:
		pos = pos as Vector2
		new_list.append(pos-global_position)
		draw_circle(pos-global_position, 3, Color.GREEN)
	
	draw_polyline(new_list,Color.GREEN)
	pass
func _ready():
	if Engine.is_editor_hint():
		return
	update_tile_pos(Vector2.ZERO)
	pass
func _process(delta):
	if Engine.is_editor_hint():
		return
	if !debug_render:
		return
	queue_redraw()
	
func update_tile_pos(new_tile:Vector2i):
	
	global_position = walking_tile_map.map_to_local(new_tile)
	if debug_render:
		pos_list.append(global_position)
	print("Pos: " + str(tile_pos))
	pass
func _input(event):
	if Engine.is_editor_hint():
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
			
			
			print("Vel: " + str(vec))
			
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
		player_sprite.flip_h = false
	elif dir.x == -1:
		#player_sprite.play("left")
		player_sprite.flip_h = true
	pass
	
		
		
	
