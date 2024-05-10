extends Control


func resume():
	get_tree().paused = false
	hide()

func pause():
	get_tree().paused = true
	show()

func _on_home_pressed():
	resume()
	Tracker.reset_data()
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
	

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	resume()
	Tracker.reset_data()
	get_tree().reload_current_scene()

func _process(delta):
	if Input.is_action_just_pressed("pause") && !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") && get_tree().paused:
		resume()
