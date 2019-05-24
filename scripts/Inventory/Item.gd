extends Node

var itemName = "" setget set_item_name, get_item_name;
var itemCant = 0 setget set_item_cant, get_item_cant;
onready var itemImage : Texture setget set_item_image, get_item_image;

func _ready():
	add_to_group("Items");

func set_item_name(newItemName):
	itemName = newItemName;
	return itemName;

func get_item_name():
	return itemName;

func set_item_cant(newCant):
	itemCant = newCant;
	return itemCant;

func get_item_cant():
	return itemCant;

func set_item_image(loadImage):
	itemImage = loadImage;
	return itemImage;

func get_item_image():
	return itemImage;