extends Control
var admob = null
var adBannerId = "ca-app-pub-3142193952770678/7369767442" # [Replace with your Ad Unit ID and delete this message.]
var adInterstitialId = "ca-app-pub-3142193952770678/9337455234" # [Replace with your Ad Unit ID and delete this message.]
var adRewardedId = "ca-app-pub-3142193952770678/8372051443" # [There is no testing option for rewarded videos, so you can use this id for testing]
var isReal = true
var isTop = true

func _ready():
	if str(OS.get_name()) == 'Android':
		ads.admob.showBanner()

func _on_Button2_pressed():
	if str(OS.get_name()) == 'Android':
		ads.admob.showInterstitial()
	get_tree().change_scene("res://scenes/Main Menu/GUI.tscn")
func _on_Button_pressed():
	if str(OS.get_name()) == 'Android':
		ads.admob.showInterstitial()
	get_tree().quit()
