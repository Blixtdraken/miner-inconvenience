extends MarginContainer



@onready var floor_number = $MarginContainer/VBoxContainer/FloorNumber
@onready var collected_number = $MarginContainer/VBoxContainer/CollectedNumber
@onready var killed_number = $MarginContainer/VBoxContainer/KillNumber
@onready var score_number = $MarginContainer/VBoxContainer/TotalNumber

var main_menu = preload("res://dev folders/Louie/main_menu.tscn").instantiate()

@export var caveGen : CaveGenerator
@export var _animator : AnimationPlayer

var game_over : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	#GlobalScore.collected_ore = 2150
	#GlobalScore.floor = 36
	
	#game_over=true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
	
	
func _game_over():
	
	floor_number.text = str(GlobalScore.floor)
	collected_number.text = str(GlobalScore.collected_ore)
	killed_number.text = str(GlobalScore.amount_killed)
	
	
	
	
	score_number.text = str(snapped((GlobalScore.collected_ore*(pow((GlobalScore.floor), 1.1))/10), 1)+GlobalScore.amount_killed,"0")  # Returns 96str()
	print(pow(GlobalScore.floor-1, (1.1)))
	
	_animator.play("slide_down")
	
	pass


func _on_retry_button_pressed():
	
	
	_animator.play("slide_up")
	
	
	pass # Replace with function body.


func _on_game_over_animator_animation_finished(anim_name):
	
	if anim_name == "slide_up":
		_reset_score()
		caveGen.reload_level()
		#print("test")
		#pass

	pass # Replace with function body.


func _on_menu_button_pressed():
	
	_reset_score()
	get_tree().change_scene_to_file("res://dev folders/Louie/main_menu.tscn")
	
	pass # Replace with function body.


func _reset_score():
	
	GlobalScore.floor = 0
	GlobalScore.collected_ore = 0
	GlobalScore.amount_killed = 0
	GlobalHealth.player_hp = 3
	
	GlobalScore.music_progress = 0.0
	
	pass
