extends Node2D

var sleep_loop:int = 0

signal finished_intro_animation
signal remove
signal loud

func _ready() -> void:
	$Intro.animation = "sleep"
	$Intro.play()


		

func say(text: String, speed: float = 50, wait:float = 2) -> void:
	$LoudBuble.visible = true
	$Text.visible = true
	$Text.text = text

	$Text.add_theme_font_size_override("font_size", 17)
	
	for i in text.length() + 1:
		$Text.visible_characters = i
		await get_tree().create_timer(1 / speed).timeout


func _on_intro_animation_finished() -> void:
	if($Intro.animation == "wake"):
		$Intro.visible = false
		remove.emit()
		return
	sleep_loop += 1
	if sleep_loop <= 3:
		$Intro.animation = "sleep"
		$Intro.play()
	else:
		say("Interact with E...")
		loud.emit()
		$Intro.animation = "wake"
		$Intro.play()
		await get_tree().create_timer(2.5).timeout #2.5
		$Text.visible = false
		$LoudBuble.visible = false
		await get_tree().create_timer(1).timeout #2
		say("Oh fuck! what's happening??!")
		await get_tree().create_timer(2).timeout #2
		finished_intro_animation.emit()
		
		var tween:Tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_CIRC)
		tween.tween_property($ColorRect, "position:y", $ColorRect.position.y - 80, 2)
		tween.parallel().tween_property($ColorRect2, "position:y", $ColorRect2.position.y + 80, 2)
		await tween.finished
		queue_free()
		
		
