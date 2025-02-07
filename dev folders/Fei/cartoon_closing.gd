extends CanvasLayer

@onready
var rect:ColorRect = get_node("CloseEffect/ColorRect")

var closed:bool = false

var ratio:float = 1.0

var speed:float = 1.5

signal closing_finished
signal opening_finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func close():
	closed = true
	pass

func open():
	closed = false
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var zoom:float = get_viewport().size.x/144
	(rect.material as ShaderMaterial).set_shader_parameter("pixSize", get_viewport().size.x/GlobalSettings.pixel_limit)
	

	
	if closed:
		ratio = move_toward(ratio, 0.0, delta*speed)
	else:
		ratio = move_toward(ratio, 1.0, delta*speed)
	
	
	(rect.material as ShaderMaterial).set_shader_parameter("radius", ratio)
	pass
