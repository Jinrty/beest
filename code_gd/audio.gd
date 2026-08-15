extends Node


func new_item() -> void:
	$"New item".play()

func music() -> void:
	$Music.play()

func music_fade_in() -> void:
	$Music.bus = "Master"

func music_fade_out() -> void:
	$Music.bus = "Muffled"

func door() -> void:
	$Door.play()
	
func fall() -> void:
	var rand_pithc:int = randi_range(0.4, 0.7)
	$Fall.pitch_scale = rand_pithc
	$Fall.play()

func switch() -> void:
	$Switch.play()
	
func sofa() -> void:
	$Sofa.play()

func cushion() -> void:
	$Cushion.play()
