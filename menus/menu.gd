extends Control




func _on_play_pressed():
	get_tree().change_scene_to_file("res://character_selection.tscn")

func _on_quit_pressed():
	get_tree().quit()
