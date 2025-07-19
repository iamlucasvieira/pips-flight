extends TileMapLayer

func break_tile(world_pos: Vector2i):
	var tile_pos = local_to_map(world_pos) + Vector2i(0, 1)
	var tiles_to_break = get_tiles_to_break(world_pos, tile_pos)
	
	for tile in tiles_to_break:
		break_tile_with_flash(tile)
	
	return false

func get_tiles_to_break(world_pos: Vector2i, center_tile_pos: Vector2i) -> Array[Vector2i]:
	var tiles_to_break: Array[Vector2i] = [center_tile_pos]
	
	# Check player position within the 16px tile
	var tile_center_x = center_tile_pos.x * 16 + 8  # Center of tile
	var offset = world_pos.x - tile_center_x
	
	# Break additional tiles if player is near edges (within 5px of edge)
	if offset < -5:  # Left side
		tiles_to_break.append(center_tile_pos + Vector2i(-1, 0))
	elif offset > 5:  # Right side
		tiles_to_break.append(center_tile_pos + Vector2i(1, 0))
	else:
		tiles_to_break.append(center_tile_pos + Vector2i(1, 0))
		tiles_to_break.append(center_tile_pos + Vector2i(-1, 0))

	return tiles_to_break
	
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
	modulate = Color.WHITE * intensity

func delete_tile(tile_pos: Vector2i):
	set_cell(tile_pos, -1)
