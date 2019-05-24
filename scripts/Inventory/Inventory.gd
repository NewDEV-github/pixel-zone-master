extends Control

const cld = TextureRect

onready var tilemap_inventory = $TileMap;

# Cabtudades de celdas, items, etc.
var list_inventory_types = ["V","H"];
export var inventory_type = ""; # V = Vertical; H = Horizontal

export var not_tiles = 2

export var cant_horizontal_cld : int;
export var cant_vertical_cld : int;

var temporal_item = null setget set_temporal_item, get_temporal_item;

func _ready():
	if inventory_type in list_inventory_types:
		if inventory_type == list_inventory_types[0]:  # Vertical Mode;
			for y in cant_vertical_cld+not_tiles:
				if y == 0:
					pass
				elif y > 0 and y < cant_vertical_cld-1:
					pass
				elif y == cant_vertical_cld-1:
					pass
		if inventory_type == list_inventory_types[1]: # Horizontal Mode;
			for x in cant_horizontal_cld+not_tiles:
				if x == 0:
					tilemap_inventory.set_cell(x,0,0)
				elif x > 0 and x < cant_horizontal_cld-1:
					tilemap_inventory.set_cell(x,0,1)
					create_cld_inventory(x,0) # Se crean los lugares de los items
				elif x == cant_horizontal_cld-1:
					tilemap_inventory.set_cell(x,0,2)
	
	rect_size.x = tilemap_inventory.cell_size.x*tilemap_inventory.get_used_cells().size();
	rect_size.y = tilemap_inventory.cell_size.y*cant_vertical_cld;

func _process(delta):
	if temporal_item:
		temporal_item.global_position = get_global_mouse_position()
	elif !temporal_item:
		for child in get_children():
			if child.is_in_group("Items"):
				remove_child(child)
	
	return delta

func generate_item(path_item):
	for i in get_children():
		if i.script != null and !i.item:
			i.pick_item(path_item)
			return
		else:
			print("No hay espacio")

func create_cld_inventory(x,y):
	var newCld = cld.new();
	newCld.script = load("res://Scripts/Inventory/cld.gd");
	newCld.connect("item_tap",self,"set_temporal_item");
	add_child(newCld);
	newCld.rect_size = Vector2(16,16);
	newCld.rect_position = tilemap_inventory.map_to_world(Vector2(x,y));
	newCld.rect_position.y += tilemap_inventory.cell_size.y/4;
	return newCld;

func set_temporal_item(t_item):
	temporal_item = t_item
	if !t_item:
		return
	add_child(temporal_item)
	temporal_item.z_index = 10
#	get_node("Name").text = "Item Name -> "+temporal_item.itemName;
	return temporal_item

func get_temporal_item():
	return temporal_item;