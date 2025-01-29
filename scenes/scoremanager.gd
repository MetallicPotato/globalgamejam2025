extends Node

signal OnRemove
signal OnWin

var remaining_enemies: int = 50

func remove_enemy():
	remaining_enemies -= 1
	OnRemove.emit()
	if remaining_enemies <= 0:
		OnWin.emit()
