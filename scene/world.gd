extends Node2D

var paper = preload("res://entities/enemy/ai_paper.tscn")
var rock = preload("res://entities/enemy/ai_rock.tscn")
var scissor = preload("res://entities/enemy/ai_scissor.tscn")

const SPAWN_INTERVAL = 5.0  # Adjust this value to change the spawn interval (in seconds)

func _ready():
	spawn_enemies()
	$SpawnTimer.wait_time = SPAWN_INTERVAL
	$SpawnTimer.start()
	print("Paper: ", Tracker.paperNum)
	print("Rock: ", Tracker.rockNum)
	print("Scissor: ", Tracker.scissorNum)
	print("\n")

func _on_spawn_timer_timeout():
	spawn_enemies()
	$SpawnTimer.start()  # Restart the timer for the next spawn
	print("Paper: ", Tracker.paperNum)
	print("Rock: ", Tracker.rockNum)
	print("Scissor: ", Tracker.scissorNum)
	print("\n")

func spawn_enemies():
	if Tracker.paperNum < 5:
		var mob = paper.instantiate()
		mob.position = Vector2(575, 300)
		add_child(mob)
		Tracker.paperNum += 1

	if Tracker.rockNum < 5:
		var mob = rock.instantiate()
		mob.position = Vector2(1000, 500)
		add_child(mob)
		Tracker.rockNum += 1

	if Tracker.scissorNum < 5:
		var mob = scissor.instantiate()
		mob.position = Vector2(250, 500)
		add_child(mob)
		Tracker.scissorNum += 1

