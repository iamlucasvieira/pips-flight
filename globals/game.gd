extends Node

# Signals for other systems to listen to
signal star_collected(level: Level, star: Star)
signal jumps_counter_updated

const WIND_GUST_SPEED_Y = -500
const AIR_RESISTNACE_X: float = 150.0

# Player Vars
var jumps_used: int = 0

# Level management
enum Level { ONE, TWO, THREE }  # Easy to add more levels
enum Star {A, B, C}
@onready var current_level: Level = get_current_level()

# Level scenes - easier to manage
const LEVEL_SCENES = {
	Level.ONE: preload("res://scenes/levels/level_1.tscn"),
	Level.TWO: preload("res://scenes/levels/level_2.tscn"),
	# Level.THREE: preload("res://scenes/level3/level3.tscn"),
}


var scene_to_level = {
	"level1": Level.ONE,
	"level2": Level.TWO
}

var stars_collected = {
	Level.ONE: [],  
	 Level.TWO: [],
	# Level.THREE: [],
}

var jumps_available = {
	Level.ONE: 1,
	Level.TWO: 3,
}


func get_current_level() -> Level:
	var current_scene = get_tree().current_scene
	if not current_scene:
		printerr("No current scene found!")
		return Level.ONE
	
	var scene_name = current_scene.name.to_lower()
	return scene_to_level[scene_name]

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
	if jumps_used > get_jumps_available():
		printerr("Playes is jumping more than allowed")

func reset_jump_counter():
	jumps_used = 0
	jumps_counter_updated.emit()
	
func get_jumps_available(level: Level = current_level) -> int:
	return jumps_available[level]
