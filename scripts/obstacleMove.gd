extends CharacterBody2D

@export var obstacle_resources_array: Array[Obstacle]
@onready var game_speed = $'../..'.game_speed
@onready var sprite = $AnimatedSprite2D
@onready var collision= $CollisionShape2D
@export var MIN_X_POS = 35
@export var MAX_X_POS = 114
@export var horizontal_multiplier = .5

# the minimum amount of difference between two positions to consider reaching one position as true
# regardless if said position is reached
@export var pos_diff_acceptance = 2

@export var obstacle_resource: Obstacle
var screen_size: Vector2i
var obstacle_speed: float
var moving_left = true


func _ready() -> void:
	obstacle_resource = obstacle_resources_array.pick_random()
	sprite.sprite_frames = obstacle_resource.obstacleAnim
	collision.shape = obstacle_resource.obstacle_collider
	sprite.play()
	screen_size = get_window().size
	if obstacle_resource.boosted:
		obstacle_speed = (game_speed * obstacle_resource.boost_multiplier)
	else:
		obstacle_speed = game_speed
		
func _process(_delta: float) -> void:
	if position.y > screen_size.y - 16:
		queue_free()
		
func _physics_process(_delta: float) -> void:
	if obstacle_resource.move_horizontal:
		if position.x <= MIN_X_POS:
			sprite.flip_h = true
			moving_left = false
		elif position.x >= MAX_X_POS:
			sprite.flip_h = false
			moving_left = true
		# Horizontal velocity based on direction
		var vx = (-game_speed * horizontal_multiplier) if moving_left else (game_speed * horizontal_multiplier)
		var vy = obstacle_speed
		velocity = Vector2(vx, vy)
	else:
		velocity = Vector2(0, obstacle_speed)
	move_and_slide()
