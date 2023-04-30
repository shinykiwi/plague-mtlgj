extends Node3D

@export var mob_scene: PackedScene
@export var level_complete: PackedScene
@export var rat_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 5:
		var light_en = mob_scene.instantiate()
		light_en.position = rand_pos()
		light_en.add_to_group("light_enemies")
		add_child(light_en)
	
	for i in 10: 
		var rats = rat_scene.instantiate()
		rats.position = rand_pos()
		rats.destination = $RatDestination.position
		rats.add_to_group("rats")
		add_child(rats)

		

func rand_pos():
	return Vector3(randf_range(4,40),1.2,randf_range(0.2, -8))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().get_nodes_in_group("light_enemies").size() <= 0:
		level_screen_show()
		
		

func level_screen_show():
	await get_tree().create_timer(2.0).timeout
	get_tree().paused = true
	var level_end_screen = level_complete.instantiate()
	add_child(level_end_screen)
	level_end_screen.fade_to_black()
	


func _on_timer_timeout():
	for i in 3: 
		var rats = rat_scene.instantiate()
		rats.position = rand_pos()
		rats.destination = $RatDestination.position
		rats.add_to_group("rats")
		add_child(rats)
