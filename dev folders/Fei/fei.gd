extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
	
func _draw() -> void:
	var lenght = 10000
	var alpha = Color(1,1,1,0.25)
	draw_line(Vector2.DOWN*lenght,Vector2.UP*lenght, Color.GREEN*alpha)
	draw_line(Vector2.LEFT*lenght,Vector2.RIGHT*lenght, Color.RED*alpha)
