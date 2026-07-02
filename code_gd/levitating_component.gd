@tool
extends Node2D

var top_pos_y:int

func _ready() -> void:
	top_pos_y = get_parent().position.y

func on_signal():
	var parent = get_parent()
	var tween:Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CIRC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(parent, "position:y", parent.position.y + 5, 0.4)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(parent, "position:y", top_pos_y, 0.6)
