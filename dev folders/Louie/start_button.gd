extends TextureButton

@onready var bitmapReference = preload("res://assets/sprites/game_ui/cut_ui/menu_buttons/exit_button_pressed.png")

func _ready():
	var textureBitMap = BitMap.new()
	textureBitMap.create_from_image_alpha(bitmapReference)
	set_click_mask(textureBitMap)
