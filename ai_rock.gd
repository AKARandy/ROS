extends CharacterBody2D

var chase = false
const speed = 150
var player

const CENTER = Vector2(450,300)
enum {FLEEING, ROAMING}
var state = ROAMING
var body_to_flee_from : CharacterBody2D
var random_target_pos : Vector2 = Vector2(450,300)

func _physics_process(delta):
	if chase == true:
		var direction = (player.position - self.position).normalized()
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		#if (player.position.x - position.x) < 0:
			#pass
	if chase == false:
		match state:
			FLEEING:
				position -= position.direction_to(body_to_flee_from.position) * speed * delta
			ROAMING:
				if position.distance_to(random_target_pos) <= speed * delta:
					random_target_pos = CENTER + Vector2(0,300).rotated(randf() * 2 * PI)
				else:
					position += position.direction_to(random_target_pos) * speed * delta
	
	move_and_slide()

func _on_player_detection_body_entered(body):
	print("chase: " + str(chase))
	print("state: " + str(state))
	if body.name == "player":
		if Global.role == "scissor":
			player = body
			chase = true
		if Global.role == "paper":
			chase = false
			state = FLEEING
			body_to_flee_from = body
			print("run")

func _on_player_detection_body_exited(body):
	print("chase: " + str(chase))
	print("state: " + str(state))
	if body.name == "player":
		if Global.role == "scissor":
			chase = false
		if Global.role == "paper":
			state = ROAMING
			random_target_pos = position 
