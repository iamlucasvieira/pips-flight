extends Node

# Signals for other systems to listen to
signal star_collected(level: Level, star: Star)
signal level_completed(level: Level, stars_count: int)

const WIND_GUST_SPEED_Y = -500
const AIR_RESISTNACE_X: float = 150.0

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
