extends PlayerState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		finished.emit(JUMP)

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	player.move_horizontally(delta)
	var direction := Input.get_axis("move_left", "move_right")
	if not direction:
		finished.emit(IDLE)
	player.apply_gravity(delta)
	player.move_and_slide()

func enter(_previous_state_path: String, _data := {}) -> void:
	animated_sprite_2d.play("walk")
	player.point_sprite()
