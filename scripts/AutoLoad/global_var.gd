extends Node

var lives = 3 setget set_lives, get_lives;

func set_lives(newLives):
	lives = newLives;
	if lives == 0:
		get_tree().quit();
		return;

func get_lives():
	return lives;