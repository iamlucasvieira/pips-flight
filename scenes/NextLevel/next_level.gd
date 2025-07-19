extends Area2D

@export var next_level: Game.Level



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Game.start_level(next_level)
		
