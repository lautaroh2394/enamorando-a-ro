extends Control

var level_scene: PackedScene = load("res://scenes/level.tscn")

func _ready() -> void:
	$CenterContainer/VBoxContainer/Label2.text = "\nPuntaje: " + str(Global.score)
	$CenterContainer/VBoxContainer/Label2.text += "\nLauti arrojó " + str(Global.total_shot) + " corazones\nAcertó " + str(Global.total_hit) + "\n"
	if Global.total_hit >= 30:
		$CenterContainer/VBoxContainer/Label3.visible = true
		$AudioStreamPlayer.play()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		Global.total_hit = 0
		Global.total_shot = 0
		get_tree().change_scene_to_packed(level_scene)


func _on_texture_button_pressed() -> void:
	var shoot_event = InputEventAction.new()
	shoot_event.action = "shoot"
	shoot_event.pressed = true
	Input.parse_input_event(shoot_event)
