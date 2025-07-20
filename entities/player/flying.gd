extends PlayerState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter(previous_state_path: String, _data := {}) -> void:
	animated_sprite_2d.play("fly")

func physics_update(_delta: float) -> void:	
	player.move_and_slide()
