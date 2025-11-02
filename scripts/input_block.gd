extends Node2D

var id = -1

var value = ""
var is_hovered = false

func _ready() -> void:
	var root = $"/root/Level"
	root.value_change.connect(_on_value_change)

func _on_area_2d_mouse_entered() -> void:
	is_hovered = true

func _on_area_2d_mouse_exited() -> void:
	is_hovered = false

func _on_value_change (new_val, block_id):
	if id == block_id:
		if is_hovered && new_val.to_float() != 0.0:
			value = new_val
			$Area2DValue/TextZone.set_text(value)
			if value == "":
				$Area2DValue/TextBackground.set_color(Color("777777"))
			else :
				$Area2DValue/TextBackground.set_color(Color("#fffbe5"))
