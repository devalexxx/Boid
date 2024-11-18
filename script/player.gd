extends Node2D

class_name Player

@export var border: float

var _bound: Vector2

func _ready() -> void:
	_bound = get_viewport().get_visible_rect().size / 2 - Vector2(border, border)

func _process(delta: float) -> void:
	var mpos = get_viewport().get_mouse_position() - _bound - Vector2(border, border)
	position.x = maxf(minf(_bound.x, mpos.x), -_bound.x)
	position.y = maxf(minf(_bound.y, mpos.y), -_bound.y)
