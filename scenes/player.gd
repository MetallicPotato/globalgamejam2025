extends CharacterBody2D

@export var speed = 300.0

@onready var shield_sprite = $ShieldSprite
@onready var collision_shape = $CollisionShape2D
@onready var shield_timer = $ShieldParryTimer
@onready var speed_timer = $SpeedBoostTimer

var shielded: bool = false
var canParry: bool = false

func _physics_process(_delta):
	if Input.is_action_just_pressed("shield"):
		handle_shield(true)
	elif Input.is_action_just_released("shield"):
		handle_shield(false)
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	
	move_and_slide()

func handle_shield(active: bool):
	if active:
		shield_sprite.visible = true
		collision_shape.shape.radius = 62.0
		shielded = true
		shield_timer.start()
		canParry = true
	else:
		shield_sprite.visible = false
		collision_shape.shape.radius = 38.0
		shielded = false


func _on_health_component_health_changed(newhealth):
	print(newhealth)


func _on_health_component_out_of_health():
	print("You Are Dead!")


func _on_shield_parry_timer_timeout():
	canParry = false

func speed_boost():
	if speed_timer.is_stopped():
		speed *= 3
		speed_timer.start()

func _on_speed_boost_timer_timeout():
	speed /= 3
