extends WindowDialog
var savedir = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS) + '/Pixel Zone/.data/settings/'
var leaderboard
var editor
var os = OS.get_name()
func _process(_delta):
	leaderboard = $VBoxContainer/LeaderBoard.pressed
	editor = $VBoxContainer/Editor.pressed


func _on_Button_pressed():
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
