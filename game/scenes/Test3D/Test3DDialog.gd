extends GDScriptDialog

onready var s = get_var("s")
onready var m = get_var("m")

func test(node_name, dialog_name):
	var cd = check_dialog(node_name, dialog_name, "test")
	
	if not s:
		s = get_var("s")
	
	if not m:
		m = get_var("m")

	if not cd:
		return

	match get_story_state():
		0:
			show("sylvie green smile")
			s.say({
			"what":
				"Test 3D, fixes and features"
			})