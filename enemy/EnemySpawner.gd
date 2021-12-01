extends Node2D

signal add_score

var boss = null
var is_boss_spawned = false
var is_boss_dead = false
var spawn_positions = null

#Tipos de inimigos (pode adicionar mais)
var Boss1 = preload("res://stages/boss_01.tscn")
var Boss2 = preload("res://stages/boss_02.tscn")
var Boss3 = preload("res://stages/boss_03.tscn")

var CommonEnemy = preload("res://enemy/CommonEnemy.tscn")
var FastEnemy = preload("res://enemy/FastEnemy.tscn")
var ShooterEnemy = preload("res://enemy/ShooterEnemy.tscn")
	
var enemies = [
	CommonEnemy,
	FastEnemy,
	ShooterEnemy,
]

var bosses = [
	Boss1,
	Boss2,
	Boss3
]
	
func _spawn_boss(bossIndex):
	boss = bosses[bossIndex].instance()
	boss.global_position = spawn_positions[2].global_position 
	boss.global_position += Vector2(300,135)
	add_child(boss)
	return(boss)

func _ready():
	randomize()
	spawn_positions = $SpawnPositions.get_children()

func spawn_enemy():
	var enemyIndex = randi() % enemies.size()
	var enemyType = enemies[enemyIndex]
	var index = randi() % spawn_positions.size()
	var enemy = enemyType.instance()
	enemy.global_position = spawn_positions[index].global_position
	enemy.connect("enemy_died", self, "enemy_died")
	add_child(enemy)

func _on_SpawnTimer_timeout():
	if not is_boss_spawned:
		$enemySound.play()
		spawn_enemy()
		

func enemy_died():
	$enemyDying.play()
	emit_signal("add_score")
