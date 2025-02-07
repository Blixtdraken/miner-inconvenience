extends CanvasLayer


@export var gold_text:Label
@export var health_text :Label

var pressed_right
var pressed_left
var pressed_up
var pressed_down

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gold_text.text = str(GlobalScore.collected_ore)
	#health_text.text = str(GlobalHealth.player_hp)
	
	if Input.is_action_just_pressed("ui_left"):
		
		print("WHWAHRHR")
	pass


func _update_gold():
	return


func _on_right_button_pressed():
	
	pressed_right = InputEventAction.new()
	pressed_right.action = "ui_right"
	pressed_right.pressed = true
	Input.parse_input_event(pressed_right)

	pass # Replace with function body.


func _on_down_button_pressed():
	
	pressed_down = InputEventAction.new()
	pressed_down.action = "ui_down"
	pressed_down.pressed = true
	Input.parse_input_event(pressed_down)
	pass # Replace with function body.


func _on_up_button_pressed():
	
	pressed_up = InputEventAction.new()
	pressed_up.action = "ui_up"
	pressed_up.pressed = true
	Input.parse_input_event(pressed_up)
	
	pass # Replace with function body.


func _on_left_button_pressed():
	print("TESTTST")
	pressed_left = InputEventAction.new()
	pressed_left.action = "ui_left"
	pressed_left.pressed = true
	Input.parse_input_event(pressed_left)
	
	pass # Replace with function body.
