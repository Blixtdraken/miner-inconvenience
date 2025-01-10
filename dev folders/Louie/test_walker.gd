extends RefCounted
class_name FloorWalker

const CARD_DIR = [Vector2i.RIGHT, Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN]

var pos : Vector2i
var dir : Vector2i


func _init(new_pos : Vector2i = Vector2i.ZERO, new_dir : Vector2i = Vector2i.RIGHT):
	pos = new_pos
	dir = new_dir


func step()->Vector2i:
	pos += dir
	return pos

func rotate(num_lefts : int)->void:

	dir = CARD_DIR[(num_lefts + CARD_DIR.find(dir))%4]
	

	return


