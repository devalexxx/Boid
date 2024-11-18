extends Area2D

class_name PlayerRange

var boids : Array[Boid]

func _ready() -> void:
	connect("area_entered", _on_area_entered)
	connect("area_exited" , _on_area_exited)
	
func _on_area_entered(area: Area2D) -> void:
	(area.get_parent() as Boid)._player = get_parent() as Player
	boids.append(area.get_parent())
	
func _on_area_exited(area: Area2D) -> void:
	(area.get_parent() as Boid)._player = null
	boids.erase(area.get_parent())
