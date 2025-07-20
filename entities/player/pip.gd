class_name Player extends  CharacterBody2D

const SPEED_X: float = 300.0
const GLIDE_SPEED_X: float = 200.0
const JUMP_VELOCITY: float = -400.0

signal entered_wind
@onready var die_audio: AudioStreamPlayer2D = $DieAudio

@export var glide_speed_y: float = 10.0
@export var can_glide: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine

var POINTING_LEFT: bool = false

func _ready() -> void:
	connect_wind()
	
func connect_wind() -> void:
	for node in get_tree().get_nodes_in_group("wind"):
		(node as Wind).player_enterd_wind.connect(_on_wind_player_enterd_wind)

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
	return Game.jumps_used < Game.get_jumps_available()
	
func _on_wind_player_enterd_wind() -> void:
	entered_wind.emit()

func _on_break_tile_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		body.break_tile(position)

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		die()

func die() -> void:
	die_audio.play()
	get_tree().paused = true
	await die_audio.finished 
	get_tree().paused = false
	get_tree().reload_current_scene()
 
