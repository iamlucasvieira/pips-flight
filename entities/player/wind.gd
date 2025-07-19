extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.point_sprite()
	player.velocity.y += Game.WIND_GUST_SPEED_Y
	finished.emit(FALL)
