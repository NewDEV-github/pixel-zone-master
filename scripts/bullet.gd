extends RigidBody2D
func _on_bullet_body_enter(body):
	if body.has_method("hit_by_bullet"):
		body.call("hit_by_bullet")

func _on_Timer_timeout():
	$animation.play("shutdown")

func _on_player_size():
	set_scale(Vector2(0.5, 0.5))
