extends Node2D

func _on_Zona_Cuerdas_body_entered(body):
	if body.is_in_group("Characters"):
		body.global_position.y = $pos.global_position.y+2;
		body.set_physics_process(false);
		body.emit_signal("finished","Trepar")
		body.velocity.y = 0;
