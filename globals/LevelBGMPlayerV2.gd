extends AudioStreamPlayer

export(String) var id
export(String, FILE, "*.ogg") var intro_music
export(String, FILE, "*.ogg") var music_loop

func _ready():
	stream = load(intro_music)
	globals.connect("play_bgm", self, "_play_bgm")

func _play_bgm(mid, value):
	if id != mid:
		return
	
	# prints(mid, value)

	if value:
		if not is_connected("finished", self, "_after_intro"):
			connect("finished", self, "_after_intro")
		play()
	else:
		if is_connected("finished", self, "_after_intro"):
			disconnect("finished", self, "_after_intro")
		stop()

func _after_intro():
	stream = load(music_loop)
	disconnect("finished", self, "_after_intro")
	play()
