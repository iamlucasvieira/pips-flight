extends Node

var tilemap: TileMapLayer
var tiles_to_delete: Array[Vector2i] = []

func _ready():
	# Find the parent TileMapLayer
	var parent = get_parent()
	if parent is TileMapLayer:
		tilemap = parent
	else:
		print("Error: TileBreaker must be a child of a TileMapLayer!")


func try_break_tile(world_pos: Vector2i):
	# Convert world position to tile coordinates
	#var tile_pos = local_to_map(world_pos)
	var tile_pos = tilemap.local_to_map(world_pos) + Vector2i(0, 1)

	# Get the tile data at this position
	var tile_data = tilemap.get_cell_tile_data(tile_pos)
	
	# Check if tile exists and has the breakable property set to true
	if tile_data and tile_data.get_custom_data("breakable"):
		# Remove the tile from the tilemap
		break_tile_with_flash(tile_pos)
		return true
	
	return false

func break_tile_with_flash(tile_pos: Vector2i):
	var tween = create_tween()
	
	# Flash white
	tween.tween_method(flash_tilemap, 1.0, 1.8, 0.1)
	# Flash back to normal
	tween.tween_method(flash_tilemap, 1.8, 1.0, 0.1)
	# Flash white again
	tween.tween_method(flash_tilemap, 1.0, 1.8, 0.1)
	# Back to normal and delete
	tween.tween_method(flash_tilemap, 1.8, 1.0, 0.1)
	tween.tween_callback(delete_tile.bind(tile_pos))

func flash_tilemap(intensity: float):
	tilemap.modulate = Color.WHITE * intensity

func delete_tile(tile_pos: Vector2i):
	print("Deleting tile at: ", tile_pos)
	tilemap.set_cell(tile_pos, -1)


func _on_pip_try_break_tile_at(position: Vector2) -> void:
	try_break_tile(position)
