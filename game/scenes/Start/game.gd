extends GDScriptDialog

onready var s = get_var("s")
onready var m = get_var("m")

func game(node_name, dialog_name):
	var cd = check_dialog(node_name, dialog_name, "rightaway")

	if not cd:
		return

	match get_story_state():
		0:
			m.say({
			"what":
				"It's a kind of videogame you can play on your computer or a console."
			})

		1:
			m.say({
			"what":
				"Visual novels tell a story with pictures and music."
			})

		2:
			m.say({
			"what":
				"Sometimes, you also get to make choices that affect the outcome of the story."
			})

		3:
			s.say({
			"what":
				"So it's like those choose-your-adventure books?"
			})

		4:
			m.say({
			"what":
				"Exactly! I've got lots of different ideas that I think would work."
			})

		5:
			m.say({
			"what":
				"And I thought maybe you could help me...since I know how you like to draw."
			})

		6:
			show("sylvie green normal")
			s.say({
			"what":
				"Well, sure! I can try. I just hope I don't disappoint you."
			})

		7:
			m.say({
			"what":
				"You know you could never disappoint me, [s.name]."
			})

#		8:
#			jump("Start", "marry", "marry")
			
