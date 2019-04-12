extends BoxContainer
# class_name RakugoMenu - there is no need for that
# we don't want it be be seen in "add new Node" dialog,
# but to seen other Nodes that use it

export var kind : = "vertical"
export var ChoiceButton : PackedScene

func _ready():
	Rakugo.connect("exec_statement", self, "_on_statement")

func _on_statement(type, parameters):
	if type != Rakugo.StatementType.MENU:
		get_parent().hide()
		return

	if parameters["mkind"] != kind:
		get_parent().hide()
		return
		
	get_parent().show()

	for ch in get_children():
		ch.queue_free()

	var i = 0
	var choices = Rakugo.menu_node.choices_labels
	
	for ch in choices:
		var ch_button = ChoiceButton.instance()
		add_child(ch_button)
		ch_button.label.bbcode_text = "[center]" + ch + "[/center]"
		ch_button.id = i
		Rakugo.debug(["create button (", ch, ") with id : ", i])
		i += 1

	get_parent().show()

func _on_Hide_toggled(button_pressed):
	visible = !button_pressed
