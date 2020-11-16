extends Spatial

var timer;
 
func _ready():
	Super.camera = $Camera
	Super.navMap = $Map.getNavMap()
	Super.menuAction = $MenuAction
	Super.charactersNode = $Characters
	
	GameHelper.createTimer(self,"coolDownTimer")

func coolDownTimer():
	for skill in Super.COOLDOWN: 
		var skillatt = { "id" : skill["id"], "time" :  skill["time"] - 1,  "character": skill["character"]  }
		Super.COOLDOWN.erase(skill)	  
		if skillatt["time"] > -1:
			Super.COOLDOWN.append(skillatt)
