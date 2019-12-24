extends WindowDialog
var savedir = OS.get_system_dir(_OS.SYSTEM_DIR_DOCUMENTS) + '/Pixel Zone/.data/settings/'
var leaderboard = $VBoxContainer/LeaderBoard.pressed
var editor = $VBoxContainer/Editor.pressed
var file = File.new()
var dir = Directory.new()
func _process(delta):
	if leaderboard == true:
		file.open(str(savedir) + 'leaderboard.txt', _File.WRITE)
	else:
		dir.remove(str(savedir) + 'leaderboard.txt')
	if editor == true:
		file.open(str(savedir) + 'editor.txt', _File.WRITE)
	else:
		dir.remove(str(savedir) + 'editor.txt')
