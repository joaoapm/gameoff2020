extends TextureButton

var id
 
func _on_BtnSkill_button_up():
	Super.emit_signal("on_click_btn_skill",id)

func initButton(id:int) -> void :
	if id == Super.SKILLS.GER_ESC :
		self.texture_hover = preload("res://assets/icons/GER_ESC_hover.png")
		self.texture_normal = preload("res://assets/icons/GER_ESC_normal.png")
		self.texture_pressed = preload("res://assets/icons/GER_ESC_pressed.png")
		self.texture_disabled = preload("res://assets/icons/GER_ESC_disabled.png")
