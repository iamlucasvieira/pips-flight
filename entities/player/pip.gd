class_name Player extends  CharacterBody2D

const SPEED_X: float = 300.0
const GLIDE_SPEED_X: float = 200.0
const JUMP_VELOCITY: float = -400.0

signal entered_wind

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

func move_horizontally(delta: float, acelerate: bool = false):
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		point_sprite()
		var target_speed = direction * SPEED_X
		if acelerate:
			velocity.x = move_toward(velocity.x, target_speed, SPEED_X * delta * 2)
		else:
			velocity.x = target_speed
	else:
		velocity.x = move_toward(velocity.x, 0, Game.AIR_RESISTNACE_X * delta)

func can_jump() -> bool:
	return jumps_used < jumps_available
	
func _on_wind_player_enterd_wind() -> void:
	entered_wind.emit()
