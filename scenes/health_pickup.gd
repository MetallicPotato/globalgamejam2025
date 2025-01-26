extends Area2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	if body.is_in_group("PLAYER"):
		monitoring = false
		body.get_node("HealthComponent").damage(-20)
		audio_stream_player_2d.play()
		animation_player.play("scale_down")
		await audio_stream_player_2d.finished
		queue_free()
