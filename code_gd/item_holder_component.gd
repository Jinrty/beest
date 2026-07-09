extends Node2D

@export var item:Node2D
var player:Node2D
var used:bool = false

func on_interact() -> void:
	player = get_parent().player
	
	if(used):
		player.say(get_parent().already_has_line)
	elif(player.has_item(item.title) == false):
		player.say(get_parent().answer)
		await get_tree().create_timer(2).timeout
		player.add_item(item)
		used = true
	else:
		player.say(get_parent().already_has_line)
