extends PlayerState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

## Called by the state machine when receiving unhandled input events.
func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		finished.emit(JUMP)

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_previous_state_path: String, _data := {}) -> void:
	player.jumps_used = 0
	animated_sprite_2d.play("idle")

func physics_update(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		finished.emit(WALK)
		return
	
	if not player.is_on_floor():
		finished.emit(FALL)
		return
	
	player.velocity.x = 0
	player.move_and_slide()
