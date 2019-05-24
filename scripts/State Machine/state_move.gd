extends "res://Scripts/State Machine/state.gd"

func enter():
	owner.get_node("Anim").play("Move");

func handle_input(event):
	if owner.sword and Input.is_action_just_pressed("ui_accept"):
		emit_signal("finished","Attack");
		owner.velocity = Vector2(0,0);
		return;
	
	return event

func update(delta):
	if owner.direction.x == 0:
		emit_signal("finished","Idle")
	if owner.is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			emit_signal("finished","Jump")
			return
	move(owner.speed, owner.direction, delta)

func move(speed, direction,delta):
	owner.velocity.x = direction.x * speed
	owner.move_and_slide(owner.velocity, Vector2(0,-1))
	return delta