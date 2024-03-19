extends Node2D

var paper = preload("res://entities/enemy/ai_paper.tscn")
var rock = preload("res://entities/enemy/ai_rock.tscn")
var scissor = preload("res://entities/enemy/ai_scissor.tscn")


# Called when the node enters the scene tree for the first time.
func _process(delta):
	while Tracker.paperNum < 5:
		#await get_tree().create_timer(3.0)
		var mob = paper.instantiate()
		mob.position = Vector2(575, 300)
		add_child(mob)
		Tracker.paperNum += 1
	while Tracker.rockNum < 5:
		#await get_tree().create_timer(3.0)
		var mob = rock.instantiate()
		mob.position = Vector2(1000, 500)
		add_child(mob)
		Tracker.rockNum += 1
	while Tracker.scissorNum < 5:
		#await get_tree().create_timer(3.0)
		var mob = scissor.instantiate()
		mob.position = Vector2(250, 500)
		add_child(mob)
		Tracker.scissorNum += 1
	print("Paper: ", Tracker.paperNum)
	print("Rock: ", Tracker.rockNum)
	print("Scissor: ", Tracker.scissorNum)
