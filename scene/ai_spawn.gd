extends Node2D

var player = preload("res://entities/player/player.tscn")
var ai_papper = preload("res://entities/enemy/ai_paper.tscn")
var ai_rock = preload("res://entities/enemy/ai_rock.tscn")
var ai_scissor = preload("res://entities/enemy/ai_scissor.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(get_parent() is Node2D, "ai_spawn harus menjadi anak dari Node2D")
	
	var friendly_ai = Node2D.new()
	var hostile_ai = Node2D.new()
	var killable_ai = Node2D.new()
	var player = Node2D.new()

	get_parent().add_child(friendly_ai)
	get_parent().add_child(hostile_ai)
	get_parent().add_child(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize_spawn():
	var spawn_points = []
	var point = [Vector2(140,90),Vector2(1005,90),Vector2(1005,580),Vector2(140, 580)]
	var remaining_points = point.copy()
	
	for i in range(3):
		var random_index = randi_range(0, remaining_points.size() - 1)
		var random_point = remaining_points[random_index]
		spawn_points.append(random_point)
		remaining_points.remove(random_index)
		
	
