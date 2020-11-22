extends TextureButton

var id

func _ready():
	Super.connect("on_verify_cooldown",self,"on_verify_cooldown")	

func on_verify_cooldown():
	if $block.visible:
		for skill in Super.COOLDOWN:
			if	id == skill["id"] && Super.selectedCharacter == skill["character"]:
				$block/lblTime.text = String(skill["time"])
				if skill["time"] == 0:
					$block.hide()
		
func _on_BtnSkill_button_up():
	Super.emit_signal("on_click_btn_skill",id)
	
	Super.menuAction.unPress()

func initButton(_id:int) -> void :
	var skillName = Super.SKILLS.keys()[_id]  
	self.texture_hover = load("res://assets/icons/"+skillName+"_hover.png")
	self.texture_normal = load("res://assets/icons/"+skillName+"_normal.png")
	self.texture_pressed = load("res://assets/icons/"+skillName+"_pressed.png")
	self.texture_disabled = load("res://assets/icons/"+skillName+"_disabled.png")
											
	for skill in Super.COOLDOWN:
		if	_id == skill["id"] && Super.selectedCharacter == skill["character"]:
			$block/lblTime.text = String(skill["time"])
			$block.show()
			break
