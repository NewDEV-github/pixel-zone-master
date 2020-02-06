extends Control

# Declare member variables here. Examples:
# var a = 2
#var admob = null
#var isReal = true
#var isTop = true
#var adBannerId = "ca-app-pub-3142193952770678/7369767442" # [Replace with your Ad Unit ID and delete this message.]
#var adInterstitialId = "ca-app-pub-3142193952770678/9337455234" # [Replace with your Ad Unit ID and delete this message.]
#var adRewardedId = "ca-app-pub-3142193952770678/8372051443" # [There is no testing option for rewarded videos, so you can use this id for testing]
#
## Loaders
#
#func loadBanner():
#	if admob != null:
#		admob.loadBanner(adBannerId, isTop)
#
#func loadInterstitial():
#	if admob != null:
#		admob.loadInterstitial(adInterstitialId)
#
#func loadRewardedVideo():
#	if admob != null:
#		admob.loadRewardedVideo(adRewardedId)

# Called when the node enters the scene tree for the first time.
func _ready():
	#	print(str(downloadserver.get_data()))
#	print(str(gamesite.get_data()))
#	print(str(mainserver.get_data()))
#	if(Engine.has_singleton("AdMob")):
#		admob = Engine.get_singleton("AdMob")
#		admob.init(isReal, get_instance_id())
#		loadBanner()
#		loadInterstitial()
#		loadRewardedVideo()
#	admob.showBanner()
#	get_tree().connect("screen_resized", self, "onResize")

#	var date_day = str(OS.get_date().day)
	var date_month = str(OS.get_date().month)
#	var date_year = str(OS.get_date().year)
	var file = File.new()
	file.open('user://date.dat', File.WRITE)
	file.store_line(str(date_month))
	background_load.load_scene("res://scenes/Main Menu/GUI.tscn")
	if OS.get_name() == 'Android':
		OS.alert("We need permissions to save game data on your device. Allow it in Application's settings. Thanks!", 'Permissions!')
