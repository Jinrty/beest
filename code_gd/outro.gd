extends Node2D

signal fallen
signal loud
signal anger

func start() -> void:
	$Outro.visible = true
	$Outro.animation = "fall"
	$Outro.play()
	fallen.emit()
	var tween:Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($ColorRect, "position:y", $ColorRect.position.y + 120, 2)
	tween.parallel().tween_property($ColorRect2, "position:y", $ColorRect2.position.y - 110, 2)


func _on_camera_2d_ending() -> void:
	start()


func say(text: String, speed: float = 50, wait:float = 3) -> void:
	$LoudBuble.visible = true
	$Text.visible = true
	$Text.text = text

	$Text.add_theme_font_size_override("font_size", 17)
	
	for i in text.length() + 1:
		$Text.visible_characters = i
		await get_tree().create_timer(1 / speed).timeout
		

func _on_outro_animation_finished() -> void:
	$Outro.animation = "sleep"
	$Outro.play()
	await get_tree().create_timer(3).timeout
	$Text.visible = true
	$LoudBuble.visible = true
	loud.emit()
	$Outro.animation = "wake"
	say("Congratulations on beating the game!")
	await get_tree().create_timer(1).timeout
	anger.emit()
	await get_tree().create_timer(1.5).timeout
	$Text.visible = false
	$LoudBuble.visible = false
	await get_tree().create_timer(1).timeout
	$Outro.animation = "sleep"
