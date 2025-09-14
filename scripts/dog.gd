extends CharacterBody2D

@export var speed = 50
@onready var sprite = $AnimatedSprite2D

signal bark_signal(x_pos: float)


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction.x != 0:
		if input_direction.x > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		sprite.animation = "side"
	elif input_direction.y > 0:
		sprite.animation = "front"
	elif input_direction.y < 0:
		sprite.animation = "back"
	else:
		sprite.animation = "front"
	velocity = input_direction * speed

func bark():
	bark_signal.emit(global_position.x);

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("AButton"):
		bark()

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
