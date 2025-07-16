class_name Player extends  CharacterBody2D

const SPEED_X = 300.0
const GLIDE_SPEED_X = 200.0
const JUMP_VELOCITY = -400.0

@export var jumps_available: int = 2
@export var glide_speed_y: float = 10.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var jumps_used: int = 0
var POINTING_LEFT: bool = true

func is_pointing_left() -> bool:
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		POINTING_LEFT = false
	elif direction < 0:
		POINTING_LEFT = true
	return POINTING_LEFT

func point_sprite():
	animated_sprite_2d.flip_h = is_pointing_left()

func apply_gravity(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
func can_jump() -> bool:
	return jumps_used < jumps_available
	
func _on_jump_cooldown_timeout() -> void:
	pass # Replace with function body.
