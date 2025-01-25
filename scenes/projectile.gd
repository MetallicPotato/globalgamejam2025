extends Area2D

func _on_body_entered(body):
	if body.is_in_group("PLAYER"):
		if body.shielded:
			print("Shielded!")
		else:
			print("Not Shielded!")
			body.get_node("HealthComponent").damage(10.0)
	else:
		queue_free()
