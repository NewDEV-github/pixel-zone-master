extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _show():
	$AnimationPlayer.play("show")
func _hide():
	$AnimationPlayer.play("hide")


func _on_Button_pressed():
	var body = str($Feedback/TextEdit.text) + "                              " + str($Feedback/LineEdit.text)
	OS.shell_open("mailto:karoltomaszewskimusic@gmail.com?body=" + body)
	$AcceptDialog.popup_centered()
	_hide()


func _on_Button2_pressed():
	_hide()
