extends Control

var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var score = File.new()
var first
var second 
var third 
var fourth 
var fifth 
var loaded_score
var score_0
var score_1
var score_2
var score_3
var score_4
func _ready():
	#load user's score
	score.open_encrypted_with_pass("user://other_saves/0.save", File.READ, str(3087283))
	score_0 = score.get_line()
	print(score_0)
	score.close()
	var save_file = File.new()
	#Load current user's name
	save_file.open_encrypted_with_pass(str(documents)  + "/Pixel Zone/.data/name.save", File.READ, str(2345654))
	var loaded_name = save_file.get_line()
	$Panel/Names.add_item(str(loaded_name) + " - You")
	$Panel/Scores.add_item(str(score_0))
	#load other user's scores
	#1
	score.open('user://other_saves/1.save', File.READ)
	score_1 = parse_json(score.get_line())
	score.close()
	#2
	score.open('user://other_saves/2.save', File.READ)
	score_2 = parse_json(score.get_line())
	score.close()
	#3
	score.open('user://other_saves/3.save', File.READ)
	score_3 = parse_json(score.get_line())
	score.close()
	#4
	score.open('user://other_saves/4.save', File.READ)
	score_4 = parse_json(score.get_line())
	score.close()
	#count users from highest score to lower
