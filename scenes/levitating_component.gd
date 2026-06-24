@tool
extends Node2D

func on_signal():
	var parent = get_parent()
	var tween:Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CIRC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(parent, "position:y", parent.position.y + 5, 0.4)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(parent, "position:y", parent.position.y, 0.6)
