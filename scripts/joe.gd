extends CharacterBody2D

@export var speed = 30
@onready var sprite = $AnimatedSprite2D

var destination: Vector2 

func _ready() -> void:
	$"../Dog".bark_signal.connect(follow)
	destination = Vector2i(global_position)

func follow(x_pos: float):
	destination = Vector2(x_pos, global_position.y)    
	if (destination.x - global_position.x ) > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
		

func _physics_process(delta: float) -> void:
	velocity = position.direction_to(destination) * speed
	if position.distance_to(destination) > 1:
		sprite.animation = "side"
		move_and_slide()
	else:
		sprite.animation = "default"
	
