extends Node2D

@onready var pip: Player = $pip

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.set_jumps_available(1)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass	
