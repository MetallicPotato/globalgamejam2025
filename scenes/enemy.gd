extends CharacterBody2D

const SPEED = 220.0

@export var Projectile: PackedScene

@onready var nav = $NavigationAgent2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("PLAYER")
@onready var projectile_cooldown = $ProjectileCooldown

var canShoot: bool = true
var shouldMove: bool = true

func _physics_process(_delta):
	if is_instance_valid(player):
		if player.global_position.distance_to(global_position) <= 650.0:
			shouldMove = false
			if projectile_cooldown.is_stopped():
				projectile_cooldown.start()
				var p = Projectile.instantiate()
				owner.add_child(p)
				var pdirection = (global_position - player.global_position).normalized() * -1
				p.position = (pdirection * 75) + global_position
				p.set_direction(pdirection)
		else:
			shouldMove = true
			
		if shouldMove:
			nav.target_position = player.global_position
			var direction = nav.get_next_path_position() - global_position
			direction = direction.normalized()
			velocity = direction * SPEED
			move_and_slide()
		#TODO: stop at certain distance to player and shoot projectile


func _on_health_component_out_of_health():
	queue_free()

func _on_health_component_health_changed(newhealth):
	print("Enemy Damaged!") #TODO: visualize damage
