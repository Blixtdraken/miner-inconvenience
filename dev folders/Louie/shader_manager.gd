extends Node2D


@onready var palette_material : ShaderMaterial = load("res://dev folders/Louie/palette_material.tres")



var random_palette

# Called when the node enters the scene tree for the first time.
func _ready():
	
	randomize()
	
	print(palette_material.get_shader_parameter("pallette_white"))
	
	_random_palette()

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _random_palette():
	
	GlobalSettings.cur_palette=random_palette
	
	random_palette = randi()%(GlobalSettings.palettes_white.size())
	
	while random_palette==GlobalSettings.cur_palette:
		random_palette = randi()%(GlobalSettings.palettes_white.size())


	#GlobalSettings.palettes_white.erase(random_palette)
	#GlobalSettings.palettes_light.erase(random_palette)
	#GlobalSettings.palettes_dark.erase(random_palette)
	#GlobalSettings.palettes_black.erase(random_palette)
	
	#GlobalSettings.palettes_white.push_back(random_palette)
	#GlobalSettings.palettes_light.push_back(random_palette)
	#GlobalSettings.palettes_dark.push_back(random_palette)
	#GlobalSettings.palettes_black.push_back(random_palette)
	
	palette_material.set_shader_parameter("palette_white", GlobalSettings.palettes_white[random_palette])
	palette_material.set_shader_parameter("palette_light_grey", GlobalSettings.palettes_light[random_palette])
	palette_material.set_shader_parameter("palette_dark_grey", GlobalSettings.palettes_dark[random_palette])
	palette_material.set_shader_parameter("palette_black", GlobalSettings.palettes_black[random_palette])
	
	#GlobalSettings.cur_palette = random_palette
	
	print("current palette: ", random_palette)
