#script: star_far_0
extends Sprite

export var velocity = Vector2.ZERO  # defines variable "velocity" and exposes it in inspector (for control)

func _ready():
 set_process(true)
 pass

func _process(delta):
	translate(velocity * delta)
	
	var pos = get_position().x  # define variable "pos" as current position of sprite
	var pos_start = Vector2(0,-640)  # defines variable for start point (-180px on y)
	var pos_end = get_viewport_rect().size.x  # defines variable for end point (end of viewport)
 
	if pos >= pos_end:
			set_position(pos_start)  # self explanatory
