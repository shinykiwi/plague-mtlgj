extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func fade_to_black():
	print("success")
	$Display/AnimationPlayer.play("fade_to_black")
