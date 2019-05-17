extends Node2D
func _on_StaticBody2D_body_entered(body):
	if body.name == "player":
		if body.has_method("weapon_up"):
			body.call("weapon_up")