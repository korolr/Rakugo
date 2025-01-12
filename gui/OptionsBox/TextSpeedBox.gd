extends VBoxContainer

func _ready() -> void:
	$Slider.connect("value_changed", self, "on_change_value")
	connect("visibility_changed", self, "on_visibility_changed")

func on_change_value(value : float) -> void:
	var new_value = abs(1 - value/100) * Rakugo.get_value("auto_time")
	Rakugo.set_var("text_time", new_value)

func on_visibility_changed() -> void:
	if visible == false:
		return
	
	$Slider.value = Rakugo.get_value("text_time")*100
	