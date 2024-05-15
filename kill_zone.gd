extends Area2D

signal caiu

func _on_body_entered(body):
	#emit_signal("caiu")
	if body.has_method('dead'):
		body.dead.rpc()
