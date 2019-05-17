extends Area2D

func _on_Trap_body_entered(body):
	if body.name == "player" and !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("trigger")
		if body.has_method("dd"):
			body.call("dd")