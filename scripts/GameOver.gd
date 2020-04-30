extends Control
var admob = null
var adBannerId = "ca-app-pub-3142193952770678/7369767442" # [Replace with your Ad Unit ID and delete this message.]
var adInterstitialId = "ca-app-pub-3142193952770678/9337455234" # [Replace with your Ad Unit ID and delete this message.]
var adRewardedId = "ca-app-pub-3142193952770678/8372051443" # [There is no testing option for rewarded videos, so you can use this id for testing]
var isReal = true
var isTop = true

func _ready():
	globals._send_data()
	if str(OS.get_name()) == 'Android':
		$Admob.load_banner()
		$Admob.load_interstitial()
#		$Admob.connect("banner_loaded", self, 'adloaded')
#		$Admob.connect("interstitial_loaded", self, 'interstitialloaded')
func adloaded():
	pass
func interstitialloaded():
	pass

func _on_Button2_pressed():
	get_tree().change_scene("res://scenes/Main Menu/GUI.tscn")
func _on_Button_pressed():
	get_tree().quit()
