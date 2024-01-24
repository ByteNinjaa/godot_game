extends CharacterBody2D

@onready var Player1 = get_node("/root/Mainn/Player1")

signal hit_player

var alive : bool
var entered : bool
var speed : int = 100
var direction : Vector2

func _ready():
	var screen_rect = get_viewport_rect()
	alive = true
	entered = false
	#pick direction for the entrance
	var dist = screen_rect.get_center() - position
	#check if needs to move horizontal or vertical
	if abs(dist.x) > abs(dist.y):
		#move horizontal
		direction.x = dist.x
		direction.y = 0
	else:
		#move vertically
		direction.x = 0
		direction.y = dist.y
	
func _physics_process(_delta):
	if alive :
		$AnimatedSprite2D.animation = "run"
		if entered:
			direction = (Player1.position - position)
		direction = direction.normalized()
		velocity = direction * speed
		move_and_slide()
		
		if velocity.x != 0 :
			$AnimatedSprite2D.flip_h = velocity.x < 0
	else :
		pass

func die():
	alive = false
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.animation = "dead"
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	
func _on_entrance_timerr_timeout():
	entered = true
	
func _on_area_2d_body_entered(_body):
	hit_player.emit()
