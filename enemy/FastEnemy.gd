extends Area2D

signal enemy_died 
var hp = 1

export (int) var enemySpeed = 600

func _physics_process(delta):
	global_position.x -= enemySpeed * delta

func take_damage(damage):
	hp -= damage
	if hp <=0:
		queue_free()
		emit_signal("enemy_died")

func _on_Enemy_area_entered(area):
	if area is Player:
		area.take_damage(1)
