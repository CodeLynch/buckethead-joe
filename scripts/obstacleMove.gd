extends CharacterBody2D

@onready var game_speed = $'../..'.game_speed
var screen_size: Vector2i

func _ready() -> void:
	screen_size = get_window().size

func _process(delta: float) -> void:
	if position.y > screen_size.y:
		queue_free()
		
func _physics_process(delta: float) -> void:
	velocity = position.direction_to(Vector2i(global_position.x, 150)) * game_speed
	move_and_slide()
