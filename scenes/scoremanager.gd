extends Node

signal OnRemove

var remaining_enemies: int = 50

func remove_enemy():
	remaining_enemies -= 1
	OnRemove.emit()
	if remaining_enemies <= 0:
		print("win!")
