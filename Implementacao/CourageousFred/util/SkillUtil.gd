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
		Super.idSkillCurrent = null
		print(point)
		
func GER_PIST(character) -> void :
	print("GER_PIST")
