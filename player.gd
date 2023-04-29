extends CharacterBody2D


@export var speed = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed
	print(input_direction)
	# right
	if input_direction == Vector2(1,0):
		$AnimatedSprite2D.play("side")
		$AnimatedSprite2D.flip_h = true
	# left
	elif input_direction == Vector2(-1,0):
		$AnimatedSprite2D.play("side")
		$AnimatedSprite2D.flip_h = false
	# up
	elif input_direction == Vector2(0, -1):
		$AnimatedSprite2D.play("down")
	# down
	elif input_direction == Vector2(0,1):
		$AnimatedSprite2D.play("down")
		
		

func _physics_process(delta):
	get_input()
	move_and_slide()


