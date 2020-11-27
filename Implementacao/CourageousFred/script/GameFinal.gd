extends Control

func _on_restartButton_button_up():
	$TransitionUI.fadein_transition("res://scenes/Intro.tscn")
 
func _on_VideoPlayer_finished():
	$restartButton.show()
