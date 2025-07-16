extends PlayerState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		finished.emit(JUMP)
	
func physics_update(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		player.point_sprite()
		var target_speed = direction * player.SPEED_X
		player.velocity.x = move_toward(player.velocity.x, target_speed, player.SPEED_X * 2.0 * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.AIR_RESISTNACE_X * delta)
	
	# Check if landed
	if player.is_on_floor():
		finished.emit(IDLE)
		return
	
	# Handle gliding
	if Input.is_action_pressed("glide") and player.velocity.y > 0:
		player.velocity.y = player.glide_speed_y
	else:
		player.apply_gravity(delta)
	
	player.move_and_slide()
	
	
	
	
	
	# Done 
	#if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		#player.point_sprite()
		#player.velocity.x = direction * player.SPEED_X
	#
	#if player.is_on_floor():
		#finished.emit(IDLE)
	#
	#if Input.is_action_pressed("glide") and player.velocity.y > 0:
		#player.velocity.y = player.glide_speed_y
	#else:
		#player.apply_gravity(delta)
		#
	#player.velocity.x = move_toward(player.velocity.x, 0, player.AIR_RESISTNACE_X * delta)
	#player.move_and_slide()

func enter(_previous_state_path: String, _data := {}) -> void:
	player.point_sprite()
