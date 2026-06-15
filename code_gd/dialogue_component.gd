extends Node2D
class_name DialogueComponent

@export var lines:Array[DialogueLine] = []

var current_path:int 
var player:Node2D
var path_chosen:bool = false
var lines_array:Array = []

func on_interact() -> void:
	player = get_parent().player
	lines_array = []
	for x in lines:
		if(path_chosen == false):
			if((x.requirement == "") or (x.requirement == player.item_name())):
				current_path = x.path
				path_chosen = true
		if(current_path == x.path) and path_chosen:
			lines_array.append(x.line)
	path_chosen = false
	print(lines_array)
	for i in lines_array:
		await say(i)

func shut_up():
	$Sprite2D.visible = false
	$Text.visible = false

func say(text: String, speed: float = 40):
	$Sprite2D.visible = true
	$Text.visible = true
	$Text.text = text
	
	if(text.length() < 12):
		$Text.add_theme_font_size_override("font_size", 20)
	else:
		$Text.add_theme_font_size_override("font_size", 12)
	
	for i in text.length() + 1:
		$Text.visible_characters = i
		await get_tree().create_timer(1 / speed).timeout
		
	await get_tree().create_timer(2).timeout
	shut_up()
