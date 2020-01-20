extends KinematicBody2D
var img_path
var name_
func save():
	var val = $'../Panel/HBoxContainer/Right/HBoxContainer3/HSlider2.value'
#	$Panel/HBoxContainer/Left/CenterContainer/Tile/Tile/CollisionShape2D/ColorRect.hide()
	var save_dir = str(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)+ '/Pixel Zone/Custom Tiles/')
	var packed_scene = PackedScene.new()
	packed_scene.pack($'.')
	ResourceSaver.save(str(save_dir + name_ + '.tscn'), packed_scene)
	var dir = Directory.new()
#	$Panel/HBoxContainer/Left/CenterContainer/Tile/Tile/CollisionShape2D/ColorRect.show()
	dir.copy(str(img_path), str(save_dir + '/' + name_ + '.png'))
