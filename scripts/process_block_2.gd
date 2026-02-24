extends Node2D

var id = -1

static var TwoInputOperation = {"ADDITION" : "+",
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
	result_process()

func result_process():
	if (input1 != "" && input2 != ""):
		$TextBackgroundResult.set_color(Color("#fffbe5"))
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
		$TextBackgroundResult.set_color(Color("#303030"))
		result = ""
	$TextZoneResult.set_text(result)

func _on_value_change (new_val, block_id):
	if id == block_id:
		if is_hovered && new_val in TwoInputOperation.values():
			operation = new_val
			$Area2DValue/TextZone.set_text(operation)
			if operation == "":
				$Area2DValue/TextBackground.set_color(Color("777777"))
			else :
				$Area2DValue/TextBackground.set_color(Color("#fffbe5"))
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
