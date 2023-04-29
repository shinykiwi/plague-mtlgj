extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var sprite = $AnimatedSprite3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var just_attacked = 0


func attack():
	sprite.play("attack")
	just_attacked = 10
	

func jump():
	velocity.y = JUMP_VELOCITY
	sprite.play("jump")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		jump()
		
	elif Input.is_action_just_pressed("Attack"):
		attack()
			
	else:
		if just_attacked:
			sprite.play("attack")
			just_attacked -= 1
				
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			
		elif direction: 
			
			if is_on_floor():
				sprite.play("walk")
			else:
				sprite.play("jump")
				
			
			if direction.x < 0:
				sprite.flip_h = true
			else:
				sprite.flip_h = false
					
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		
		else:
			sprite.stop()
			if is_on_floor():
				sprite.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)


	move_and_slide()


func _on_animated_sprite_3d_animation_finished():
	print("got hereeee")
	if $AnimatedSprite3D.animation == "attack":
		print("got here")
		await get_tree().create_timer(2.0).timeout
		sprite.stop()
