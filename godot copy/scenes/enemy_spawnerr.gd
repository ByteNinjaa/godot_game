extends Node2D

@onready var mainn = get_node("/root/Mainn")

signal hit_p

var goblinn_scene := preload("res://scenes/goblinn.tscn")
var spawn_points := []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)


func _on_timer_timeout():
	#check how many enemies have already been created
	var Enemies = get_tree().get_nodes_in_group("Enemies")
	if Enemies.size() < get_parent().max_enemies :
		#pick random spawn point
		var spawn = spawn_points[randi() % spawn_points.size()]
		#spawn enemy
		var goblinn = goblinn_scene.instantiate()
		goblinn.position = spawn.position
		goblinn.hit_player.connect(hit)
		mainn.add_child(goblinn)
		goblinn.add_to_group("Enemies")

func hit():
	hit_p.emit()
