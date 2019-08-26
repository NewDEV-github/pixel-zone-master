extends Label
var ms = 0
var s = 0
var m = 0
var time
func _process(delta):
	if ms > 9:
		s += 1
		ms = 0
	if s > 59:
		m += 1
		s = 0
	set_text(str(m)+":"+str(s)+":"+str(ms))
	time = set_text(str(m)+":"+str(s)+":"+str(ms))



func _on_Timer_timeout():
	ms += 1
	
func save():
	var save_dict = 'null'
