extends Resource
class_name SceneLinks

export (Array, String) var ids : = []
export (Array, PackedScene) var scenes := []

func get_as_dict() -> Dictionary:
	var dict := {}
	var r = ids.size()

	if ids.size() != scenes.size():
		print("id and scenes are in diffrent size!!!")
		r = min(ids.size(), scenes.size())
		prints("will return only", r, "links")

	for i in range(r):
		dict[ids[i]] = scenes[i]

	return dict
