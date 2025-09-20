extends Control

@onready var score_text: RichTextLabel = $ScoreValue

func _ready() -> void:
	get_tree().paused = false
	score_text.text = str(ScoreManager.getScore())

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("start"):
		get_tree().change_scene_to_file("res://scenes/title_screen.tscn")


func _on_delay_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
