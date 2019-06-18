extends GDScriptDialog

func start(node_name, dialog_name):
	var cd = check_dialog(node_name, dialog_name, "start")

	if not cd:
		return

	match get_story_state():
		0:
			show("bg lecturehall")
			# play music "illurock.opus"
			say({
			"what":
				"It's only when I hear the sounds of shuffling feet and supplies being put away that I realize that the lecture's over."
			})

		1:
			say({
			"what":
		    "Professor Eileen's lectures are usually interesting, but today I just couldn't concentrate on it."
			})

		2:
			say({
			"what":
		    "I've had a lot of other thoughts on my mind...thoughts that culminate in a question."
			})

		3:
			say({
				"what":
				 "It's a question that I've been meaning to ask a certain someone."
			})
