extends Area2D

class_name BoidRange

var boids : Array[Boid]

func _ready() -> void:
	connect("area_entered", _on_area_entered)
	connect("area_exited" , _on_area_exited)
	
func _on_area_entered(area: Area2D) -> void:
	boids.append(area.get_parent())
	
func _on_area_exited(area: Area2D) -> void:
	boids.erase(area.get_parent())
