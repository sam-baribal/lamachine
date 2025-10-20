extends Node2D

var id = 0

var type = ""
var value = ""

var is_hovered = false
var is_clicked = false

func _ready() -> void:
	var root = $"/root/Level"
	root.parameter_value_set.connect(_on_parameter_value_set)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton :
		if event.button_index == 1 :
			if event.pressed && is_hovered :
				is_clicked = true
			elif !event.pressed :
				is_clicked = false
	if event is InputEventMouseMotion && is_clicked :
		position += event.relative

func _on_parameter_value_set(new_val, param_id):
	if id == param_id:
		value = new_val
		$TextZone.set_text(value)
		if value.to_float() != 0.0:
			type = "number"
			$TextBackground.set_color(Color(0.38, 0.796, 0.42))
		else:
			type = "operation"
			$TextBackground.set_color(Color(0.243, 0.686, 1.0))

func _on_area_2d_mouse_entered() -> void:
	print("in")
	is_hovered = true

func _on_area_2d_mouse_exited() -> void:
	print("out")
	is_hovered = false
