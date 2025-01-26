extends Node

var remaining_enemies: int = 100

func remove_enemy():
	remaining_enemies -= 1
	if remaining_enemies <= 0:
		print("win!")
