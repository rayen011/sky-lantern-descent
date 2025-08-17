extends CharacterBody2D
class_name Lantern

@export var SPEED = 200.0
@export var max_tilt = 15.0
@export var bob_amplitude = 15
@export var bob_speed = 5

@export var max_distance: float = 2000.0
var current_distance: float = max_distance

@export var ground_y: float = 748.74  # Y position of visual ground

var time_passed: float = 0.0
var landed: bool = false

func _physics_process(delta):
	time_passed += delta

	# Horizontal input
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not landed:
		# Calculate remaining distance based on visual ground
		var distance_to_ground = ground_y - global_position.y
		current_distance = clamp(distance_to_ground, 0, max_distance)

		# Vertical speed based on distance left
		var t = 1.0 - (current_distance / max_distance)
		velocity.y = lerp(50, 300, t)

	# Move lantern
	move_and_slide()

	# Tilt effect
	rotation_degrees = lerp(rotation_degrees, (velocity.x / SPEED) * max_tilt, 0.1)

	# Bobbing effect only if not landed
	if not landed:
		global_position.y += sin(time_passed * bob_speed) * bob_amplitude * delta

	# Landing check
	if global_position.y >= ground_y and not landed:
		global_position.y = ground_y
		velocity = Vector2.ZERO
		landed = true
		current_distance = 0
		on_landed()

func on_landed():
	print("Lantern has landed!")
	# Add landing effects here
