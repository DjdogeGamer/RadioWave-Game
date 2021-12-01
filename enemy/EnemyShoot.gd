extends Area2D #Tiro do Inimigo

var speed = 1000

#movimento do laser
func _physics_process(delta):
	global_position.x -= speed * delta

#colisão do laser
func _on_PlayerLaser_area_entered(area):
	if area.is_in_group("player"):
		area.take_damage(1)
		queue_free()

