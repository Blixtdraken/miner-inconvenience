extends Control


@export var heart1:Sprite2D
@export var heart2:Sprite2D
@export var heart3:Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if GlobalHealth.player_hp >= 3:
		heart1.show()
		heart2.show()
		heart3.show()
	elif GlobalHealth.player_hp == 2:
		heart1.hide()
		heart2.show()
		heart3.show()
	elif GlobalHealth.player_hp == 1:
		heart1.hide()
		heart2.hide()
		heart3.show()
	elif GlobalHealth.player_hp <= 0:
		heart1.hide()
		heart2.hide()
		heart3.hide()
		
	pass
