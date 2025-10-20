extends Node2D

signal good_answer
signal wrong_answer

var id = 0

var input = ""
var expected_value = ""

func _ready() -> void:
	var root = $"../../"
	root.input_change.connect(_on_input_change)
	root.expected_value_set.connect(_on_expected_value_set)

func _on_expected_value_set(new_exp_val, block_id):
	expected_value = new_exp_val
	get_node("TextZoneExpected").set_text(expected_value)
	get_node("TextBackgroundExpected").set_color(Color("FFFFFF"))

func _on_input_change (new_input, block_id, input_id):
	if id == block_id:
		get_node("Attention").set_visible(false)
		get_node("Coche").set_visible(false)
		input = new_input
		get_node("TextZoneIn").set_text = input
		if input == "":
			get_node("TextBackgroundIn").set_color(Color("777777"))
		else:
			get_node("TextBackgroundIn").set_color(Color("FFFFFF"))
		if input == "":
			if input == expected_value:
				good_answer.emit()
				get_node("Coche").set_visible(true)
				# et afficher une coche
			else:
				wrong_answer.emit()
				get_node("Attention").set_visible(true)
				# et afficher un petit panneau danger
