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

		4:
			show("bg uni")
			say({
			"what":
				"When we come out of the university, I spot her right away."
			})

		5:
			show("sylvie green normal")
			say({
			"what":
				"I've known [s.name] since we were kids. She's got a big heart and she's always been a good friend to me."
			})

		6:
			say({
			"what":
				"But recently... I've felt that I want something more."
			})

		7:
			say({
			"what":
		    "But recently... I've felt that I want something more."
			})

		8:
			say({
			"what":
				"More than just talking, more than just walking home together when our classes end."
			})

		9:
			menu({
			"what":
				"As soon as she catches my eye, I decide...",
			"choices":
				{
					"To ask her right away.": "rightaway",
					"To ask her later.": "later"
				}
			})

func rightaway(node_name, dialog_name):
	var cd = check_dialog(node_name, dialog_name, "rightaway")

	if not cd:
		return

	jump("Start", " rightaway", "rightaway")

func later(node_name, dialog_name):
	var cd = check_dialog(node_name, dialog_name, "later")

	if not cd:
		return

	jump("Start", "later", "later")
