extends Area2D

var pip: CharacterBody2D
var waypoints: Array[Node] = []
var current_waypoint_index = 0
@onready var waiting: Timer = $Wait
@onready var hud: CanvasLayer = $"../HUD"

@export var flight_speed: float = 200.0
@export var wait_time: float = 2.0
@export var arrival_distance: float = 5.0
@export var wave_amplitude: float = 60.0  # How much up/down wave motion
@export var wave_frequency: float = 2.0   # How fast the wave motion

var flight_time: float = 0.0

func _ready():
	# Find all waypoint nodes (1, 2, 3, etc.)
	waiting.wait_time = wait_time
	for child in get_children():
		if child.name.is_valid_int():
			waypoints.append(child)

func _on_body_entered(body: Node2D) -> void:
	hud.hide()
	if body is Player:
		pip = body
		start_end_game_sequence()

func start_end_game_sequence():
	for child in get_children():
		if child is StarIndicator:
			child.set_texture_star_collected()
	pip.state_machine._transition_to_next_state(PlayerState.FLY)

func _physics_process(delta):
	var is_wainting = not waiting.is_stopped()
	if not pip or is_wainting or current_waypoint_index >= waypoints.size():
		return
	
	flight_time += delta
	
	var target = waypoints[current_waypoint_index]
	
	var target_pos = Vector2(target.global_position.x + target.size[0] / 2, target.global_position.y)
	var direction = (target_pos - pip.global_position).normalized()
	
	# Base velocity towards target
	var base_velocity = direction * flight_speed
	

	var perpendicular = Vector2(-direction.y, direction.x)  # Perpendicular vector
	var wave_motion = perpendicular * sin(flight_time * wave_frequency) * wave_amplitude
	
	# Combine base movement with wave motion
	pip.velocity = base_velocity + wave_motion
	
	# Check if arrived at waypoint (using target_pos, not original waypoint position)
	var distance = pip.global_position.distance_to(target_pos)
	if distance < arrival_distance:
		arrive_at_waypoint()


func arrive_at_waypoint():
	pip.velocity = Vector2.ZERO
	waiting.start()
	
	current_waypoint_index += 1
	if current_waypoint_index >= waypoints.size():
		print("Flight complete!")
		set_physics_process(false)
