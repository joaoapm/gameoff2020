extends Control

func _on_SkipButton_button_up():
	$VideoPlayer.stop()
	$VideoPlayer.queue_free()
	$SkipButton.hide()

func _on_VideoPlayer_finished():
	_on_SkipButton_button_up()
