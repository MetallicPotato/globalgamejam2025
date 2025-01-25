extends CharacterBody2D


const SPEED = 25.0

@onready var nav = $NavigationAgent2D
@onready var player = get_tree().get_first_node_in_group("PLAYER")

func _physics_process(_delta):
	if is_instance_valid(player):
		nav.target_position = player.global_position
		var direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = direction * SPEED
		move_and_slide()
		
		#TODO: stop at certain distance to player and shoot projectile


func _on_health_component_out_of_health():
	queue_free()


func _on_health_component_health_changed(newhealth):
	pass #TODO: visualize damage
