extends Control

export onready var nav_panel : Node = $Navigation
export var nav_path : NodePath = "Navigation/ScrollContainer/HBoxContainer/VBoxContainer"
export var in_game_gui_path : = "/root/Window/InGameGUI"
export onready var scrollbar : = $Navigation/ScrollContainer/HBoxContainer/VScrollBar 
export var use_back_button : = false
export onready var back_button : Button = $BackButton
export onready var unpause_timer : Timer = $UnpauseTimer

var current_node : Node = self
onready var in_game_gui : = get_node(in_game_gui_path)
onready var new_game_button : Button = get_node(str(nav_path) + "/" + "NewGame")
onready var continue_button : Button = get_node(str(nav_path) + "/" + "Continue")
onready var return_button : Button = get_node(str(nav_path) + "/" + "Return")
onready var save_button : Button = get_node(str(nav_path) + "/" + "Save")
onready var history_button : Button = get_node(str(nav_path) + "/" + "History")
onready var quests_button : Button = get_node(str(nav_path) + "/" + "Quests")
onready var load_button : Button = get_node(str(nav_path) + "/" + "Load")
onready var options_button : Button = get_node(str(nav_path) + "/" + "Options")
onready var about_button : Button = get_node(str(nav_path) + "/" + "About")
onready var help_button : Button = get_node(str(nav_path) + "/" + "Help")
onready var quit_button : Button = get_node(str(nav_path) + "/" + "Quit")
onready var test_button : Button = get_node(str(nav_path) + "/" + "TestNodes")

func _ready():
	get_tree().set_auto_accept_quit(false)
	connect("visibility_changed", self, "_on_visibility_changed")
	
	var qno_button = $QuitBox/HBoxContainer/No
	var qyes_button = $QuitBox/HBoxContainer/Yes
	qno_button.connect("pressed", self, "_on_Return_pressed")
	qyes_button.connect("pressed", self, "_on_Yes_pressed")
	
	back_button.connect("pressed", self, "_on_back_button")
	
	new_game_button.connect("pressed", self, "_on_NewGame_pressed")
	continue_button.connect("pressed", self, "_on_Continue_pressed")
	return_button.connect("pressed", self, "_on_Return_pressed")
	save_button.connect("pressed", self, "_on_Save_pressed")
	history_button.connect("pressed", self, "_on_History_pressed(")
	quests_button.connect("pressed", self, "_on_Quests_pressed")
	load_button.connect("pressed", self, "_on_Load_pressed")
	options_button.connect("pressed", self, "_on_Options_pressed")
	about_button.connect("pressed", self, "_on_About_pressed")
	help_button.connect("pressed", self, "_on_Help_pressed")
	quit_button.connect("pressed", self, "_on_Quit_pressed")
	
	## this is just for testing things
	test_button.connect("pressed", self, "_on_TestNodes_pressed")
	
	var auto_save_path = str("user://" + Ren.save_folder + "/auto.save")
	
	if not Ren.file.file_exists(auto_save_path):
		continue_button.hide()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_on_Quit_pressed()

func show_page(node):
	if not use_back_button:
		if current_node != self:
			current_node.hide()
		
	current_node = node
	node.show()
	
	if use_back_button:
		nav_panel.hide()
		back_button.show()
		
func _on_back_button():
	current_node.hide()
	nav_panel.show()
	back_button.hide()

func save_menu(screenshot):
	get_node(str(nav_path) + "/" + "Save").pressed = true
	show_page($SlotBox)
	$SlotBox/Title.text = "Save"
	$SlotBox.savebox()
	$SlotBox.screenshot = screenshot
	show()

func load_menu():
	get_node(str(nav_path) + "/" + "Load").pressed = true
	show_page($SlotBox)
	$SlotBox/Title.text = "Load"
	$SlotBox.loadbox()
	show()

func history_menu():
	get_node(str(nav_path) + "/" + "History").pressed = true
	show_page($HistoryBox)
	show()

func _on_visibility_changed():
	if visible:
		get_tree().paused = true
		in_game_gui.hide()
	else:
		get_tree().paused = false
		in_game_gui.show()

## # if press "Return" or "no" on quit page
func _on_Return_pressed():
	if Ren.started:
		hide()
	else:
		current_node.hide()

func _on_Load_pressed():
	load_menu()

func in_game():
	new_game_button.hide()
	continue_button.hide()
	return_button.show()
	save_button.show()
	history_button.show()
	quests_button.show()
	scrollbar.show()
	

func _on_NewGame_pressed():
	hide()
	in_game()
	Ren.start()

func _on_History_pressed():
	history_menu()

func _on_Continue_pressed():
	if !Ren.loadfile("auto"):
		return

	in_game()
	hide()

func _on_Quests_pressed():
	get_node(str(nav_path) + "/" + "Quests").pressed = true
	show_page($QuestsBox)
	show()

# if press "yes" on quit page
func _on_Yes_pressed():
	Ren.savefile("auto")
	settings.save_conf()
	get_tree().quit()

func _on_Quit_pressed():
	get_node(str(nav_path) + "/" + "Quit").pressed = true
	show_page($QuitBox)
	show()

func get_screenshot():
	return get_viewport().get_texture().get_data()

func _on_Save_pressed():
	hide() 
	save_menu(get_screenshot())

func _on_TestNodes_pressed():
	show_page($TestNodes)
	show()

func _on_Options_pressed():
	get_node(str(nav_path) + "/" + "Options").pressed = true
	show_page($OptionsBox)
	show()

func _on_About_pressed():
	show_page($AboutBox)
	show()

func _on_Help_pressed():
	OS.shell_open("https://github.com/jebedaia360/Ren")

func _fullscreen_on_input(event):
	if event.is_action_pressed("ren_fullscreen"):
		if settings.window_fullscreen:
			settings.window_fullscreen = false
			settings.window_size = settings.default_window_size
		
		else:
			settings.window_fullscreen = true
			settings.window_size = OS.get_screen_size()
			
func _screenshot_on_input(event):
	if event.is_action_pressed("ren_screenshot"):
		var dir = Directory.new()
		var screenshots_dir = "user://screenshots"
		if !dir.dir_exists(screenshots_dir):
			dir.make_dir(screenshots_dir)
		
		var s = Ren.get_datetime_str().replace(":", " ")
		get_screenshot().save_png(screenshots_dir + "/" + s + '.png')

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if visible:
			_on_Return_pressed()
		elif use_back_button:
			show()
		else:
			_on_Options_pressed()
		
		return
	
	if Ren.can_alphanumeric:
		_fullscreen_on_input(event)
		_screenshot_on_input(event)
