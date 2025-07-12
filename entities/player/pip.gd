class_name Player extends  CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var POINTING_LEFT: bool = true


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()

func is_pointing_left() -> bool:
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		POINTING_LEFT = false
	elif direction < 0:
		POINTING_LEFT = true
	return POINTING_LEFT
