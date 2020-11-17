extends Node
	 
func process(character,id, point) -> void: 
	if id == Super.SKILLS.GER_ESC || id ==  Super.SKILLS.GER_PIST || id ==  Super.SKILLS.GER_DOC || id ==  Super.SKILLS.GER_ROCKT || id == Super.SKILLS.GER_SMOK || id ==  Super.SKILLS.GER_GRANAD : 
		GER_CHAR(character, point,id)
 
func GER_CHAR(character,point,id) -> void :
	if point == null :
		Super.idSkillCurrent = id
	else:
		var persoGer
		if id == Super.SKILLS.GER_ESC:
			persoGer = Super.CHARACTERS.ESCAVADOR
		elif id ==  Super.SKILLS.GER_PIST:
			persoGer = Super.CHARACTERS.PISTOLEIRO
		elif id ==  Super.SKILLS.GER_DOC :
			persoGer = Super.CHARACTERS.DOCTOR
		elif id ==  Super.SKILLS.GER_ROCKT:
			persoGer = Super.CHARACTERS.ROCKETER
		elif id == Super.SKILLS.GER_SMOK :
			persoGer = Super.CHARACTERS.SMOKER
		elif id ==  Super.SKILLS.GER_GRANAD : 
			persoGer = Super.CHARACTERS.GRANADIER

		Super.COOLDOWN.append({"id": Super.idSkillCurrent, "time" : 10, "character": character})
		Super.menuAction.showSubActions()
		Super.idSkillCurrent = null
		character.doAtack()
		character.showAtackProgress(5)
		yield(character.get_tree().create_timer(5.0), "timeout")
		character.endAtack()
		var characterAdd = load("res://comp/Character.tscn").instance()	
		characterAdd.init(persoGer,point)
		Super.charactersNode.add_child(characterAdd)


