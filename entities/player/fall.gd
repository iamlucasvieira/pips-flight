extends PlayerState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		finished.emit(JUMP)
	
func physics_update(delta: float) -> void:	
	player.move_horizontally(delta, true)
	
	# Check if landed
	if player.is_on_floor():
		finished.emit(IDLE)
		return
	
	# Handle gliding
	if player.can_glide and Input.is_action_pressed("glide"):
		finished.emit(GLIDE)
		return
	
	player.apply_gravity(delta)
	player.move_and_slide()

func enter(previous_state_path: String, _data := {}) -> void:
	if previous_state_path != JUMP:
		animated_sprite_2d.play("fall")
	player.point_sprite()

func _on_pip_entered_wind() -> void:
	finished.emit(WIND)
