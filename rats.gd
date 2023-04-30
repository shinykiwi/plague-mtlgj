extends CharacterBody3D
@export var destination = Vector3(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = velocity.move_toward(destination, 5 * delta)
	if position == destination:
		queue_free()
	
	move_and_slide()

