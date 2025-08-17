extends Area2D

func _process(delta: float) -> void:
	position.y -= 30 *delta

func _on_body_entered(body: Node2D) -> void:
	if body is Lantern:
		
		queue_free()
