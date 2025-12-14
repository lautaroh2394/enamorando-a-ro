extends CanvasLayer
static var lauti = load("res://graphics/rocio/sloth.png")
var time_elapsed = 0

func _ready() -> void:
	$MarginContainer2/HBoxContainer.size = Vector2(100, 100)

func set_health(amount):
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
	
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = lauti
		#text_rect.stretch_mode = TextureRect.STRETCH_KEEP
		#text_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		text_rect.custom_minimum_size = Vector2(140, 140)
		
		#text_rect.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		#text_rect.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		$MarginContainer2/HBoxContainer.add_child(text_rect)


func _on_score_timer_timeout() -> void:
	time_elapsed += 1
	$MarginContainer/Label.text = str(time_elapsed)
	Global.score = time_elapsed


func _on_right_button_down() -> void:
	Input.action_press("right")


func _on_left_button_down() -> void:
	Input.action_press("left")

func _on_left_button_up() -> void:
	Input.action_release("left")
	
func _on_right_button_up() -> void:
	Input.action_release("right")
