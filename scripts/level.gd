extends Node2D

signal input_change(new_input, block_id, input_id)
signal value_change(new_val, block_id)
signal expected_value_set(new_exp_val, block_id)
signal parameter_value_set(new_param_val, param_id)

enum BlockType {NONE, INPUT, PROCESS, PROCESS2, OUTPUT}

var block_quantities = {
	"input" : 0,
	"process" : 0,
	"process2" : 0,
	"output" : 0}

var parameters = []
var expected_values = []
var item_stack = []	# all the items that can be picked up, ranked by "height", so that when two objects are hovered by the mouse, only the "highest" gets picked up

var input_block_scene = preload("res://scenes/input_block.tscn")
var process_block_scene = preload("res://scenes/process_block.tscn")
var process_block_2_scene = preload("res://scenes/process_block_2.tscn")
var output_block_scene = preload("res://scenes/output_block.tscn")
var parameter_scene = preload("res://scenes/parameter.tscn")

var grabbed_value = ""

var output_count = 0
var good_answer_curr_count = 0
var block_count = 0



func _init():
	XML_doc_parse()
	print(block_quantities)
	print(parameters)
	print(expected_values)
	block_placing()
	parameter_placing()

func _ready() :
	parameter_set()

func XML_doc_parse():
	var parser = XMLParser.new()
	parser.open("res://levels/levelTest.xml")
	while parser.read() != ERR_FILE_EOF:
		if parser.get_node_type() == XMLParser.NODE_ELEMENT:
			var node_name = parser.get_node_name()
			var attributes_dict = {}
			for idx in range(parser.get_attribute_count()):
				attributes_dict[parser.get_attribute_name(idx)] = parser.get_attribute_value(idx)
			if node_name == "block":
				block_quantities[attributes_dict["type"]] = attributes_dict["quantity"].to_int()
			elif node_name == "parameter":
				parameters.append(attributes_dict["value"])
			elif node_name == "outputValue":
				expected_values.append(attributes_dict["value"].to_float())
	block_quantities["output"] = expected_values.size()
	output_count = expected_values.size()
	

func block_placing():
	var blocks = Node2D.new()
	blocks.name = "Blocks"
	add_child(blocks, true)
	
	for i in range(block_quantities["input"]):
		var block = input_block_scene.instantiate()
		blocks.add_child(block, true)
		block.set_global_position(Vector2(150, 125 + i*150))
		block.set_global_scale(Vector2(0.8,0.8))
		block.id = block_count
		item_stack.append(block)
		block_count += 1
		
	for i in range(block_quantities["process"]):
		var block = process_block_scene.instantiate()
		blocks.add_child(block, true)
		block.set_global_position(Vector2(400, 125 + i*150))
		block.set_global_scale(Vector2(0.8,0.8))
		block.id = block_count
		item_stack.append(block)
		block_count += 1
		
	for i in range(block_quantities["process2"]):
		var block = process_block_2_scene.instantiate()
		blocks.add_child(block, true)
		block.set_global_position(Vector2(650, 125 + i*150))
		block.set_global_scale(Vector2(0.8,0.8))
		block.id = block_count
		item_stack.append(block)
		block_count += 1
		
	for i in range(block_quantities["output"]):
		var block = output_block_scene.instantiate()
		blocks.add_child(block, true)
		block.set_global_position(Vector2(900, 125 + i*150))
		block.set_global_scale(Vector2(0.8,0.8))
		block.id = block_count
		block.good_answer.connect(on_output_good_answer)
		block.wrong_answer.connect(on_output_wrong_answer)
		item_stack.append(block)
		block_count += 1

func parameter_placing():
	var params = Node2D.new()
	params.name = "Parameters"
	add_child(params, true)
	
	for i in range(parameters.size()):
		var parameter = parameter_scene.instantiate()
		params.add_child(parameter, true)
		parameter.set_global_position(Vector2(150 + i*150, 550))
		parameter.id = i + block_count
		parameter.get_child(2).mouse_entered.connect(on_parameter_input_event)
		item_stack.append(parameter)

func is_highest_hovered_item(hovered_item):
	for item in item_stack:
		if item == hovered_item:
			return true
		if item.is_hovered:
			return false
	return true
	
func click_item(clicked_item):
	var index = -1
	for i in range(item_stack.size()):
		if clicked_item == item_stack[i]:
			index = i
			continue
	item_stack.pop_at(index)
	item_stack.push_front(clicked_item)
	$Parameters.move_child(clicked_item, -1)

func parameter_set():
	for i in range(parameters.size()):
		parameter_value_set.emit(parameters[i], i + block_count)

func on_output_good_answer():
	++good_answer_curr_count

func on_output_wrong_answer():
	--good_answer_curr_count

func on_parameter_input_event():
	pass
