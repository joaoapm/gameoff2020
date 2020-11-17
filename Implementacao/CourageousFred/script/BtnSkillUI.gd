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

func initButton(_id:int) -> void :
	if _id == Super.SKILLS.GER_ESC :
		self.texture_hover = preload("res://assets/icons/GER_ESC_hover.png")
		self.texture_normal = preload("res://assets/icons/GER_ESC_normal.png")
		self.texture_pressed = preload("res://assets/icons/GER_ESC_pressed.png")
		self.texture_disabled = preload("res://assets/icons/GER_ESC_disabled.png")
	elif _id == Super.SKILLS.GER_PIST :
		self.texture_hover = preload("res://assets/icons/GER_GUNS_hover.png")
		self.texture_normal = preload("res://assets/icons/GER_GUNS_normal.png")
		self.texture_pressed = preload("res://assets/icons/GER_GUNS_pressed.png")
		self.texture_disabled = preload("res://assets/icons/GER_GUNS_disabled.png")	
	elif _id == Super.SKILLS.GER_BARRIER :
		self.texture_hover = preload("res://assets/icons/GER_BARRIER_hover.png")
		self.texture_normal = preload("res://assets/icons/GER_BARRIER_normal.png")
		self.texture_pressed = preload("res://assets/icons/GER_BARRIER_pressed.png")
		self.texture_disabled = preload("res://assets/icons/GER_BARRIER_disabled.png")		
	elif _id == Super.SKILLS.GUNS_SHOT :
		self.texture_hover = preload("res://assets/icons/GUNS_SHOT_hover.png")
		self.texture_normal = preload("res://assets/icons/GUNS_SHOT_normal.png")
		self.texture_pressed = preload("res://assets/icons/GUNS_SHOT_pressed.png")
		self.texture_disabled = preload("res://assets/icons/GUNS_SHOT_disabled.png")	
		
	for skill in Super.COOLDOWN:
		if	_id == skill["id"] && Super.selectedCharacter == skill["character"]:
			$block/lblTime.text = String(skill["time"])
			$block.show()
			break
