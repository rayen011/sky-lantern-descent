extends Control

var lantern: Lantern

func _ready() -> void:
	lantern = get_tree().get_first_node_in_group("Lantern")

func _process(delta: float) -> void:
	if not lantern:
		return

	# --- Time ---
	$time_label.text = "Time: " + str(int(lantern.time_passed)) + "s"

	# --- Distance left ---
	$dist_label.text = "Distance left: " + str(int(lantern.current_distance))

	# --- Fall speed ---
	$fall_speed_label.text = "Fall speed: " + str(round(lantern.velocity.y))

	# --- Fire power ---
	var fire_percent = int((lantern.fire_power / lantern.max_fire) * 100)
	$fire_label.text = "Fire: " + str(fire_percent) + "%"
