extends KinematicBody2D
func restart_position():
	set_position(Vector2(0, 0))
	$'Player'.position = Vector2(0, 0)
	$'PlayerCamera'.set_position(Vector2(144, 90))
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
	if str(OS.get_name()) == 'Android':
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



func _on_Area2D2_body_entered(body):
	if body.name == 'Enemy':
		$Player/ui/Control/ProgressBar.value -= 5
