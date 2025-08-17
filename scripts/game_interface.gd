extends Control

var lantern
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lantern = get_tree().get_first_node_in_group("Lantern")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lantern = get_tree().get_first_node_in_group("Lantern")
	$Panel/fire_bar.max_value = lantern.max_fire
	$Panel/fire_bar.value = lantern.fire_power / lantern.max_fire * 100.0
	$time_label.text = str(int(lantern.time_passed))
