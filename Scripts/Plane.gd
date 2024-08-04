extends Area2D

@export var slow : float

func _on_area_entered(area):
	if area.is_in_group("Player"):
		GetPlane.play()
		get_parent().get_parent().get_node("Wave").slowdown += slow
		queue_free()
