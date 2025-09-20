extends Node2D

@onready var press_start = $PressStart
var accept_input = false

func _ready() -> void:
	press_start.visible = false
	press_start.process_mode = Node.PROCESS_MODE_DISABLED
	MusicManager.play_bgm("title")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("start") and accept_input:
		get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_buffer_timeout() -> void:
	press_start.process_mode = Node.PROCESS_MODE_ALWAYS
	accept_input = true
