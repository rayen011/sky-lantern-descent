extends Node2D

@export var obstacle_scene: PackedScene
@export var item_scene: PackedScene
@export var spawn_interval: float = 1.5
@export var spawn_margin_top: float = 50.0

var spawn_timer: float = 0.0
var lantern: Node2D

func _ready():
	Engine.time_scale = 1.0
	lantern = get_tree().get_first_node_in_group("Lantern")
	randomize()

func _process(delta):
	
	if not lantern:
		return

	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_object()
	if lantern.landed:
		Engine.time_scale = 0.0
		$CanvasLayer/Game_over_screen.visible = true
	else:
		$CanvasLayer/Game_over_screen.visible = false
		Engine.time_scale = 1.0
func spawn_object():
	var camera = get_viewport().get_camera_2d()
	if not camera:
		return

	var viewport_size = get_viewport_rect().size
	var spawn_x = randf_range(50, viewport_size.x - 50)

	# Spawn at the top edge of camera's visible area
	var spawn_y = camera.global_position.y - viewport_size.y / 2 + 700  # 50 px inside the top

	var obj
	if randi() % 2 == 0:
		obj = obstacle_scene.instantiate()
	else:
		obj = item_scene.instantiate()

	obj.global_position = Vector2(spawn_x, spawn_y)
	add_child(obj)
