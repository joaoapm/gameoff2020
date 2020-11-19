extends Spatial

var IAHelper = preload("res://util/IAHelper.gd").new()

var timer;
 
func _ready():
	Super.camera = $Camera
	Super.navMap = $Map.getNavMap()
	Super.menuAction = $MenuAction
	Super.charactersNode = $Characters
	Super.enemyNode = $Enemys
	Super.inimigo = $Enemys/INIMIGO
	
	GameHelper.createTimer(self,"coolDownTimer")
	IAHelper.init(self)

func coolDownTimer():
	for skill in Super.COOLDOWN:
		Super.emit_signal("on_verify_cooldown")
		var skillatt = { "id" : skill["id"], "time" :  skill["time"] - 1,  "character": skill["character"]  }
		Super.COOLDOWN.erase(skill)	  
		if skillatt["time"] > -1:
			Super.COOLDOWN.append(skillatt)
