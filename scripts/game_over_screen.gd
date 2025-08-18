extends Control

var lantern 

func _process(delta: float) -> void:
	lantern = get_tree().get_first_node_in_group("Lantern")
	$Panel/time_label.text = "AIR TIME: " + str(int(lantern.time_passed)) +"s"

func _on_again_b_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_exit_b_pressed() -> void:
	get_tree().quit()
