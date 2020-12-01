extends Node
 
func createTimer(node,method) -> void:
	var	timer = Timer.new()
	timer.connect("timeout",node,method) 
	timer.set_wait_time(1)
	node.add_child(timer) 
	timer.start() 

func processCoolDown(node) -> bool:
	GameHelper.createTimer(self,"coolDownTimer")
	return true

func coolDownTimer():
	for skill in Super.COOLDOWN:
		Super.emit_signal("on_verify_cooldown")
		var skillatt = { "id" : skill["id"], "time" :  skill["time"] - 1,  "character": skill["character"]  }
		Super.COOLDOWN.erase(skill)	  
		if skillatt["time"] > -1:
			Super.COOLDOWN.append(skillatt)
