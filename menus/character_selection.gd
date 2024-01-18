extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rock_select_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.ROCK
	Tracker.rockNum += 1

func _on_paper_select_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.PAPER
	Tracker.paperNum += 1
	
func _on_scissor_select_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.SCISSOR
	Tracker.scissorNum += 1
