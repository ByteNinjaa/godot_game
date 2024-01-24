extends CharacterBody2D

signal shoot

var alive : bool

var speed : int
var can_shoot : bool
var screen_size : Vector2

func _ready():
	screen_size = get_viewport_rect().size
	reset()
	
func reset():
	alive = true
	position = screen_size / 2
	speed = 200
	can_shoot = true
	

func get_input():
	#keyboard input
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * speed
	
	#mouse clicks
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot :
		var dir = get_global_mouse_position() - position
		shoot.emit(position, dir)
		can_shoot = false
		$ShotTimerr.start()
		

func _physics_process(_delta):
	if alive :
		#player movement
		get_input()
		move_and_slide()
	
		#limit movement to window size
		position = position.clamp(Vector2.ZERO, screen_size)
	
		#player rotation
		var mouse = get_local_mouse_position()
		var angle = snappedf(mouse.angle(), PI / 4) / (PI / 4)
		angle = wrapi(int(angle), 0, 8)
	
		$AnimatedSprite2D.animation = "walk" + str(angle)
	
		#player animation
		if velocity.length() != 0:
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.frame = 1
	else:
		pass
func death():
	alive = false
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.animation = "dead"
	$CollisionShape2D.set_deferred("disabled", true)
	
func _on_shot_timerr_timeout():
	can_shoot = true
