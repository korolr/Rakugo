extends Node2D

## this script make sure that only one bg is displayed at time

func hide_others(node):
	if node.visible:
		for ch in get_children():
			if ch != node:
				ch.hide()

func _on_bg_lecturehall_visibility_changed():
	hide_others($"bg lecturehall")

func _on_bg_club_visibility_changed():
	hide_others($"bg club")

func _on_bg_meadow_visibility_changed():
	hide_others($"bg meadow")

func _on_bg_uni_visibility_changed():
	hide_others($"bg uni")
