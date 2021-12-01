extends ParallaxLayer

export var SPEED = 90

func _process(delta):
	motion_offset.x += -SPEED * delta
