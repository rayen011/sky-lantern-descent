extends Control

var lantern

func _ready():
	lantern = get_tree().get_first_node_in_group("Lantern")

func _process(delta):
	if not lantern:
		return
	$dist_label.text = "Distance: " + str(int(lantern.current_distance)) + " M"
	$fall_speed_label.text = "Fall Speed: " + str(int(lantern.velocity.y)) + "M/s"
	$time_label.text = "Time: " + str(int(lantern.time_passed)) + "s"
	$fire_label.text = "fire:" + str(int(lantern.fire_power)) + "%"
