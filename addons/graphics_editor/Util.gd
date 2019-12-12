tool
extends Node

static func color_from_array(color_array):
	var r = color_array[0]
	var g = color_array[1]
	var b = color_array[2]
	var a = color_array[3]
	return Color(r, g, b, a)

static func random_color():
	return Color(randf(), randf(), randf())

static func random_color_alt():
	var rand = randi() % 6
	
	match rand:
		#red
		0:
			return Color.red
		#blue
		1:
			return Color.blue
		#green
		2:
			return Color.green
		#orange
		3:
			return Color.orange
		#yellow
		4:
			return Color.yellow
		#purple
		5:
			return Color.purple

static func get_line_string(file, number):
	return file.get_as_text().split("\n")[number - 1].strip_edges()

static func printv(variable):
	var stack = get_stack()[get_stack().size() - 1]
	var line = stack.line
	var source = stack.source
	var file = File.new()
	file.open(source, File.READ)
	var line_string = get_line_string(file, line)
	file.close()
	var left_p = line_string.find("(")
	var left_p_string = line_string.right(left_p + 1)
	var right_p = left_p_string.find(")")
	var variable_name = left_p_string.left(right_p)
	print("%s: %s" % [variable_name, variable])