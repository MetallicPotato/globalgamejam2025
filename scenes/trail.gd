class_name Trail
extends Line2D

const MAX_POINTS: int = 1000
@onready var curve := Curve2D.new()

func _process(delta):
	curve.add_point(get_parent().position)
	if curve.get_baked_points().size() > MAX_POINTS:
		curve.remove_point(0)
	points = curve.get_baked_points()

func stop() -> void:
	set_process(false)
	var tw := get_tree().create_tween()
	tw.tween_property(self, "modulate:a", 0.0, 1.5)
	await tw.finished
	queue_free()

static func create() -> Trail:
	var scn = preload("res://scenes/trail.tscn")
	return scn.instantiate()
