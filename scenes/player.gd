extends CharacterBody2D

@export var speed = 300.0

@onready var shield_sprite = $ShieldSprite
@onready var collision_shape = $CollisionShape2D
@onready var shield_timer = $ShieldParryTimer
@onready var speed_timer = $SpeedBoostTimer
@onready var shield_cooldown = $ShieldCooldownTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $CanvasLayer/HealthBar
@onready var anim_sprite = $AnimatedSprite2D

var shielded: bool = false
var canParry: bool = false
var parries_in_a_row: int = 0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(_delta):
	if Input.is_action_just_pressed("shield"):
		handle_shield(true)
	elif Input.is_action_just_released("shield"):
		handle_shield(false)
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	handle_animation(direction)
	
	move_and_slide()

func handle_shield(active: bool):
	if active and shield_cooldown.is_stopped():
		shield_sprite.visible = true
		collision_shape.shape.radius = 58.0
		collision_shape.shape.height = 122.0
		shielded = true
		shield_timer.start()
		canParry = true
		shield_cooldown.start()
	else:
		shield_sprite.visible = false
		collision_shape.shape.radius = 15.0
		collision_shape.shape.height = 70.0
		shielded = false

func handle_animation(direction: Vector2):
	if velocity.length() < 5:
		if direction.y < -0.3:
			anim_sprite.play("idle_u")
		elif direction.y > 0.3:
			anim_sprite.play("idle_d")
		else:
			if direction.x < -0.3:
				anim_sprite.play("idle_l")
			elif direction.x > 0.3:
				anim_sprite.play("idle_r")
			else:
				anim_sprite.play("idle_d")
	else:
		if direction.y < -0.3:
			anim_sprite.play("run_u")
		elif direction.y > 0.3:
			anim_sprite.play("run_d")
		else:
			if direction.x < -0.3:
				anim_sprite.play("run_l")
			elif direction.x > 0.3:
				anim_sprite.play("run_r")
			else:
				anim_sprite.play("run_d")

func _on_health_component_health_changed(newhealth):
	print(newhealth)
	if newhealth == health_component.MaxHealth:
		health_bar.visible = false
	else:
		health_bar.visible = true
		health_bar.value = newhealth

func _on_health_component_out_of_health():
	get_tree().change_scene_to_file("res://scenes/lose_screen.tscn")

func _on_shield_parry_timer_timeout():
	canParry = false

func parry():
	if speed_timer.is_stopped():
		speed *= 3
		speed_timer.start()
	parries_in_a_row += 1
	if parries_in_a_row >= 3:
		print("3 in a row!")

func noparry():
	parries_in_a_row = 0

func _on_speed_boost_timer_timeout():
	speed /= 3
