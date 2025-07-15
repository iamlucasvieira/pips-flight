extends Camera2D

@export var pip: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_limit(SIDE_TOP, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x = pip.global_position.x
