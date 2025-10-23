extends Node2D

var id = -1

static var OneInputOperation = {"POW_2" : "x²"}

var input = ""
var operation = ""
var result = ""

var is_hovered = false

func _ready() -> void:
	var root = $"/root/Level"
	root.value_change.connect(_on_value_change)
	root.input_change.connect(_on_input_change)

func _on_area_2d_operation_mouse_entered() -> void:
	is_hovered = true

func _on_area_2d_operation_mouse_exited() -> void:
	is_hovered = false

func _on_value_change (new_val, block_id):
	if id == block_id:
		if is_hovered && new_val in OneInputOperation.values():
			operation = new_val
			get_node("Area2DOperation/TextZoneOperation").set_text(operation)
			if operation == "":
				get_node("Area2DOperation/textBackgroundOperation").set_color(Color("777777"))
			else :
				get_node("Area2DOperation/textBackgroundOperation").set_color(Color("FFFFFF"))
				result_process()

func _on_input_change (new_input, block_id, input_id):
	if id == block_id && input_id == 1:
		input = new_input
		result_process()

func result_process():
	if (input != ""):
		match operation:
			OneInputOperation.POW_2:
				result = str(pow(input.to_float(), 2))
