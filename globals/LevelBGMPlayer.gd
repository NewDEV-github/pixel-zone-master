extends AudioStreamPlayer

export(String) var id

func _ready():
	globals.connect("play_bgm", self, "_play_bgm")

func _play_bgm(mid, value):
	if id != mid:
		return
	
	# prints(mid, value)

	if value:
		play()
	else:
		stop()

