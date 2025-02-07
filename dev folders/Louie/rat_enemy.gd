#class_name RatEnemy
extends EnemyEntity






func _on_turn():
	
	var random_direction = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
	
	
	var dir:Vector2i = random_direction[randi()%(random_direction.size())]
	
	tile_pos += dir as Vector2i
	
	
	if dir.x != 0:
		
		sprite.scale.x = dir.clampi(-1,1).x
	
	pass
