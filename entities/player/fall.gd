extends PlayerState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		print("REJUMP")
		finished.emit(JUMP)
	
func physics_update(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		player.point_sprite()
		player.velocity.x = direction * player.SPEED_X
	
	if player.is_on_floor():
		finished.emit(IDLE)
	
	var gravity_factor: float  = 1
	if Input.is_action_pressed("glide") and player.velocity.y > 0:
		gravity_factor = player.glide_gravity_factor
	print(gravity_factor)
	player.apply_gravity(delta, gravity_factor)
	player.move_and_slide()

func enter(_previous_state_path: String, _data := {}) -> void:
	player.point_sprite()
