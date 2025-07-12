extends PlayerState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * player.SPEED
	
	if player.is_on_floor():
		finished.emit(IDLE)
		
	player.move_and_slide()

func enter(previous_state_path: String, data := {}) -> void:
	animated_sprite_2d.flip_h = player.is_pointing_left()
