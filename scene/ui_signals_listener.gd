extends Control

func _ready() -> void:
	UiSignals.connect("boid_alignment_change", _on_boid_alignment_change)
	UiSignals.connect("boid_cohesion_change", _on_boid_cohesion_change)
	UiSignals.connect("boid_avoidance_change", _on_boid_avoidance_change)
	UiSignals.connect("boid_avoidance_range_change", _on_boid_avoidance_range_change)
	UiSignals.connect("boid_interact_range_change", _on_boid_interact_range_change)
	
func _on_boid_alignment_change(value: float) -> void:
	$SwarmParameters/AlignmentValue.text = str(value).pad_decimals(2)
	
func _on_boid_cohesion_change(value) -> void:
	$SwarmParameters/CohesionValue.text = str(value).pad_decimals(2)
	
func _on_boid_avoidance_change(value) -> void:
	$SwarmParameters/AvoidanceValue.text = str(value).pad_decimals(2)
	
func _on_boid_avoidance_range_change(value) -> void:
	$SwarmParameters/AvoidanceRangeValue.text = str(value).pad_decimals(2)
	
func _on_boid_interact_range_change(value) -> void:
	$SwarmParameters/InteractRangeValue.text = str(value).pad_decimals(2)
