extends PlayerState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		finished.emit(JUMP)
	
func physics_update(delta: float) -> void:
	if Input.is_action_pressed("glide") and player.velocity.y > 0:
		player.velocity.y = player.glide_speed_y
		
	# Check if landed
	if player.is_on_floor():
		finished.emit(IDLE)
		return

	player.move_horizontally(delta, true)
	player.apply_gravity(delta)
	player.move_and_slide()

func enter(_previous_state_path: String, _data := {}) -> void:
	animated_sprite_2d.play("glide")
	player.point_sprite()
