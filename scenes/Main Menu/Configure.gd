extends WindowDialog
var savedir = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS) + '/Pixel Zone/.data/settings/'
onready var leaderboard = $VBoxContainer/LeaderBoard.pressed
onready var editor = $VBoxContainer/Editor.pressed
var os = OS.get_name()
func _process(_delta):
	var file = File.new()
	var dir = Directory.new()
	if leaderboard == true:
		file.open(str(savedir) + 'leaderboard.txt', File.WRITE)
	else:
		dir.remove(str(savedir) + 'leaderboard.txt')
	if editor == true:
		file.open(str(savedir) + 'editor.txt', File.WRITE)
	else:
		dir.remove(str(savedir) + 'editor.txt')
