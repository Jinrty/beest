extends Node2D

@export var item:Node2D
var player:Node2D

func on_interact() -> void:
	player = get_parent().player
	if(player.has_item(item.title) == false):
		player.say(get_parent().answer)
		await get_tree().create_timer(2).timeout
		player.add_item(item)
	else:
		player.say(get_parent().already_has_line)
