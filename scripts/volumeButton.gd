extends TextureButton


func _on_sound_pressed() -> void:
	var sound_bus = AudioServer.get_bus_index("Sfx")
	AudioServer.set_bus_mute(sound_bus, not AudioServer.is_bus_mute(sound_bus))


func _on_music_pressed() -> void:
	var music_bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
