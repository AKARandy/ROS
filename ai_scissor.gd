extends CharacterBody2D

var chase = false
const speed = 150
var player

func _physics_process(delta):
	if chase == true:
		var direction = (player.position - self.position).normalized()
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		#if (player.position.x - position.x) < 0:
			#pass
	
	move_and_slide()

func _on_player_detection_body_entered(body):
	if Global.role == "paper":
		if body.name == "player":
			player = body
			chase = true


func _on_player_detection_body_exited(body):
	if Global.role == "paper":
		if body.name == "player":
			chase = false
