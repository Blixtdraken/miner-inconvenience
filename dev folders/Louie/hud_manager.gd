extends CanvasLayer


@onready var gold_text = $Control/MarginContainer/GoldText
@onready var health_text = $Control/MarginContainer/HealthText


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gold_text.text = str(GlobalScore.collected_ore)
	health_text.text = str(GlobalHealth.player_hp)
	pass


func _update_gold():
	return
