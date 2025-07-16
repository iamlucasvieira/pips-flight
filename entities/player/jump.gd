extends PlayerState

@onready var jump_cooldown: Timer = $jump_cooldown

func enter(_previous_state_path: String, _data := {}) -> void:
	if jump_cooldown.is_stopped():
		player.velocity.y = player.JUMP_VELOCITY
		player.jumps_used += 1
		jump_cooldown.start()

func physics_update(_delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		player.point_sprite()
		finished.emit(GLIDE)
		return
		
	finished.emit(FALL)
	player.move_and_slide()
