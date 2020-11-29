extends Button


func _ready():
	pass


func _on_Button_button_down():
	$AudioStreamPlayer3D.play()
