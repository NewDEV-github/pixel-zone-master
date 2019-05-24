extends TextureRect

signal item_tap

var item = null
var enter = false


func _ready():
	expand = true
	return connect("mouse_exited",self,"mouse_exited") or connect("mouse_entered",self,"mouse_enter")

func _input(event):
	if event is InputEventMouse:
		if event.is_pressed() and enter and item and !get_parent().temporal_item:
			emit_signal("item_tap",item);
			texture = null
			item = null;
		elif event.is_pressed() and enter and !item and get_parent().get_temporal_item():
			item = get_parent().get_temporal_item();
			texture = item.itemImage;
			get_parent().set_temporal_item(null);
		elif event.is_pressed() and enter and item and get_parent().temporal_item:
			var temporal_item = get_parent().get_temporal_item();
			emit_signal("item_tap",item);
			get_parent().remove_child(temporal_item);
			item = temporal_item;
			texture = item.itemImage;

func pick_item(itemPick):
	item = load(itemPick).instance();
	add_child(item);
	texture = item.itemImage;
	remove_child(item);

func mouse_exited():
	enter = false;

func mouse_enter():
	enter = true;
