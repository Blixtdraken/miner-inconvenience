extends TileEntity
class_name OreEntity


@export var ore_value : int

@export
var has_hidden_hole:bool = false

# @onready var _particle_anim : AnimationPlayer = $GPUParticles2D/AnimationPlayer
# @onready var _particles : GPUParticles2D = $GPUParticles2D

func _on_damage(damage:int):
	
	GlobalScore.collected_ore+=ore_value
	print(GlobalScore.collected_ore) #TEST
	
	
	var instance = load("res://scenes/instantiable/ores/ore_particles/gem_particles.tscn").instantiate()
	get_parent().add_child(instance)
	instance.global_position = self.global_position
	
	world_tiles.tile_entities.erase(tile_pos)
	
	if has_hidden_hole:
		var hole_scene:PackedScene = preload("res://scenes/instantiable/hole.tscn")
		
		var hole:HoleEntity = hole_scene.instantiate()
		hole.world_tiles = world_tiles
		hole.spawn_tile = tile_pos
		get_parent().add_child(hole)
	
	queue_free()
	pass
