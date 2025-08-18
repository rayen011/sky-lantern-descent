extends Area2D
var speed = 100

func _ready() -> void:
	$AnimationPlayer.play("RESET")
func _process(delta: float) -> void:
	position.y -= speed *delta

func _on_body_entered(body: Node2D) -> void:
	if body is Lantern:
		explode()
		body.fire_power += 25
		

func explode():
	speed = 0.1
	$pick.play()
	$AnimationPlayer.play("explode")
