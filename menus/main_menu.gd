extends Control

@onready var credits = $CanvasLayer/credits


func _on_play_pressed():
	get_tree().change_scene_to_file("res://menus/character_selection.tscn")


func _on_exit_pressed():
	get_tree().quit()



func _on_options_pressed():
	credits.show()
