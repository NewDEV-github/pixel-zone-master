extends Node

var collected = 0 setget _set_collected, _get_collected
var to_collect = 0
var player

signal collected_changed
signal play_bgm(id, value)

func _set_collected(value):
	collected = value
	emit_signal("collected_changed")

func _get_collected():
	return collected

func play_bgm(id, value):
	emit_signal("play_bgm", id, value)








