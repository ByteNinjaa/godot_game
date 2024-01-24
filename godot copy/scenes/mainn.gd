extends Node

var wave : int
var difficulty : float
const DIFF_MULTIPLIER : float = 1.2
var max_enemies : int
var lives : int

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	$GameOVERR/RestartButtonn.pressed.connect(new_game)
	
func new_game():
	wave = 1
	lives = 1
	difficulty = 10.0
	max_enemies = 10
	$EnemySpawnerr/Timer.wait_time = 1.0
	reset()
	
func reset():
	max_enemies = int(difficulty)
	$Player1.reset()
	get_tree().call_group("Enemies", "queue_free")
	get_tree().call_group("bullets", "queue_free")
	$HUD/LivesLabell.text = "X " + str(lives)
	$HUD/WaveLabell.text = "WAVE: " + str(wave)
	$HUD/EnemiesLabell.text = "X " + str(max_enemies)
	$GameOVERR.hide()
	get_tree().paused = true
	$RestartTimerr.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_wave_completed():
		wave += 1
		#adjust difficulty
		difficulty *= DIFF_MULTIPLIER
		if $EnemySpawnerr/Timer.wait_time > 0.25: 
			$EnemySpawnerr/Timer.wait_time -= 0.05
		get_tree().paused = true
		$waveoverTimerr.start()


func _on_enemy_spawnerr_hit_p():
	lives -= 1
	$HUD/LivesLabell.text = "X " + str(lives)
	get_tree().paused = true
	if lives <= 0 :
		$GameOVERR/WavesSurvivedLabell.text = "WAVES SURVIVED: " + str(wave - 1)
		$GameOVERR.show()
	else :
		$waveoverTimerr.start()

func _on_waveover_timerr_timeout():
	reset()
	
func _on_restart_timerr_timeout():
	get_tree().paused = false

func is_wave_completed():
	var all_dead = true
	var enemies = get_tree().get_nodes_in_group("Enemies")
	#check if all enemies have spawned first
	if enemies.size() == max_enemies :
		for e in enemies :
			if e.alive :
				all_dead = false
			return all_dead
	else:
		return false

