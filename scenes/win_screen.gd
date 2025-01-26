extends Control

@export var PlayAgainLevel: PackedScene

@onready var button_click = $button_click

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_button_pressed():
	button_click.play()
	await button_click.finished
	Scoremanager.remaining_enemies = 100
	get_tree().change_scene_to_packed(PlayAgainLevel)
