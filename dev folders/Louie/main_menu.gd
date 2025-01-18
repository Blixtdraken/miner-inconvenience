extends Control

var game_scene = preload("res://dev folders/Louie/fei_copy.tscn")




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	
	get_tree().change_scene_to_file("res://dev folders/Louie/fei_copy.tscn")
	#get_node("/root/MainMenu").free()
	pass # Replace with function body.




func _on_help_button_pressed():
	
	get_tree().change_scene_to_file("res://dev folders/Louie/help_menu.tscn")
	pass # Replace with function body.


func _on_credits_button_pressed():
	
	get_tree().change_scene_to_file("res://dev folders/Louie/credit_menu.tscn")
	pass # Replace with function body.
