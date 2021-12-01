extends Node2D

export (int) var stageIndex 
var Laser = preload("res://projectiles/PlayerLaser.tscn")
export var score = 50
export var lifes = 3
export (PackedScene) var nextScene 


func _ready():
	$score.text = "Enemies Remaing: "+str(score)
	$lifes.text = "Lifes:"+str(lifes)

func _process(delta):
	
	if score <=0 and not $EnemySpawner.is_boss_spawned:
		$EnemySpawner.is_boss_spawned = true
		var boss = $EnemySpawner._spawn_boss(stageIndex)
		boss.connect("boss_died", self, "end_game")
			
func end_game():
	#botar funções de audio, animação, efeitos e particulas aqui!
	get_tree().change_scene_to(nextScene)

func _on_ship_spawn_laser(location):
	var l = Laser.instance()
	l.global_position = location
	add_child(l)

func score():
	score -=1
	$score.text = "Enemies Remaing: "+str(score)
	

func _on_ship_player_has_take_dama():
	lifes -=1
	$lifes.text = "Lifes:"+str(lifes)

