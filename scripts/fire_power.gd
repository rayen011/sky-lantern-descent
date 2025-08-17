extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Lantern:
		body.fire_power += 10
