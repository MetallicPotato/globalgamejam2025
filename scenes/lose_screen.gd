extends Control

@export var PlayAgainLevel: PackedScene

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_button_pressed():
	Scoremanager.remaining_enemies = 100
	get_tree().change_scene_to_packed(PlayAgainLevel)
