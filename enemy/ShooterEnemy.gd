extends Area2D #FastEnemy

var Laser = preload("res://projectiles/EnemyShoot.tscn")
onready var EnemyMuzzle = $EnemyMuzzle
signal spawn_enemy_laser(location)
const scn_laser = preload ("res://projectiles/EnemyShoot.tscn")
var rng = RandomNumberGenerator.new()

signal enemy_died 
var hp = 1

export (int) var enemySpeed = 500

func _physics_process(delta):
	global_position.x -= enemySpeed * delta

func _on_ship_area_entered(area):
	if area.is_in_group("player"):
		area.take_damage(1)
	
func take_damage(damage):
	hp -= damage
	if hp <=0:
		queue_free()
		emit_signal("enemy_died")

func _on_ship_spawn_laser(location):
	var l = Laser.instance()
	l.global_position = location
	add_child(l)

func _on_Enemy_area_entered(area):
	if area is Player:
		area.take_damage(1)
		
func shoot_enemy_laser():
	emit_signal("spawn_enemy_laser", EnemyMuzzle.global_position)
	
func _process(delta):
	for i in range (0,10):
		shoot_enemy_laser()

func shoot():
	while true:
		var laser = scn_laser.instance()
		laser.position = $EnemyMuzzle.global_position
		add_child(laser)
		
		yield(get_tree().create_timer(1.5), "timeout")
	pass


func _on_Timer_timeout():
	shoot ()
