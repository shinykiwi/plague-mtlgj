extends Node3D

@export var wander_range = 16
@onready var start_position = global_position
@onready var target_position = global_position
@onready var timer = $Timer

func update_target_position():
	var target_vector = Vector3(randf_range(-wander_range, wander_range),0, randf_range(-wander_range,wander_range))
	target_position = start_position + target_vector


func get_time_left():
	return timer.get_time_left()
	
func start_wander_timer(duration):
	timer.start(duration)
	
func _on_timer_timeout():
	update_target_position()
