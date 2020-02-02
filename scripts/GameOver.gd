extends Control
var admob = null
var adBannerId = "ca-app-pub-3142193952770678/7369767442" # [Replace with your Ad Unit ID and delete this message.]
var adInterstitialId = "ca-app-pub-3142193952770678/9337455234" # [Replace with your Ad Unit ID and delete this message.]
var adRewardedId = "ca-app-pub-3142193952770678/8372051443" # [There is no testing option for rewarded videos, so you can use this id for testing]
var isReal = true
var isTop = true

func _ready():
	if(Engine.has_singleton("AdMob")):
		print('HAS SINGLETON')
		admob = Engine.get_singleton("AdMob")
		admob.init(isReal, get_instance_id())
		loadBanner()
		loadInterstitial()
		loadRewardedVideo()
	admob.showBanner()
func loadBanner():
	if admob != null:
		admob.loadBanner(adBannerId, isTop)

func loadInterstitial():
	if admob != null:
		admob.loadInterstitial(adInterstitialId)
		
func loadRewardedVideo():
	if admob != null:
		admob.loadRewardedVideo(adRewardedId)

func _game_over():
	show()
	$AnimationPlayer.play("game_over")


func _on_Button2_pressed():
	admob.showInterstitial()
	background_load.load_scene("scenes/Main Menu/GUI.tscn")
func _on_Button_pressed():
	admob.showInterstitial()
	get_tree().quit()
