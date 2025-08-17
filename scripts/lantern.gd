extends CharacterBody2D
class_name Lantern
const SPEED = 200.0
@export var screen_margin: float = 32
@export var max_tilt: float = 15.0
@export var bob_amplitude: float = 15
@export var bob_speed: float = 5
@export var min_descent: float = 10.0   # slowest descent when fire is full
@export var max_descent: float = 200  # fastest descent when fire is gone

@export var fire_power: float = 100.0 # current fire fuel
@export var max_fire: float = 100.0   # max fire fuel

var time_passed: float = 0.0



func _physics_process(delta: float) -> void:
	time_passed += delta

	# --- Reduce fire power over time ---
	fire_power = max(fire_power - 5 * delta, 0) # drains slowly
	

	# --- Horizontal movement ---
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# --- Vertical descent based on fire power ---
	var t = 1.0 - (fire_power / max_fire) # 0 = full fire, 1 = no fire
	velocity.y = lerp(min_descent, max_descent, t)

	move_and_slide()

	# --- Keep inside horizontal bounds ---
	var viewport_size = get_viewport_rect().size
	global_position.x = clamp(global_position.x, screen_margin, viewport_size.x - screen_margin)

	# --- Tilt effect ---
	var tilt = (velocity.x / SPEED) * max_tilt
	rotation_degrees = lerp(rotation_degrees, tilt, 0.1)

	# --- Bobbing effect ---
	global_position.y += sin(time_passed * bob_speed) * bob_amplitude * delta


func restore_fire(amount: float) -> void:
	fire_power = clamp(fire_power + amount, 0, max_fire)
