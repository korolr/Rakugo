extends GDScriptDialog

onready var s = get_var("s")
onready var m = get_var("m")

func rightaway(node_name, dialog_name):
	var cd = check_dialog(node_name, dialog_name, "rightaway")

	if not cd:
		return

	match get_story_state():
		0:
			show("sylvie green smile")
			s.say({
			"what":
				"Hi there! How was class?"
			})

		1:
			m.say({
			"what":
				"Good..."
			})

		2:
			say({
			"what":
				"I can't bring myself to admit that it all went in one ear and out the other."
			})

		3:
			m.say({
			"what":
				"Are you going home now? Wanna walk back with me?"
			})

		4:
			s.say({
			"what":
				"Sure!"
			})

		5:
			show("bg meadow")
			say({
			"what":
				"After a short while, we reach the meadows just outside the neighborhood where we both live."
			})

		6:
			say({
			"what":
				"It's a scenic view I've grown used to. Autumn is especially beautiful here."
			})

		7:
			say({
			"what":
				"When we were children, we played in these meadows a lot, so they're full of memories."
			})

		8:
			m.say({
				"what":
					"Hey... Umm..."
			})

		9:
			show("sylvie green smile")
			say({
			"what":
			 "She turns to me and smiles. She looks so welcoming that I feel my nervousness melt away."
			})

		10:
			say({
			"what":
				"I'll ask her...!"
			})

		11:
			m.say({
			"what":
				"Ummm... Will you..."
			})

		12:
			m.say({
			"what":
				"Will you be my artist for a visual novel?"
			})

		13:
			show("sylvie green surprised")
			say({
			"what":
				"Silence."
			})

		14:
			say({
			"what":
				"She looks so shocked that I begin to fear the worst. But then..."
			})

		15:
			show("sylvie green smile")
			s.menu({
			"what":
				"Sure, but what's a \"visual novel?\"",
			"choices":
				{
        	"It's a videogame.": "game",
					"It's an interactive book.": "book"
				}
			})

func game(node_name, dialog_name):
	var cd = check_dialog(node_name, dialog_name, "game")

	if not cd:
		return

	jump("Start", "game", "game")

func book(node_name, dialog_name):
	var cd = check_dialog(node_name, dialog_name, "book")

	if not cd:
		return

	jump("Start", "book", "book")
