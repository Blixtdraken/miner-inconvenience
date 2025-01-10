extends Node
class_name LevelMaker





func make_level(num_floor_tiles : int = 110)->Array[Vector2i]:
	var floorWalkers : Array[FloorWalker] = [FloorWalker.new()]
	var floor : Array[Vector2i] = [floorWalkers[0].pos]

	var place_floor_tile = func(new_tile: Vector2i)->bool:
			var idx = floor.bsearch(new_tile)

			if idx < floor.size():
				if floor[idx] == new_tile: return false
			floor.insert(idx, new_tile)

			return true

	
	while(floor.size() < num_floor_tiles):
		for floorWalker in floorWalkers:
			var new_tile = floorWalker.step()
			place_floor_tile.call(new_tile)
			floorWalker.rotate(randi_range(0,3))

	return floor