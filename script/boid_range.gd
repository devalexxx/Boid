extends Area2D

class_name BoidRange

var boids : Array[Boid]

func _ready() -> void:
	connect("area_entered", _on_area_entered)
	connect("area_exited" , _on_area_exited)
	
func _on_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is Boid:
		boids.append(parent)
	
func _on_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is Boid:
		boids.erase(parent)
