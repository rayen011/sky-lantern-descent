extends Camera2D

@export var stop_y: float = 950  # slightly above ground_y

func _process(delta):
	var lantern = get_tree().get_first_node_in_group("Lantern")
	if lantern:
		if lantern.global_position.y < stop_y:
			global_position.y = lantern.global_position.y
		else:
			global_position.y = stop_y
