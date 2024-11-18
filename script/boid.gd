extends Node2D

class_name Boid

@export
var _irange_obj: CollisionShape2D

var _max_speed: float
var _alignment: float
var _cohesion : float
var _avoidance: float
var _avoidance_range: float
var _interact_range : float

var _bound : Vector2

var _player: Player
var _velocity : Vector2
var _rnd = RandomNumberGenerator.new()

func _ready() -> void:
	position  = Vector2(
		_rnd.randf_range(-_bound.x, _bound.x), 
		_rnd.randf_range(-_bound.y, _bound.y)
	)
	_velocity = Vector2.ZERO
	update()
	
func update() -> void:
	(_irange_obj.shape as CircleShape2D).radius = _interact_range

func distance(boid: Boid) -> float:
	var dp = position - boid.position
	return sqrt(dp.x * dp.x + dp.y * dp.y)
	
func move_closer() -> void:
	if $Range.boids.size() < 1:
		return
	
	var avg = Vector2.ZERO
	for boid in $Range.boids:
		avg += position - boid.position
		
	avg /= $Range.boids.size()
	_velocity -= avg / _alignment
	
func move_with() -> void:
	if $Range.boids.size() < 1:
		return
		
	var avg = Vector2.ZERO
	for boid in $Range.boids:
		avg += boid._velocity
		
	avg /= $Range.boids.size()
	_velocity += avg / _cohesion
	
func move_away() -> void:
	if $Range.boids.size() < 1:
		return
	
	var d       = Vector2.ZERO
	var n_close = 0
	for boid in $Range.boids:
		var dst = distance(boid)
		if dst < _avoidance_range:
			n_close += 1
			var dp = position - boid.position
			
			if dp.x >= 0:
				dp.x = sqrt(_avoidance_range) - dp.x
			else:
				dp.x = -sqrt(_avoidance_range) - dp.x
				
			if dp.y >= 0:
				dp.y = sqrt(_avoidance_range) - dp.y
			else:
				dp.y = -sqrt(_avoidance_range) - dp.y
				
			d += dp
			
	if n_close > 0:
		_velocity -= d / _avoidance
		
func move_player() -> void:
	var dp = position - _player.position
	if dp.x >= 0:
		dp.x = sqrt(_avoidance_range) - dp.x
	else:
		dp.x = -sqrt(_avoidance_range) - dp.x
		
	if dp.y >= 0:
		dp.y = sqrt(_avoidance_range) - dp.y
	else:
		dp.y = -sqrt(_avoidance_range) - dp.y
		
	_velocity -= dp * 2.0

func _process(_delta: float) -> void:
	move_closer()
	move_with()
	move_away()
	
	if _player != null:
		move_player()
	
	if abs(_velocity.length()) > _max_speed:
		var f = _max_speed / max(abs(_velocity.x), abs(_velocity.y))
		_velocity *= f
	
	if (position.x < -_bound.x and _velocity.x < 0) or (position.x > _bound.x and _velocity.x > 0):
		_velocity.x = -_velocity.x * _rnd.randf() 
	if (position.y < -_bound.y and _velocity.y < 0) or (position.y > _bound.y and _velocity.y > 0):
		_velocity.y = -_velocity.y * _rnd.randf() 
		
	position += _velocity
