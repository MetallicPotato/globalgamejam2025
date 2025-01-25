extends CharacterBody2D


@export var speed = 300.0

func _physics_process(delta):
	if Input.is_action_just_pressed("shield"):
		print("Shield!")
		handle_shield()
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	
	move_and_slide()

func handle_shield():
	#TODO: add shield and detect perfect parries
	pass
