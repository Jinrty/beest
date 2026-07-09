extends Node2D

var lines:Array[String] = [
	"You have been sleeping for...",
	"68 days 6 hours and 11 minutes",
	"WELL! Not FUCKING anymore!!!",
	"Your beloved neighbour was blasting LOUD music",
	"Go talk to him or something",
	"Quick tip: move with (WSAD) and interact with (E)"
]

func _ready() -> void:
	for i in lines:
		if(i == "WELL! Not FUCKING anymore!!!"):
			$AnimatedSprite2D.animation = "wake"
		if(i == "Quick tip: move with (WSAD) and interact with (E)"):
			var tween:Tween = get_tree().create_tween().set_parallel(true)
			tween.tween_property($AnimatedSprite2D, "scale", Vector2(1,1), 0.7)
			tween.tween_property($AnimatedSprite2D, "position:y", 364, 0.7)
			tween.tween_property($AnimatedSprite2D, "position:x", 413, 0.7)
			
		await say(i)
	
	$CanvasLayer/Label.visible = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func say(text: String, speed: float = 40):
	$CanvasLayer/Label.text = text
	
	for i in text.length() + 1:
		$CanvasLayer/Label.visible_characters = i
		await get_tree().create_timer(1 / speed).timeout
	
	await get_tree().create_timer(2.8).timeout
