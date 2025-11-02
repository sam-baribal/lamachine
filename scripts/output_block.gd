extends Node2D

signal good_answer
signal wrong_answer

var id = -1

var input = ""
var expected_value = ""

var is_hovered = false

func _ready() -> void:
	var root = $"../../"
	root.input_change.connect(_on_input_change)
	root.expected_value_set.connect(_on_expected_value_set)

func _on_expected_value_set(new_exp_val, block_id):
	if id == block_id:
		expected_value = new_exp_val
		$TextZoneExpected.set_text(expected_value)
		$TextBackgroundExpected.set_color(Color("FFFFFF"))

func _on_input_change (new_input, block_id, input_id):
	if id == block_id:
		$Attention.set_visible(false)
		$Coche.set_visible(false)
		input = new_input
		$TextZoneIn.set_text = input
		if input == "":
			$TextBackgroundIn.set_color(Color("777777"))
		else:
			$TextBackgroundIn.set_color(Color("#fffbe5"))
		if input == "":
			if input == expected_value:
				good_answer.emit()
				$Coche.set_visible(true)
				# et afficher une coche
			else:
				wrong_answer.emit()
				$Attention.set_visible(true)
				# et afficher un petit panneau danger
