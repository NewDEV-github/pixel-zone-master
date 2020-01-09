extends Node

func _ready():
	info("SilentWolf log level: " + str(SilentWolf.config.log_level)) 
	
static func error(text):
	printerr(str(text))

static func info(text):
	print(str(text))
	
static func debug(text):
	print(str(text))
