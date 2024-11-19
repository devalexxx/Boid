extends Sprite2D

var elapsed_time = 0.0

func _process(delta):
	elapsed_time += delta
	# Exemple : Variation de teinte dans un cycle RGB
	modulate = Color(
		abs(sin(elapsed_time)), # Rouge
		abs(cos(elapsed_time)), # Vert
		abs(sin(elapsed_time + 1.0)), # Bleu
		1.0 # Opacité fixe
	)
