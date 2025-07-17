extends Camera2D

@export var pip: Player

var viewport_height: int = ProjectSettings.get_setting("display/window/size/viewport_height")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_limit(SIDE_BOTTOM, viewport_height)
	global_position = pip.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position = pip.global_position
