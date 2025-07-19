
extends AnimatedSprite2D

@export var star: Game.Star
@onready var area_2d: Area2D = $Area2D

func _ready():
	if Game.is_star_collected(star):
		queue_free()

func collect_star():
	if Game.collect_star(star):
		play_collection_effect()
		queue_free()

func play_collection_effect():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.2)
	tween.tween_property(self, "scale", Vector2(0, 0), 0.2)
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body is Player:
		collect_star()
