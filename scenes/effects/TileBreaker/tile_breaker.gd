extends TileMapLayer

func break_tile(world_pos: Vector2i):
	var tile_pos = local_to_map(world_pos) + Vector2i(0, 1)
	break_tile_with_flash(tile_pos)
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
	modulate = Color.WHITE * intensity

func delete_tile(tile_pos: Vector2i):
	set_cell(tile_pos, -1)
