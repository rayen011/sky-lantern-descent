extends CharacterBody2D
class_name Lantern

const SPEED = 200.0
@export var screen_margin: float = 32
@export var max_tilt: float = 15.0
@export var min_descent: float = 10.0
@export var max_descent: float = 50.0

@export var fire_power: float = 100.0
@export var max_fire: float = 100.0

@export var max_distance: float = 1200.0 # total journey to ground
var current_distance: float

var time_passed: float = 0.0
var landed: bool = false

func _ready() -> void:
	current_distance = max_distance

func _physics_process(delta: float) -> void:
	if landed:
		return
	
	time_passed += delta

	# --- Fire drains ---
	fire_power = max(fire_power - 5 * delta, 0)

	# --- Horizontal movement ---
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# --- Vertical descent (based on fire) ---
	var t = 1.0 - (fire_power / max_fire) # 0 = full fire, 1 = empty fire
	velocity.y = lerp(min_descent, max_descent, t)

	move_and_slide()

	# --- Keep inside horizontal bounds ---
	var viewport_size = get_viewport_rect().size
	global_position.x = clamp(global_position.x, screen_margin, viewport_size.x - screen_margin)

	# --- Apply descent to journey distance ---
	current_distance = max(current_distance - velocity.y * delta, 0)

	# --- Check if reached ground ---
	if current_distance <= 0:
		_on_reach_ground()

	# --- Tilt ---
	var tilt = (velocity.x / SPEED) * max_tilt
	rotation_degrees = lerp(rotation_degrees, tilt, 0.1)


func restore_fire(amount: float) -> void:
	fire_power = clamp(fire_power + amount, 0, max_fire)

func _on_reach_ground() -> void:
	landed = true
	velocity = Vector2.ZERO
	print("Lantern has landed! 🎉") # Replace with end screen/game win
