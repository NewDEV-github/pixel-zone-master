extends Control
signal finished_anim

var center						:	Vector2
var logo_scale_coef		=	0.3
var shine_sw					=	false
var mouth_cnt				=	0

func _ready():
	center								=	get_viewport_rect().size/2
	#CONTROL
	rect_pivot_offset				=	center
	rect_size							=	get_viewport_rect().size
	rect_position.y					-=	80
	$face.rect_position			=	center*0.7 + Vector2(0,-60)
	$face.rect_scale				*=	logo_scale_coef
	$mouth.rect_position			=	center*0.7 + Vector2(0,-61)
	$mouth.rect_scale				*=	logo_scale_coef

	$G1.rect_position = center + Vector2(-170,160)
	$O2.rect_position = center + Vector2(-98,160)
	$D3.rect_position = center + Vector2(-22,160)
	$O4.rect_position = center + Vector2(48,160)
	$T5.rect_position = center + Vector2(124,160)
	$Subtitle.rect_position = center + Vector2(-90,270)
	$Subtitle.modulate.a=0.01
	$G1.modulate.a=0.01
	$O2.modulate.a=0.01
	$D3.modulate.a=0.01
	$O4.modulate.a=0.01
	$T5.modulate.a=0.01
	#NODE2D
	$Logo.scale				*=	logo_scale_coef
	$Logo.position			=	center
	$Logo/Glide.position	+=	Vector2(900,80)

	$Logo/Light2D2.position += Vector2(0,10)

	$Logo/Shade.energy = 0.1

func _on_Start_timeout():
#	start_anim()
	pass

func start_anim():
	$Tune.play()
	$Logo/Particles2D.emitting = true
	$face.modulate.a = 0.01
	$mouth.modulate.a = 0.01
	$Logo/Light2D2.energy = 0.01
	$Logo/Light2D2.texture_scale = 0.01
	$face.show()
	$mouth.show()
	$AnimDelay.start()
	$Text.start()
	$Glide.start()
	$MouthDelay.start()

func _on_AnimDelay_timeout():
	$Anim.start()
	$ShineDelay.start()
	shine_sw = true

func _on_Anim_timeout():
	if $face.modulate.a < 1:
		$face.modulate.a *= 1.1
		$mouth.modulate.a *= 1.1
	elif $Logo/Shade.energy < 0.5:
		$Logo/Shade.energy *= 1.2
	if shine_sw:
		if $Logo/Light2D2.energy < 1:
			$Logo/Light2D2.energy *= 1.1
	if $Logo/Light2D2.texture_scale < 1.1:
		$Logo/Light2D2.texture_scale += 0.015

func _on_ShineDelay_timeout():
	shine_sw = true


func _on_Glide_timeout():
	$Logo/Glide.position += Vector2(-1,0)*40


func _on_Text_timeout():
	$G1Timer.start()

func _on_G1Timer_timeout():
	if $G1.modulate.a < 1:
		$G1.modulate.a *= 1.2
		if $G1.modulate.a >0.2 and $O2Timer.is_stopped():
			$O2Timer.start()
	if $Subtitle.modulate.a < 1:
		$Subtitle.modulate.a *= 1.1

func _on_O2Timer_timeout():
	if $O2.modulate.a < 1:
		$O2.modulate.a *= 1.2
		if $O2.modulate.a >0.1 and $D3Timer.is_stopped():
			$D3Timer.start()

func _on_D3Timer_timeout():
	if $D3.modulate.a < 1:
		$D3.modulate.a *= 1.2
		if $D3.modulate.a >0.05 and $O4Timer.is_stopped():
			$O4Timer.start()

func _on_O4Timer_timeout():
	if $O4.modulate.a < 1:
		$O4.modulate.a *= 1.2
		if $O4.modulate.a >0.025 and $T5Timer.is_stopped():
			$T5Timer.start()

func _on_T5Timer_timeout():
	if $T5.modulate.a < 1:
		$T5.modulate.a *= 1.2


func _on_MouthDelay_timeout():
	$MouthAnim.start()


func _on_MouthAnim_timeout():
	if mouth_cnt < 10:
		$mouth.rect_position.y -= 3
		mouth_cnt += 2
	else:
		mouth_cnt = 0
		$MouthAnim.stop()
		$teeth.play()
		$MouthAnim2.start()

func _on_MouthAnim2_timeout():
	if mouth_cnt > 5 and mouth_cnt < 16:
		$mouth.rect_position.y += 3
	elif mouth_cnt > 16:
		$MouthAnim2.stop()
	mouth_cnt += 2
	emit_signal("finished_anim")
