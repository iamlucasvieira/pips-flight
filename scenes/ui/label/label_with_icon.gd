@tool
extends PanelContainer

@export var icon: Icon
@onready var texture_rect: TextureRect = $TextureRect

enum Icon {
	UP,
	DOWN,
	LEFT,
	RIGHT,
	LU,
	LD,
	RU,
	RD
}

var icon_size: int = 16

var icon_position: Dictionary[Icon, Vector2] = {
	Icon.UP: Vector2(0, 0),
	Icon.RIGHT: Vector2(icon_size, 0),
	Icon.DOWN: Vector2(icon_size * 2, 0),
	Icon.LEFT: Vector2(icon_size * 3, 0),
	Icon.LD: Vector2(0, icon_size),
	Icon.RD: Vector2(icon_size, icon_size),  
	Icon.LU: Vector2(icon_size * 2, icon_size),
	Icon.RU: Vector2(icon_size * 3, icon_size)
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var texture = texture_rect.texture as AtlasTexture
	texture.region.position = icon_position[icon]
	texture_rect.texture = texture.duplicate()
