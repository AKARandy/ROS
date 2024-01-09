extends CharacterBody2D

var chase = false
const speed = 25
var player

func _physics_process(delta):
	if chase == true:
		var direction = (player.position - self.position).normalized()
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		if (player.position.x - position.x) < 0:
			pass
	
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "player":
		player = body
		print("Player!")
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "player":
		print("Player!")
		chase = false
