extends PlayerState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		finished.emit(JUMP)
	
func physics_update(delta: float) -> void:	
	player.move_horizontally(delta, true)
	
	# Check if landed
	if player.is_on_floor():
		print("is_on_floor")
		finished.emit(IDLE)
		return
	
	# Handle gliding
	print("FALLING")
	if Input.is_action_pressed("glide"):
		finished.emit(GLIDE)
		return
	
	player.apply_gravity(delta)
	player.move_and_slide()

func enter(_previous_state_path: String, _data := {}) -> void:
	print("ENTERED")
	player.point_sprite()

func _on_pip_entered_wind() -> void:
	finished.emit(WIND)
