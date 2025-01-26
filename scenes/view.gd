extends Node2D

@export var player: CharacterBody2D

@onready var animation_player = $AnimationPlayer

func _ready():
	player.OnParry.connect(on_parry)

func on_parry():
	animation_player.play("camera_anim")
