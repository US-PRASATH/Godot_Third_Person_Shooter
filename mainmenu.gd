extends Node2D

@onready var lbscene = preload("res://Addons/silent_wolf/Scores/Leaderboard.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	OS.request_permissions()
	SilentWolf.configure({
		"api_key": "VwUHwYgFW01AfrFVRhWgl20czw7Cckw983SLSqSf",
		"game_id": "bulletbun",
		"log_level": 1
	})

	SilentWolf.configure_scores({
		"open_scene_on_close": "res://mainmenu.tscn"
	}) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://world_1.tscn") # Replace with function body.


func _on_quit_pressed():
	get_tree().quit() # Replace with function body.


func _on_leaderboard_pressed():
	get_tree().change_scene_to_file("res://Addons/silent_wolf/Scores/Leaderboard.tscn") # Replace with function body.
