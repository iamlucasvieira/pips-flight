extends PlayerState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

## Called by the state machine when receiving unhandled input events.
func handle_input(event: InputEvent) -> void:
	if event.is_action("move_left") or event.is_action("move_right"):
		finished.emit(WALK)

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	animated_sprite_2d.play("idle")

func physics_update(_delta: float) -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.move_and_slide()
