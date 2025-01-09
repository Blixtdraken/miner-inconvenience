@tool
extends Node2D

@onready
var parent:Node2D = get_parent()

@export
var speed:float = 100

func _ready():
	global_position = parent.global_position
	pass

func _process(delta):
	global_position = global_position.lerp(parent.global_position, clampf(delta*speed,0,1))
	pass
