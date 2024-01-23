extends CharacterBody2D


var SPEED = 300
var current_dir = "none"

# Get the gravity from the project settings to be synced with RigidBody nodes.

func _physics_process(delta):
	player_movements(delta)

func player_movements(delta):
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		player_anim(1)
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		player_anim(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		player_anim(1)
		velocity.x = 0
		velocity.y = -SPEED
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		player_anim(1)
		velocity.x = 0
		velocity.y = SPEED
	else:
		player_anim(0)
		velocity.x = 0
		velocity.y = 0
	move_and_slide()

func player_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right": 
		anim.flip_h = false
		if movement == 1:
			anim.play("Side_walk")
		elif movement == 0:
			anim.play("Idle")
	if dir == "left": 
		anim.flip_h = true
		if movement == 1:
			anim.play("Side_walk")
		elif movement == 0:
			anim.play("Idle")
			
	if dir == "up": 
		anim.flip_h = false
		if movement == 1:
			anim.play("Side_walk")
		elif movement == 0:
			anim.play("Idle")
	if dir == "down": 
		anim.flip_h = true
		if movement == 1:
			anim.play("Side_walk")
		elif movement == 0:
			anim.play("Idle")
