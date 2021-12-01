#script: ship
extends Area2D
class_name Player

signal spawn_laser(location)
signal player_died
signal player_has_take_dama

var player_has_died = false
var hp = 3
var canShoot = true
onready var playerShootSound = $playerShoot
onready var muzzle = $Muzzle
export var shootDelay = 0.2
export var MOUSE_SPEED = 0.2

#Começo
func _ready():
	set_process(true)
	pass 

#Movimento e ações
func ready_to_shoot():
	canShoot = true

#update
func _process(_delta):
	position.y = lerp(position.y, get_global_mouse_position().y, MOUSE_SPEED)
	position.x = lerp(position.x, get_global_mouse_position().x, MOUSE_SPEED)
	
	if Input.is_action_pressed("shoot"):
		if canShoot == true:
			shoot_laser()
			canShoot = false

#Receber Dano
func take_damage(damage):
	hp -= damage
	emit_signal("player_has_take_dama")
	if hp <=0:
		queue_free()
		player_has_died = true
		emit_signal("player_died")

#Detector de colisão
func _on_ship_area_entered(area):
	if area.is_in_group("enemies"):
		area.take_damage(1)
		
#Atirar 
func shoot_laser():
	emit_signal("spawn_laser", muzzle.global_position)
	playerShootSound.play()
	$ShootTimer.set_wait_time(shootDelay)
	$ShootTimer.start()
	play_attackAnimation()	

#Animações
onready var waveAnim = $AnimationPlayer

func play_attackAnimation():
	waveAnim.play("Attack");
