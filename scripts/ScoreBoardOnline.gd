extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
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
func _process(delta):
	#load user's score
	score.open("user://other_saves/0.save", File.READ)
	score_0 = parse_json(score.get_line())
	print(score_0)
	score.close()
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