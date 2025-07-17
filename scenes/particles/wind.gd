extends GPUParticles2D

signal player_enterd_wind

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is Player:
		player_enterd_wind.emit()
