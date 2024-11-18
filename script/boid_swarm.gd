extends Node

@export var max_speed: float = 10
@export var alignment: float = 100
@export var cohesion : float = 40
@export var avoidance: float = 5
@export var avoidance_range: float = 20
@export var interact_range : float = 100

@export var border: float = 25

@export var count = 20

var _bound: Vector2
var _rnd 	    = RandomNumberGenerator.new()
var _boid_scene = preload("res://scene/boid.tscn")

func apply_parameter(boid: Boid) -> void:
	boid._bound     = _bound
	boid._max_speed = max_speed
	boid._alignment = alignment
	boid._cohesion  = cohesion
	boid._avoidance = avoidance
	boid._avoidance_range = avoidance_range
	boid._interact_range  = interact_range

func update() -> void:
	for boid in get_children() as Array[Boid]:
		apply_parameter(boid)
		boid.update()

func _ready() -> void:
	_bound = get_viewport().get_visible_rect().size / 2 - Vector2(border, border)
	for i in range(count):
		var boid = _boid_scene.instantiate() as Boid
		apply_parameter(boid)
		add_child(boid)
	

func _process(delta: float) -> void:
	if Input.is_action_just_released("reset"):
		alignment = _rnd.randf_range(75, 100)
		cohesion  = _rnd.randf_range(30, 40)
		avoidance = _rnd.randf_range(1, 5)
		avoidance_range = _rnd.randf_range(20, 30)
		interact_range  = _rnd.randf_range(75, 100)
		update()
