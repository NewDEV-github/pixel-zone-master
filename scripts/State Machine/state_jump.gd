extends "res://Scripts/State Machine/state.gd"

func enter():
	owner.velocity.y = -owner.jump_speed
	owner.get_node("Anim").play("Jump")
	owner.velocity.x = 0
	owner.move_and_slide(owner.velocity,Vector2(0,-1))

func update(delta):
	if owner.is_on_floor():
		emit_signal("finished","Idle")
		return
	move(owner.speed,owner.direction,delta)
	
func move(speed, direction, delta):
	owner.velocity.x = direction.x * speed
	owner.move_and_slide(owner.velocity, Vector2(0,-1))
	return delta