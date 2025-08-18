extends CharacterBody2D
class_name Lantern

# --- Movement & visual ---
@export var SPEED = 200.0
@export var max_tilt = 15.0
@export var bob_amplitude = 15
@export var bob_speed = 5

# --- Fire power ---
@export var max_fire: float = 100.0
var fire_power: float = max_fire

# --- Distance & ground ---
@export var max_distance: float = 2000.0
var current_distance: float = max_distance
@export var ground_y: float = 748.74

# --- Descent speed ---
@export var min_descent_speed: float = 10
@export var max_descent_speed: float = 50

# --- State ---
var time_passed: float = 0.0
var landed: bool = false

# --- Starting Y ---
@export var start_y: float = 50.0

func _ready():
	global_position.y = start_y
	current_distance = max_distance

func _physics_process(delta):
	time_passed += delta

	# --- Horizontal input ---
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# --- Vertical descent ---
	if not landed:
		# Update distance based on visual ground
		current_distance = clamp(ground_y - global_position.y, 0, max_distance)

		# Fire ratio (affects fall)
		var fire_ratio = fire_power / max_fire

		# Smooth descent speed: starts slow, accelerates as distance decreases, slows with more fire
		var descent_t = 1.0 - (current_distance / max_distance)  # 0 at top, 1 near ground
		var descent_speed = lerp(min_descent_speed, max_descent_speed, descent_t)
		descent_speed *= (1.0 - fire_ratio)  # fire slows fall
		velocity.y = descent_speed

		# Drain fire slowly
		fire_power = max(fire_power - 5 * delta, 0)

	# --- Move lantern ---
	move_and_slide()

	# --- Tilt effect ---
	rotation_degrees = lerp(rotation_degrees, (velocity.x / SPEED) * max_tilt, 0.1)

	# --- Bobbing effect ---
	if not landed:
		global_position.y += sin(time_passed * bob_speed) * bob_amplitude * delta

	# --- Landing check ---
	if global_position.y >= ground_y and not landed:
		global_position.y = ground_y
		velocity = Vector2.ZERO
		landed = true
		current_distance = 0
		on_landed()

func restore_fire(amount: float):
	fire_power = clamp(fire_power + amount, 0, max_fire)

func on_landed():
	print("Lantern has landed!")
	$landsound.play()
	# Add landing effects here
