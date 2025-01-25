extends Control

@export var MainLevel: PackedScene

func _on_button_pressed():
	get_tree().change_scene_to_packed(MainLevel)
