extends Area3D

@export var damage = 1


func _on_body_entered(body):
	if body.has_method("handle_hit"):
		body.handle_hit(damage)
			
