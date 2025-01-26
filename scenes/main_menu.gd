extends Control

@export var MainLevel: PackedScene

@onready var button_click = $button_click

func _on_button_pressed():
	button_click.play()
	await button_click.finished
	get_tree().change_scene_to_packed(MainLevel)
