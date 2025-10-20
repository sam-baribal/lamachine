extends Node2D

enum BlockType {NONE, INPUT, PROCESS, PROCESS2, OUTPUT}

var id = 0
var block_type = BlockType.NONE

var OneInputOperation = {"POW_2" : "x²"}

var TwoInputOperation = {"ADDITION" : "+",
						"SUBSTRACTION" : "-",
						"MULTIPLICATION" : "×",
						"DIVISION" : "÷"}

var input1 = ""
var input2 = ""
var operation = ""
var result = ""


var value = ""
var is_hovered = false


func _ready() -> void:
	var root = $"../../"
	root.value_change.connect(_on_value_change)

func _on_area_2d_mouse_entered() -> void:
	is_hovered = true

func _on_area_2d_mouse_exited() -> void:
	is_hovered = false

func _on_value_change (new_Val):
	if is_hovered && new_Val.to_float() != 0.0:
		value = new_Val
		get_node("Area2DValue/TextZone").set_text(value)
		if value == "":
			get_node("Area2DValue/textBackground").set_color(Color("777777"))
		else :
			get_node("Area2DValue/textBackground").set_color(Color("FFFFFF"))
