extends "res://Scripts/State Machine/state.gd"

func enter():
	owner.get_node("Anim").play("Attack");
	owner.get_node("BodyPivot/Sword/Collision").disabled = false;


func _on_Anim_animation_finished(anim_name):
	if anim_name == "Attack":
		emit_signal("finished","Idle");
		owner.get_node("BodyPivot/Sword/Collision").disabled = true;
