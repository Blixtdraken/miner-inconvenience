class_name TileInfo

enum TileType {
	NULL,
	GROUND,
	FLOOR,
	HOLE,
	BORDER,
}


var tile_position:Vector2i
var tile_entity:TileEntity
var tile_data:TileData
var tile_type:TileType
func _init(tile_position:Vector2i, tile_entity:TileEntity, tile_data:TileData) -> void:
	self.tile_position = tile_position
	self.tile_entity = tile_entity
	self.tile_data = tile_data
	if tile_data:
		var type = tile_data.get_custom_data("type")
		tile_type = TileType.get(type.to_upper())
	else:
		tile_type = TileType.NULL
	pass
