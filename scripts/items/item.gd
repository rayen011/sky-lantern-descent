extends Area2D
class_name Obstacle

@export var stats: ObstacleStats
@onready var sprite: Sprite2D = $Sprite2D

var time_passed: float = 0.0

# Base ascending speed of the obstacle (will move up automatically)
@export var ascend_speed: float = 200.0

func _process(delta: float) -> void:
	time_passed += delta

	# --- Ascend automatically ---
	global_position.y -= ascend_speed * delta

	# --- Horizontal sway motion ---
	if stats.sway_amplitude > 0.0:
		global_position.x += sin(time_passed * stats.sway_speed) * stats.sway_amplitude * delta

	# --- Remove when far below camera (no longer visible) ---
	var camera_y = get_viewport().get_camera_2d().global_position.y
	if global_position.y > camera_y + 600 or global_position.y < camera_y - 600:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body is Lantern:
		# Apply damage to lantern's fire power
		body.fire_power = max(body.fire_power - stats.damage, 0)

		# Optional horizontal knockback
		if stats.knockback != 0:
			body.velocity.x += stats.knockback

		queue_free()
