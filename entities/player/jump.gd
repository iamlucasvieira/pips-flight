extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = player.JUMP_VELOCITY

	
func physics_update(_delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		finished.emit(GLIDE)
		return
		
	if player.is_on_floor():
		finished.emit(IDLE)
	player.move_and_slide()
