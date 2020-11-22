extends Node
	 
func process(character,id, point) -> void: 
	if id == Super.SKILLS.GER_ESC || id ==  Super.SKILLS.GER_GUNS || id ==  Super.SKILLS.GER_DOC || id ==  Super.SKILLS.GER_ROCKT || id == Super.SKILLS.GER_SMOK || id ==  Super.SKILLS.GER_GRANAD : 
		GER_CHAR(character, point,id)
	elif id == Super.SKILLS.GER_BARRIER:
		GER_BARRIER(character, point,id)
	elif id == Super.SKILLS.GUNS_SHOT:
		GUNS_SHOT(character, point,id)	
	elif id == Super.SKILLS.CURE:
		CURE(character, point,id)	
		 
func GER_CHAR(character,point,id) -> void :
	if point == null :
		character.idSkillCurrent = id 
		character.showRange(1)
	else:
		var persoGer
		if id == Super.SKILLS.GER_ESC:
			persoGer = Super.CHARACTERS.DIGGER
		elif id ==  Super.SKILLS.GER_GUNS:
			persoGer = Super.CHARACTERS.GUNSLINGER
		elif id ==  Super.SKILLS.GER_DOC :
			persoGer = Super.CHARACTERS.DOCTOR
		elif id ==  Super.SKILLS.GER_ROCKT:
			persoGer = Super.CHARACTERS.ROCKETER
		elif id == Super.SKILLS.GER_SMOK :
			persoGer = Super.CHARACTERS.SMOKER
		elif id ==  Super.SKILLS.GER_GRANAD : 
			persoGer = Super.CHARACTERS.GRANADIER

		Super.COOLDOWN.append({"id": character.idSkillCurrent, "time" : 10, "character": character})
		Super.menuAction.showSubActions()
		character.doAtack(point,true)
		character.showAtackProgress(Super.COOLDOWN_SKILL)
		yield(character.get_tree().create_timer(Super.COOLDOWN_SKILL), "timeout")
		if character.idSkillCurrent != null:
			character.idSkillCurrent = null
			character.endAtack()
			var characterAdd = load("res://comp/Character.tscn").instance()	
			characterAdd.init(persoGer,point)
			Super.charactersNode.add_child(characterAdd)

func GER_BARRIER(character,point,id) :
	if point == null :
		character.idSkillCurrent = id 
		character.showRange(1)
	else:	
		Super.COOLDOWN.append({"id": character.idSkillCurrent, "time" : 10, "character": character})
		Super.menuAction.showSubActions()
		character.doAtack(point,true)
		character.showAtackProgress(Super.COOLDOWN_SKILL)
		yield(character.get_tree().create_timer(Super.COOLDOWN_SKILL), "timeout")
		if character != null && character.idSkillCurrent != null:
			character.endAtack() 
			character.idSkillCurrent = null
			var barrierAdd = load("res://comp/Barrier.tscn").instance()
			barrierAdd.init(point)	
			Super.charactersNode.add_child(barrierAdd)

func GUNS_SHOT(character,point,id) :
	Super.COOLDOWN.append({"id": id, "time" : 5, "character": character})
	Super.menuAction.showSubActions()
	var bulledAdd = load("res://comp/Bullet.tscn").instance()
	var enemy = Super.enemyNode.getRandomEnemy()
	if enemy != null:
		bulledAdd.init(character,enemy,Super.TEAM.PLAYER,false, Super.TYPE_BULLET.BULLET)
		character.doAtack(enemy.get_global_transform().origin, false)
	
func IA_SHOT(character,target) :  
	var bulledAdd = load("res://comp/Bullet.tscn").instance() 
	character.doAtack(target.get_global_transform().origin, false) 
	bulledAdd.init(character,target,Super.TEAM.ENEMY,character.canDodge,character.typeBullet)

func CURE(character,point,id) :
	if point == null :
		character.idSkillCurrent = id 
		character.isCharTargetSkillCurrent = true
		character.showRange(2)
	else:	
		Super.COOLDOWN.append({"id": character.idSkillCurrent, "time" : 10, "character": character})
		Super.menuAction.showSubActions()
		character.idSkillCurrent = null 
		character.isCharTargetSkillCurrent = false

