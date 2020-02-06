extends KinematicBody2D
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

func restart_position():
	set_position(Vector2(0, 0))
	$'Player'.position = Vector2(0, 0)
	$'Player_ai2'.set_position(Vector2(144, 90))
	
func _process(_delta):
#	print(str(is_instance_valid($Player_ai2)))
	var pos_y = $Player.position.y
	var pos_x = $Player.position.x
	var length = ($Player.position - $Player_ai2.position).length()
	if length >= 900:
		$Player_ai2.set_position(Vector2(float(pos_x - 3), float(pos_y - 3)))



