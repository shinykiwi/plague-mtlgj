extends CharacterBody3D

@export var health = 10
@export var max_health = 10

@export var ACCELERATION = 10
@export var MAX_SPEED = 10
@export var FRICTION = 1000


@onready var sprite = $AnimatedSprite3D
@onready var playerDetectionZone = $PlayerDetectionZone

@onready var wanderController = $WanderController

enum{
	IDLE,
	WANDER,
	CHASE
}

var state = IDLE
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")



func _on_animated_sprite_3d_animation_finished():
	queue_free()

func handle_hit(damage):
	print("enemy was hit!")
	$AnimatedSprite3D.modulate = Color("ff3d3d")
	await get_tree().create_timer(.2).timeout
	$AnimatedSprite3D.modulate = Color(255,255,255)
	health -= 1
	$HealthBar3D.update(health, max_health)
	health -= damage
	if health <=0:
		print("death")
		sprite.play("death")
	else:
		sprite.play("attack")
		await get_tree().create_timer(2.0).timeout
		sprite.play("idle")

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	match state:
		IDLE:
			velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
			velocity.z = move_toward(velocity.x, 0, FRICTION * delta)
			seek_player()
			
			if wanderController.get_time_left() == 0:
				state = pick_random_state([IDLE, WANDER])
				wanderController.start_wander_timer(randf_range(1,3))
			
			
		WANDER:
			seek_player()
			
			if wanderController.get_time_left() == 0:
				state = pick_random_state([IDLE, WANDER])
				wanderController.start_wander_timer(randf_range(1,3))
				
			var direction = global_position.direction_to(wanderController.target_position)
			velocity = velocity.move_toward(direction * MAX_SPEED/2, ACCELERATION * delta)
			
			
				
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED/2, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x > 0
			
		
	move_and_slide()
			
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
		
func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
	
			
