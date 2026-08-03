extends Node2D

signal fallen

func start() -> void:
	$Outro.visible = true
	$Outro.animation = "fall"
	$Outro.play()
	fallen.emit()
	var tween:Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CIRC)
	tween.tween_property($ColorRect, "position:y", $ColorRect.position.y + 120, 2)
	tween.parallel().tween_property($ColorRect2, "position:y", $ColorRect2.position.y - 110, 2)


func _on_camera_2d_ending() -> void:
	start()


func _on_outro_animation_finished() -> void:
	$Outro.animation = "sleep"
	$Outro.play()
