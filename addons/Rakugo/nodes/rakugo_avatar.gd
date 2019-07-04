extends Node
class_name RakugoAvatar, "res://addons/Rakugo/icons/rakugo_avatar.svg"

signal on_substate(substate)

onready var rnode : = RakugoNodeCore.new()

export var avatar_id = name
export (Array, String) var state setget _set_state, _get_state

var _state : = []
var avatar_link : Avatar

func _ready():
	if Engine.editor_hint:
		if avatar_id.empty():
			avatar_id = name

		add_to_group("save", true)
		return

	hide()

	Rakugo.connect("show", self, "_on_show")
	Rakugo.connect("hide", self, "_on_hide")
	rnode.connect("on_substate", self, "_on_substate")

	if avatar_id.empty():
		avatar_id = name

	avatar_link = Rakugo.get_avatar_link(avatar_id)

	if not avatar_link:
		avatar_link = Rakugo.avatar_link(avatar_id, get_path())

	else:
		avatar_link.node_path = get_path()

	add_to_group("save", true)

func _on_rnode_substate(substate):
	emit_signal("on_substate", substate)

func _on_show(avatar_id : String, state_value : Array, show_args : Dictionary) -> void:
	if self.avatar_id != avatar_id:
		return

	_set_state(state_value)

	if not self.visible:
		show()

func _set_state(state : Array) -> void:
	__state = value

	if not value:
		return

	if not rnode:
		return

	if not Engine.editor_hint:
		_state = rnode.setup_state(value)

func _get_state() -> Array:
	return _state

func _on_hide(_avatar_id) -> void:
	if _avatar_id != avatar_id:
		return

	hide()

func _exit_tree() -> void:
	if(Engine.editor_hint):
		remove_from_group("save")
		return

	var id = Avatar._get_var_prefix + avatar_id
	Rakugo.variables.erase(id)

func on_save() -> void:
	avatar_link = Rakugo.get_avatar_link(avatar_id)
	avatar_link.value["visible"] = visible
	avatar_link.value["state"] = _state

func on_load(game_version:String) -> void:
	avatar_link = Rakugo.get_avatar_link(avatar_id)

	if "visible" in avatar_link.value:
		visible = avatar_link.value["visible"]

		if visible:
			_state = avatar_link.value["state"]
			last_show_args = {}
			_on_show(avatar_id, _state , last_show_args )

	else:
		_on_hide(avatar_id)

func _on_substate(substate):
	pass
