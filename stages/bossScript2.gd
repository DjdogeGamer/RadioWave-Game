extends Area2D #Boss Script 2!

signal enemy_died 
signal boss_died
var hp = 35
var is_dead = false

export (int) var enemySpeed = 300

func _physics_process(delta):
	var time = OS.get_ticks_msec()
	var newPos = tan(time * 0.002) * 90
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
