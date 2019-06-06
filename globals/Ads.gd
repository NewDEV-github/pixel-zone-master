extends Control
var AdMob = Engine.get_singleton("AdMob")
var AdColony = Engine.get_singleton("GDAdColony")
var Mopub = Engine.get_singleton("GDMopub")


func _AdMob():
	var _dict = Dictionary()
	_dict["BannerAd"] = false
	_dict["InterstitialAd"] = false
	_dict["RewardedVideoAd"] = false
	_dict["BannerGravity"] = "BOTTOM" # or TOP
	_dict["BannerAdId"] = "your banner ad id"
	_dict["InterstitialAdId"] = "your interstitial ad id"
	_dict["RewardedVideoAdId"] = "rewarded video ad id"
	AdMob.init(_dict, get_instance_id())
func _AdColony():
	var _dict = Dictionary()
	_dict["app_id"] = "adcolotn app id"
	_dict["zone_ids"] = "adcolony interstitial zone ids" # (e.g) "jkedbciujdcoidcj,iyhfecujncuofevef,ikyvejcnilnuvel"
	_dict["reward_ids"] = "adcolony rewarded zone id" # (e.g) "jkedbciujdcoidcj,iyhfecujncuofevef,ikyvejcnilnuvel"
	_dict["dialog"] = true # or false
	AdColony.init(_dict, get_instance_id())
func _Mopub():
	var _dict = Dictionary()
	_dict["BannerAd"] = true
	_dict["InterstitialAd"] = true
	_dict["BannerGravity"] = "BOTTOM" # or TOP
	_dict["BannerAdId"] = "your banner unit id"
	_dict["InterstitialAdId"] = "your interstitial unit id"
	Mopub.init(_dict, get_instance_id())
	