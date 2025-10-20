extends Node2D

var id = 0

var TwoInputOperation = {"ADDITION" : "+",
						"SUBSTRACTION" : "-",
						"MULTIPLICATION" : "×",
						"DIVISION" : "÷"}

var input1 = ""
var input2 = ""
var operation = ""
var result = ""

var is_hovered = false
var input1_is_hovered = false
var input2_is_hovered = false

func _ready() -> void:
	var root = $"/root/Level"
	root.value_change.connect(_on_value_change)
	root.input_change.connect(_on_input_change)

func result_process():
	if (input1 != "" && input2 != ""):
		match operation:
			TwoInputOperation.ADDITION:
				result = str(input1.to_float() + input2.to_float())
			TwoInputOperation.SUBSTRACTION:
				result = str(input1.to_float() - input2.to_float())
			TwoInputOperation.MULTIPLICATION:
				result = str(input1.to_float() * input2.to_float())
			TwoInputOperation.DIVISION:
				result = str(input1.to_float() / input2.to_float())
	else :
		result = ""
	get_node("TextZoneResult").set_text(result)

func _on_value_change (new_val, block_id):
	if id == block_id:
		if is_hovered && new_val in TwoInputOperation.values():
			operation = new_val
			get_node("Area2DOperation/TextZoneOperation").set_text(operation)
			if operation == "":
				get_node("Area2DOperation/textBackgroundOperation").set_color(Color("777777"))
			else :
				get_node("Area2DOperation/textBackgroundOperation").set_color(Color("FFFFFF"))
				result_process()

func _on_input_change (new_input, block_id, input_id):
	if id == block_id :
		if input_id == 1 :
			input1 = new_input
		elif input_id == 2:
			input2 = new_input
		result_process()

func _on_area_2d_operation_mouse_entered() -> void:
	is_hovered = true

func _on_area_2d_operation_mouse_exited() -> void:
	is_hovered = false

func _on_area_2d_input_1_mouse_entered() -> void:
	input1_is_hovered = true

func _on_area_2d_input_1_mouse_exited() -> void:
	input1_is_hovered = false

func _on_area_2d_input_2_mouse_entered() -> void:
	input2_is_hovered = true

func _on_area_2d_input_2_mouse_exited() -> void:
	input2_is_hovered = false
