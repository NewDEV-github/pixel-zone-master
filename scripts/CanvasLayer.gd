extends CanvasLayer

var int_lives = global_var.get_lives();

func _process(delta):
	$LifeBar.frame = int_lives-global_var.get_lives();
	return delta;