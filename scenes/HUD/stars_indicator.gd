extends HBoxContainer
class_name StarIndicator

@onready var ui_star_a: TextureRect = $A
@onready var ui_star_b: TextureRect = $B
@onready var ui_star_c: TextureRect = $C
@onready var stars_mapping = {
	Game.Star.A: ui_star_a,
	Game.Star.B: ui_star_b, 
	Game.Star.C: ui_star_c
}
@export var level: Game.Level
@export var get_current_level: bool = true
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	ui_star_a.texture = ui_star_a.texture.duplicate()
	ui_star_b.texture = ui_star_b.texture.duplicate()
	ui_star_c.texture = ui_star_c.texture.duplicate()
	if level == null or get_current_level:
		level = Game.get_current_level()
	Game.star_collected.connect(_on_star_collected)
	set_texture_star_collected()


func set_texture_star_collected():
	for star in stars_mapping:
		var texture: AtlasTexture = stars_mapping[star].texture
		if Game.is_star_collected(star, level):
			texture.region.position.x = 16
		else:
			texture.region.position.x = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_star_collected(_level: Game.Level, _star: Game.Star):
	set_texture_star_collected()
