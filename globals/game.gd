extends Node

# Signals for other systems to listen to
signal star_collected(level: Level, star: Star)
signal level_completed(level: Level, stars_count: int)
signal jumps_available_set
signal jumps_counter_updated

const WIND_GUST_SPEED_Y = -500
const AIR_RESISTNACE_X: float = 150.0

# Player Vars
var jumps_available: int
var jumps_used: int = 0

# Level management
enum Level { ONE, TWO, THREE }  # Easy to add more levels
enum Star {A, B, C}
var current_level: Level

# Level scenes - easier to manage
const LEVEL_SCENES = {
	Level.ONE: preload("res://scenes/level1/level1.tscn"),
	# Level.TWO: preload("res://scenes/level2/level2.tscn"),
	# Level.THREE: preload("res://scenes/level3/level3.tscn"),
}

var stars_collected = {
	Level.ONE: [],  
	# Level.TWO: [],
	# Level.THREE: [],
}


func start_level(level: Level):
	if level not in LEVEL_SCENES:
		print("Error: Level ", level, " not found!")
		return
	
	current_level = level
	var scene = LEVEL_SCENES[level]
	get_tree().change_scene_to_packed(scene)

func collect_star(star: Star, level: Level = current_level):
	if star in stars_collected[level]:
		printerr("Star ", star, " already collected!")
		return false
	stars_collected[level].append(star)
	star_collected.emit(level, star)
	
	return true
	
func get_stars_collected_count(level: Level) -> int:
	return stars_collected[level].size()

func is_star_collected(star: Star, level: Level = current_level) -> bool:
	return star in stars_collected[level]

func increase_jump_counter():
	jumps_used += 1
	jumps_counter_updated.emit()
	if jumps_used > jumps_available:
		printerr("Playes is jumping more than allowed")

func reset_jump_counter():
	jumps_used = 0
	jumps_counter_updated.emit()
	
func set_jumps_available(jumpus_avaiable_value: int):
	jumps_available = jumpus_avaiable_value
	jumps_available_set.emit()
