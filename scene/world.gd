extends Node2D

#var paper = preload("res://entities/enemy/ai_paper.tscn")
#var rock = preload("res://entities/enemy/ai_rock.tscn")
#var scissor = preload("res://entities/enemy/ai_scissor.tscn")

var player = preload("res://entities/player/player.tscn")
var red_paper = preload("res://entities/enemyWithTeam/red_ai_paper.tscn")
var red_rock = preload("res://entities/enemyWithTeam/red_ai_rock.tscn")
var red_scissor = preload("res://entities/enemyWithTeam/red_ai_scissor.tscn")
var blue_paper = preload("res://entities/enemyWithTeam/blue_ai_paper.tscn")
var blue_rock = preload("res://entities/enemyWithTeam/blue_ai_rock.tscn")
var blue_scissor = preload("res://entities/enemyWithTeam/blue_ai_scissor.tscn")

const SPAWN_INTERVAL = 5.0  # Adjust this value to change the spawn interval (in seconds)

func _ready():
	spawn_enemies()
	$SpawnTimer.wait_time = SPAWN_INTERVAL
	$SpawnTimer.start()
	#print("Paper: ", Tracker.paperNum)
	#print("Rock: ", Tracker.rockNum)
	#print("Scissor: ", Tracker.scissorNum)
	#print("\n")

func _on_spawn_timer_timeout():
	spawn_enemies()
	$SpawnTimer.start()  # Restart the timer for the next spawn
	#print("Paper: ", Tracker.paperNum)
	#print("Rock: ", Tracker.rockNum)
	#print("Scissor: ", Tracker.scissorNum)
	#print("\n")

func spawn_enemies():
	if Tracker.playerDead == true:
		var mob = player.instantiate()
		mob.position = Vector2(250, 950)
		add_child(mob)
		Tracker.playerDead = false
	
	if Tracker.redPaper < 2:
		var mob = red_paper.instantiate()
		mob.position = Vector2(250, 950)
		add_child(mob)
		Tracker.redPaper += 1

	if Tracker.redRock < 2:
		var mob = red_rock.instantiate()
		mob.position = Vector2(270, 950)
		add_child(mob)
		Tracker.redRock += 1

	if Tracker.redScissor < 2:
		var mob = red_scissor.instantiate()
		mob.position = Vector2(230, 950)
		add_child(mob)
		Tracker.redScissor += 1

	if Tracker.bluePaper < 2:
		var mob = blue_paper.instantiate()
		mob.position = Vector2(1820, 600)
		add_child(mob)
		Tracker.bluePaper += 1

	if Tracker.blueRock < 2:
		var mob = blue_rock.instantiate()
		mob.position = Vector2(1840, 600)
		add_child(mob)
		Tracker.blueRock += 1

	if Tracker.blueScissor < 2:
		var mob = blue_scissor.instantiate()
		mob.position = Vector2(1800, 600)
		add_child(mob)
		Tracker.blueScissor += 1
