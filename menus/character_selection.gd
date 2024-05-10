extends Control

func _on_rock_select_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.ROCK
	EntityRoles.team = EntityRoles.Team.Blue

func _on_paper_select_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.PAPER
	EntityRoles.team = EntityRoles.Team.Blue
	
func _on_scissor_select_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.SCISSOR
	EntityRoles.team = EntityRoles.Team.Blue


func _on_rock_select_2_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.ROCK
	EntityRoles.team = EntityRoles.Team.Red

func _on_paper_select_2_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.PAPER
	EntityRoles.team = EntityRoles.Team.Red

func _on_scissor_select_2_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.SCISSOR
	EntityRoles.team = EntityRoles.Team.Red
