extends Node

func _ready():
	info("SilentWolf log level: " + str(SilentWolf.config.log_level)) 
	
static func error(text):
	printerr(str(text))
	push_error(str(text))

static func info(text):
	if SilentWolf.config.log_level > 0:
		print(str(text))
	
static func debug(text):
	if SilentWolf.config.log_level > 1:
		print(str(text))
