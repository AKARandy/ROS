extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rock_select_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.ROCK
	Tracker.blueRock += 1
	EntityRoles.team = EntityRoles.Team.Blue

func _on_paper_select_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.PAPER
	Tracker.bluePaper += 1
	EntityRoles.team = EntityRoles.Team.Blue
	
func _on_scissor_select_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.SCISSOR
	Tracker.blueScissor += 1
	EntityRoles.team = EntityRoles.Team.Blue


func _on_rock_select_2_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.ROCK
	Tracker.redRock += 1
	EntityRoles.team = EntityRoles.Team.Red

func _on_paper_select_2_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.PAPER
	Tracker.redPaper+= 1
	EntityRoles.team = EntityRoles.Team.Red

func _on_scissor_select_2_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")
	EntityRoles.role = EntityRoles.Roles.SCISSOR
	Tracker.redScissor += 1
	EntityRoles.team = EntityRoles.Team.Red
