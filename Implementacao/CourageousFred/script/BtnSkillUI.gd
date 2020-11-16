extends TextureButton

var id

func _process(delta):
	if $block.visible:
		for skill in Super.COOLDOWN:
			if	id == skill["id"] && Super.selectedCharacter == skill["character"]:
				$block/lblTime.text = String(skill["time"])
				if skill["time"] == 0:
					$block.hide()
		
 
func _on_BtnSkill_button_up():
	Super.emit_signal("on_click_btn_skill",id)

func initButton(id:int) -> void :
	if id == Super.SKILLS.GER_ESC :
		self.texture_hover = preload("res://assets/icons/GER_ESC_hover.png")
		self.texture_normal = preload("res://assets/icons/GER_ESC_normal.png")
		self.texture_pressed = preload("res://assets/icons/GER_ESC_pressed.png")
		self.texture_disabled = preload("res://assets/icons/GER_ESC_disabled.png")

	for skill in Super.COOLDOWN:
		if	id == skill["id"] && Super.selectedCharacter == skill["character"]:
			$block.show()
			break
