extends Node2D

@export var lines:Array[String] = []

func on_interact() -> void:
	var rand_line_index:int = randi_range(0, lines.size() - 1)
	say(lines[rand_line_index])


func say(text: String, speed: float = 45):
	$Sprite2D.visible = true
	$Text.visible = true
	$Text.text = text
	$Timer.stop()
	
	if(text.length() < 12):
		$Text.add_theme_font_size_override("font_size", 20)
	else:
		$Text.add_theme_font_size_override("font_size", 12)
	
	for i in text.length() + 1:
		$Text.visible_characters = i
		await get_tree().create_timer(1 / speed).timeout
		
	$Timer.start()
	
func shut_up():
	$Sprite2D.visible = false
	$Text.visible = false


func _on_timer_timeout() -> void:
	shut_up()
