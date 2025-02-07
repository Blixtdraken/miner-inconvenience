class_name Player
extends TileEntity

#var hp:int = 3
@export
var distance_to_move:float = 180

var pressing:bool = false

var start_finger_pos:Vector2 = Vector2.ZERO

var waiting_on_release:bool = false

var current_finger_pos:Vector2 = Vector2.ZERO

## SOUND EFFECTS
@export var dig_sound : AudioStreamPlayer
@export var dmg_sound : AudioStreamPlayer
@export var move_sound : AudioStreamPlayer
@export var fall_sound : AudioStreamPlayer
@export var ore_sound : AudioStreamPlayer
@export var hurt_sound : AudioStreamPlayer





@export var _camera : Camera2D

@export var tool : AnimatedSprite2D


@onready
var player_sprite:PlayerSprite = get_node("Sprite")

@onready var game_over_ui : Control = get_parent().get_node("game_hud/GameOverUI")


enum TileEventStatus {
	IDLE,
	WAITING,
	RUNNING
}

var tile_event_status:TileEventStatus = TileEventStatus.IDLE

var tile_event_entity:HoleEntity
func _on_try_walk(value:Vector2i, tile_info:TileInfo) -> Vector2i:
	
	if tile_info.tile_entity:
		if tile_info.tile_entity is HoleEntity:
			tile_event_entity = tile_info.tile_entity
			tile_event_status = TileEventStatus.WAITING
			global_position = world_tiles.local_to_map(value)
			return value
		var enemy: TileEntity = world_tiles.get_entity_at_tile(value)
		player_sprite.play("attack")
		enemy._on_damage(1)
		tool.play("pickaxe")
		if tile_info.tile_entity is OreEntity:
			_camera._screen_shake(3)
			ore_sound.play(0)
			#dig_sound.play(0)
		if tile_info.tile_entity is EnemyEntity:
			_camera._screen_shake(1)
			dmg_sound.play(0)
		
		
		
		return tile_pos
		pass
	
	if tile_info.tile_type == TileInfo.TileType.FLOOR:
		move_sound.play(0)
		return value
	elif tile_info.tile_type == TileInfo.TileType.GROUND:
		print("Wowie")
		world_tiles.destroy_tile(value)
		
		_camera._screen_shake(3)
		tool.play("pickaxe")
		dig_sound.play(0)
		var instance = load("res://scenes/instantiable/ores/ore_particles/wall_particles.tscn").instantiate()
		get_parent().add_child(instance)
		instance.global_position = world_tiles.map_to_local(value)
		return tile_pos
	elif tile_info.tile_type == TileInfo.TileType.BORDER:
		return tile_pos
		
	return tile_pos

func _on_after_walked(value:Vector2i,  tile_info:TileInfo):
	if tile_info.tile_type != TileInfo.TileType.BORDER:	
		
		if tile_info.tile_entity and tile_info.tile_entity is HoleEntity:
			pass
		else:
			world_tiles.trigger_turns()
	pass

func _on_damage(damage:int):
	GlobalHealth.player_hp -= 1
	player_sprite.play("hurt")
	hurt_sound.play(0)
	
	_camera._screen_shake(5)
	if GlobalHealth.player_hp <= 0:
		kill()
	pass
	
func kill():
	player_sprite.manual_control = true
	player_sprite.animation_finished.connect(tile_event_finished)
	
	
	
	print("YOU DIED. YOU GOT TO FLOOR ", GlobalScore.floor, " AND COLLECTED ", GlobalScore.collected_ore, " GOLD")
	
	#GlobalHealth.player_hp = 3
	#GlobalScore.collected_ore = 0
	#GlobalScore.floor = 0
	#GlobalScore.amount_killed = 0
	
	player_sprite.play("death")
	pass

func _on_start():
	world_tiles.player_entity = self
	player_sprite.global_position = global_position
	pass
func _input(event):
	if GlobalHealth.player_hp > 0:
		if !world_tiles.waiting_for_turn or tile_event_status != TileEventStatus.IDLE:
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
	
		
func _process(delta: float) -> void:
	if tile_event_status == TileEventStatus.WAITING:
		
		if player_sprite.global_position.distance_to(global_position) == 0:
			tile_event_status = TileEventStatus.RUNNING
			
			if tile_event_entity is HoleEntity:
				player_sprite.manual_control = true
				player_sprite.animation_finished.connect(tile_event_finished)
				player_sprite.play("fall")
				fall_sound.play(1)
				
				
				
				
			
	pass
		

func tile_event_finished():
	player_sprite.animation_finished.disconnect(tile_event_finished)
	#world_tiles.hide()
	if GlobalHealth.player_hp <= 0:
		game_over_ui._game_over()
	else:
		world_tiles.cave_generator.reload_level()
	pass
