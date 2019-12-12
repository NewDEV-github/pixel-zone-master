tool
extends Control

const ScoreItem = preload("ScoreItem.tscn")

var list_index = 0

func _ready():
	var scores = SilentWolf.Scores.scores
	var local_scores = SilentWolf.Scores.local_scores
	
	if scores: 
		render_board(scores, local_scores) #null
	else:
		# use a signal to notify when the high scores have been returned, and show a "loading" animation until it's the case...
		add_loading_scores_message()
		yield(SilentWolf.Scores.get_high_scores(), "scores_received")
		hide_message()
		render_board(SilentWolf.Scores.scores, local_scores)

func render_board(scores, local_scores):
	var all_scores = merge_scores_with_local_scores(scores, local_scores)
	if !scores and !local_scores:
		add_no_scores_message()
	for score in scores:
		add_item(score.player_name, str(int(score.score)))

func merge_scores_with_local_scores(scores, local_scores):
	if local_scores:
		for score in local_scores:
			var in_array = score_in_score_array(scores, score)
			if !in_array:
				scores.append(score)
			scores.sort_custom(self, "sort_by_score");
	return scores.resize(10)
	
func sort_by_score(a, b):
	if a.score > b.score:
		return true;
	else:
		if a.score < b.score:
			return false;
		else:
			return true;
	
func score_in_score_array(scores, new_score):
	var in_score_array =  false
	if new_score and scores:
		for score in scores:
			if score.score_id == new_score.score_id: # score.player_name == new_score.player_name and score.score == new_score.score:
				in_score_array = true
	return in_score_array

func add_item(player_name, score):
	var item = ScoreItem.instance()
	list_index += 1
	item.get_node("PlayerName").text = str(list_index) + str(". ") + player_name
	item.get_node("Score").text = score
	item.margin_top = list_index * 100
	$"Board/HighScores/ScoreItemContainer".add_child(item)

func add_no_scores_message():
	var item = $"Board/MessageContainer/TextMessage"
	item.text = "No scores yet!"
	$"Board/MessageContainer".show()
	item.margin_top = 135
	
func add_loading_scores_message():
	var item = $"Board/MessageContainer/TextMessage"
	item.text = "Loading scores..."
	$"Board/MessageContainer".show()
	item.margin_top = 135
	
func hide_message():
	$"Board/MessageContainer".hide()

func _on_CloseButton_pressed():
	var scene_name = SilentWolf.scores_config.open_scene_on_close
	print("scene name: " + str(scene_name))
	get_tree().change_scene(scene_name)


func _on_Button2_pressed():
	get_tree().change_scene("res://addons/silent_wolf/Auth/Register.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://addons/silent_wolf/Auth/Login.tscn")
