#class_name SlimeEnemy
extends EnemyEntity


var is_charging : bool = true
var _move_speed : int = 1

func _on_turn():
	
	
	if !is_charging:
		
		sprite.play("attack")
		for moves in _move_speed:
			super()
			print("moving slime")
			
			pass
		sprite.play("default")
	if is_charging:
		sprite.play("charging")
	
	is_charging = !is_charging
	pass
