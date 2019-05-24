extends "res://Scripts/State Machine/state.gd"

export var forceAttack : int = 1;

func enter():
	owner.get_node("Anim").play("Damage");

func handle_input(event):
	return event;

func update(delta):
	move(owner.speed, owner.direction, delta);

func move(speed, direction,delta):
	owner.velocity.x = direction.x * speed;
	owner.move_and_slide(owner.velocity, Vector2(0,-1));
	return delta;

func _on_Anim_animation_finished(anim_name):
	if anim_name == "Damage":
		emit_signal("finished","Idle");
		global_var.set_lives(global_var.get_lives()-forceAttack);
