extends Area2D

var speed = 450

var direction
var shouldmove: bool = false

func _on_body_entered(body):
	if body.is_in_group("PLAYER"):
		if body.shielded:
			if body.canParry:
				direction = -direction
				speed *= 1.5
				body.parry()
			else:
				body.noparry()
				queue_free()
		else:
			body.get_node("HealthComponent").damage(10.0)
			body.noparry()
			queue_free()
	elif body.is_in_group("ENEMY"):
		body.get_node("HealthComponent").damage(10.0)
		queue_free()
	else:
		queue_free()

func set_direction(newdirection):
	direction = newdirection
	shouldmove = true

func _physics_process(delta):
	if shouldmove:
		position += direction * speed * delta
