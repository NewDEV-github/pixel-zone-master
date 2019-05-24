extends "res://Scripts/State Machine/state.gd"

func enter():
	owner.get_node("Anim").play("Idle")

func handle_input(event):
	if Input.is_action_just_pressed("ui_up"):
		if owner.is_on_floor():
			owner.velocity.y = 0
			emit_signal("finished","Jump")
	
	if Input.is_action_pressed("ui_down"):
		emit_signal("finished","Crouch");
	
	if owner.sword and Input.is_action_just_pressed("ui_accept"):
		emit_signal("finished","Attack")
	
	return event

func update(delta):
	if owner.direction.x != 0:
		emit_signal("finished","Move")
	return delta