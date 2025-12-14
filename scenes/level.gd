extends Node2D

var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")
var meteor_scenes: Array = [
	load("res://scenes/meteor_ro/ro_1.tscn"),
	load("res://scenes/meteor_ro/ro_2.tscn"),
	load("res://scenes/meteor_ro/ro_3.tscn"),
	load("res://scenes/meteor_ro/ro_4.tscn"),
	load("res://scenes/meteor_ro/ro_5.tscn"),
	load("res://scenes/meteor_ro/ro_6.tscn"),
	load("res://scenes/meteor_ro/ro_7.tscn"),
	load("res://scenes/meteor_ro/ro_8.tscn"),
	load("res://scenes/meteor_ro/ro_9.tscn"),
	load("res://scenes/meteor_ro/ro_10.tscn"),
	load("res://scenes/meteor_ro/ro_11.tscn"),
	load("res://scenes/meteor_ro/ro_12.tscn"),
	load("res://scenes/meteor_ro/ro_13.tscn"),
	load("res://scenes/meteor_ro/ro_14.tscn"),
	load("res://scenes/meteor_ro/ro_15.tscn"),
	load("res://scenes/meteor_ro/ro_16.tscn"),
]
var health := 3
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	get_tree().call_group('ui', 'set_health', health)
	var screen_width = get_viewport().get_visible_rect().size[0]
	var screen_height = get_viewport().get_visible_rect().size[1]
	$Player.position = Vector2(screen_width/2, screen_height*0.85)

func _on_meteor_timer_timeout() -> void:
	#var meteor = meteor_scene.instantiate()
	var meteor = meteor_scenes[rng.randi_range(0, len(meteor_scenes)-1)].instantiate()
	meteor.connect('collision', _on_meteor_collision)
	$Meteors.add_child(meteor)

func _on_meteor_collision():
	health -= 1
	get_tree().call_group('ui', 'set_health', health)
	if health <= 0:
		call_deferred("game_over")
		return
	$Player.play_collision_sound()

func _on_player_laser(player_position) -> void:
	var laser = laser_scene.instantiate()
	laser.position = player_position
	$Lasers.add_child(laser)

func game_over():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
