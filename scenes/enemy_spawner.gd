class_name EnemySpawner
extends Node2D

@export var Enemy: PackedScene

@onready var rng = RandomNumberGenerator.new()
@onready var path_follow_2d = $Path2D/PathFollow2D
@onready var spawn_timer = $SpawnTimer

var numspawns: int = 0

func _on_timer_timeout():
	var pathlocation = rng.randf_range(0, 1)
	path_follow_2d.progress_ratio = pathlocation
	
	var newEnemy = Enemy.instantiate()
	get_tree().root.add_child(newEnemy)
	newEnemy.global_position = path_follow_2d.global_position
	
	numspawns += 1
	
	if numspawns >= 50:
		spawn_timer.stop()
		return
	
	if numspawns >= 15:
		spawn_timer.wait_time = 1
		if numspawns >= 35:
			spawn_timer.wait_time = 0.5
