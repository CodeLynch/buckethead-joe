extends Area2D

@export var speed = 30 
@onready var sprite = $AnimatedSprite2D
@onready var speed_mod = $"..".SPEED_MOD

var destination: Vector2 
signal got_hit()

func _ready() -> void:
	$"../Dog".bark_signal.connect(follow)
	destination = Vector2i(global_position)

func follow(x_pos: float):
	destination = Vector2(x_pos, global_position.y)    
	if (destination.x - global_position.x ) > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
		
func _process(_delta: float) -> void:
	if speed_mod > 1:
		speed = speed * speed_mod
	 
func _physics_process(delta: float) -> void:
	if position.distance_to(destination) > 1:
		sprite.animation = "side"
		position = position.move_toward(destination, delta * speed)
	else:
		sprite.animation = "default"
		
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("obstacles"):
		got_hit.emit()
