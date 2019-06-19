tool
extends RakugoNode2D

func _on_substate(substate):
	for ch in get_children():
		ch.hide()
		
	get_node(substate).show()
