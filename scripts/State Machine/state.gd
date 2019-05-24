extends Node

signal finished(next_state_name)

func enter():
	emit_signal("finished")

func update(delta):
	return delta

func exit():
	pass

func handle_input(evemt):
	return evemt

func _on_animation_finished(anim_name):
	return anim_name