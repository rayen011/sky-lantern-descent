extends ParallaxBackground

var lantern
func _process(delta: float) -> void:
	lantern = get_tree().get_first_node_in_group("Lantern")
	
	var fall_speed = lantern.velocity.y
	$ParallaxLayer.motion_offset.y -= fall_speed * delta
	
