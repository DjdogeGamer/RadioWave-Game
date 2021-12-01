extends Control

func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/cutscenes/Cutscene1.tscn")

func _on_HowToPlayButton_pressed():
	get_tree().change_scene("res://stages/HowToPlay.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
