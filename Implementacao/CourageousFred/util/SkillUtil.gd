extends Node
	 
func process(character,id, point) -> void: 
	if id == Super.SKILLS.GER_ESC: 
		GER_ESC(character, point)
	elif id == Super.SKILLS.GER_PIST: 
		GER_PIST(character)	
 
func GER_ESC(character,point) -> void :
	if point == null :
		Super.idSkillCurrent = Super.SKILLS.GER_ESC 
	else:
		Super.COOLDOWN.append({"id": Super.idSkillCurrent, "time" : 5, "character": character})
		Super.menuAction.resetSkillButtons(Super.idSkillCurrent)
		Super.idSkillCurrent = null
		var characterAdd = load("res://comp/Character.tscn").instance()	
		characterAdd.init(Super.CHARACTERS.ESCAVADOR,point)
		Super.charactersNode.add_child(characterAdd)
		 
		
func GER_PIST(character) -> void :
	print("GER_PIST")
