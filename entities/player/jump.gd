extends PlayerState

@onready var jump_cooldown: Timer = $jump_cooldown

func enter(_previous_state_path: String, _data := {}) -> void:
	if jump_cooldown.is_stopped() and player.can_jump():
		player.velocity.y = player.JUMP_VELOCITY
		Game.increase_jump_counter()
		jump_cooldown.start()

func physics_update(_delta: float) -> void:
	finished.emit(FALL)
	player.move_and_slide()
