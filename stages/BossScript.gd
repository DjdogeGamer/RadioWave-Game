extends Area2D

signal enemy_died 
signal boss_died
var hp = 25
var is_dead = false

export (int) var enemySpeed = 300

func _physics_process(delta):
	var time = OS.get_ticks_msec()
	var newPos =  cos(time * 0.003) * 90
	global_position.y = newPos+170

func take_damage(damage):
	$Sprite.modulate = Color("FF0000")
	$hitSpriteTimer.set_wait_time(0.15)
	$hitSpriteTimer.start()
	hp -= damage
	if hp <=0:
		emit_signal("boss_died")
		is_dead = true

func _on_Enemy_area_entered(area):
	if area is Player:
		area.take_damage(1)

func _on_hitSpriteTimer_timeout():
	$Sprite.modulate = Color("FFFFFF")
