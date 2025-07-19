extends HBoxContainer

@onready var ui_star_a: TextureRect = $A
@onready var ui_star_b: TextureRect = $B
@onready var ui_star_c: TextureRect = $C
@onready var stars_mapping = {
	Game.Star.A: ui_star_a,
	Game.Star.B: ui_star_b, 
	Game.Star.C: ui_star_c
}
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	Game.star_collected.connect(_on_star_collected)
	for star in stars_mapping:
		if Game.is_star_collected(star):
			set_texture_star_collected(star)


func set_texture_star_collected(star: Game.Star):
	var texture: AtlasTexture = stars_mapping[star].texture
	texture.region.position.x = 16
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_star_collected(_level: Game.Level, star: Game.Star):
	print(star)
	set_texture_star_collected(star)
