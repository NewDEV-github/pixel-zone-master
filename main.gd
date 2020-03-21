extends KinematicBody2D
func restart_position():
	set_position(Vector2(0, 0))
	$'Player'.position = Vector2(0, 0)
	$'PlayerCamera'.set_position(Vector2(144, 90))
func _ready():
	if str(OS.get_name()) == 'Android':
		$Admob.load_banner()
		$Admob.load_interstitial()
#		$Admob.connect("banner_loaded", self, 'adloaded')
#		$Admob.connect("interstitial_loaded", self, 'interstitialloaded')
func adloaded():
	$Admob.show_banner()
func interstitialloaded():
	$Admob.show_interstitial()



func _on_Area2D_body_entered(body):
	if body.has_method("hit_by_bullet"):
		body.call("hit_by_bullet")
