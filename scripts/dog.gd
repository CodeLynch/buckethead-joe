extends CharacterBody2D

@export var speed = 50
@export var dash_bonus = 40
@onready var sprite = $AnimatedSprite2D
@onready var barkCD = $BarkCooldown

var norm_speed = speed
var isBarking = false
signal bark_signal(x_pos: float)
signal got_hit()


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if not isBarking: 
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
	sprite.animation = "bark"
	MusicManager.play_sfx("bark")
	isBarking = true
	barkCD.start();
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("AButton"):
		bark()
	if event.is_action_pressed("BButton"):
		speed = norm_speed + dash_bonus
	if event.is_action_released("BButton"):
		speed = norm_speed 

func _physics_process(_delta: float) -> void:
	get_input()
	if not isBarking:
		move_and_slide()
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		if collision.get_collider().is_in_group("obstacles"): 
			print("you hit an obstacle")
			got_hit.emit()

func _on_bark_cooldown_timeout() -> void:
	isBarking = false 
