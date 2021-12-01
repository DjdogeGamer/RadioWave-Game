extends ParallaxLayer

export var SPEED = 75

func _process(delta):
	motion_offset.x += -SPEED * delta
