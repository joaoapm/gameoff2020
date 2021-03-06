extends Spatial
 
var skillUtil = preload("res://util/SkillUtil.gd").new()

var nbLevel1 = 10
var maxLvl1 = 4

var nbLevel2 = 1000
var maxLvl2 = 6

var nbLevel3 = 20
var maxLvl3 = 8

var varTimerSpaw=6
var varTimerAtack=2.5

var places = []
var timer 
var timerAtack 

func init():
	
	places = [$p1,$p2,$p3,$p4,$p6,$p7,$p8,$p9]
	
	spawEnemy()
	spawEnemy()
	
	if Super.level == 3: 
		varTimerAtack=7	
		
	timer = Timer.new()
	timer.connect("timeout",self,"spawEnemy") 
	timer.set_wait_time(varTimerSpaw)
	add_child(timer) 
	timer.start() 

	timerAtack = Timer.new()
	timerAtack.connect("timeout",self,"atack") 
	timerAtack.set_wait_time(varTimerAtack)
	add_child(timerAtack) 
	timerAtack.start() 	
 
func spawEnemy():
	if Super.level == 1 && $enemies.get_child_count() == maxLvl1 || Super.level == 2 && $enemies.get_child_count() == maxLvl2 || Super.level == 3 && $enemies.get_child_count() == maxLvl3:
		return
	var place = getRandomPlace()
	if place != null:
		places.erase(place)
		
		var characterAdd = load("res://comp/Character.tscn").instance()	
		characterAdd.isEnemy = true
		
		if timer != null:
			if places.size() <= 4:
				timer.set_wait_time(2)
			else:
				timer.set_wait_time(5)
		 
		randomize() 
		var maxRam
		if Super.level == 1:
			maxRam = 100
		else:
			maxRam = 125	
		var random = int(rand_range(0, maxRam))
		if random < 50: 
			characterAdd.init(Super.CHARACTERS.TOWER,place.transform.origin) 
			characterAdd.typeBullet = Super.TYPE_BULLET.ROCKET
			characterAdd.canDodge = false 
			characterAdd.voiceExplosion = false
			addEnemy(characterAdd, place)
		elif random >= 50 &&  random <= 110 :
			characterAdd.init(Super.CHARACTERS.CANNON,place.transform.origin) 
			characterAdd.typeBullet = Super.TYPE_BULLET.BULLET
			characterAdd.canDodge = true 
			characterAdd.voiceExplosion = false
			addEnemy(characterAdd, place)
		elif random > 115 && random <= 125 :
			characterAdd.init(Super.CHARACTERS.HELICOPTER,$a1.transform.origin) 
			characterAdd.typeBullet = Super.TYPE_BULLET.BULLET
			characterAdd.canDodge = true 
			characterAdd.isAutoMove = true
			characterAdd.voiceExplosion = false
			characterAdd.hilicopter = true
			characterAdd.hp = 1
			places.append(place)
			addEnemy(characterAdd, $a1)
			
func addEnemy(characterAdd, place):
		characterAdd.enemyPlace = place
		$enemies.add_child(characterAdd)	
		characterAdd.look_at($p5.transform.origin, Vector3(0,1,0))

func atack():
	for i in $enemies.get_child_count():
		randomize() 
		var random = rand_range(0, 200)
		if random < 50:
			var target = getRandomChar()
			var charAtack = getRandomEnemy()
			if target != null && charAtack != null:
				skillUtil.IA_SHOT(charAtack,target) 
	var target = getRandomChar()		
	if Super.boss != null:
		Super.boss.typeBullet =  Super.TYPE_BULLET.PHASER
		Super.boss.canDodge = false
		skillUtil.IA_SHOT(Super.boss,target)

func getRandomPlace():
	if places.size() == 0:
		return null
	randomize() 
	var random = rand_range(0, places.size()) 
	return places[int(random)]
			
func getRandomEnemy() -> Node:
	var listAerial = []
	for ae in  $enemies.get_children():
		if  ae.get("hilicopter") == false:
			listAerial.append(ae)
	randomize() 
	if listAerial.size() > 0:
		var random = rand_range(0, listAerial.size())			
		var enemySel = listAerial[random] 
		var name= enemySel.get_name()
		if enemySel != null && "Character" in enemySel.get_name()  && enemySel.hp > 0 :
			return enemySel 
	return null	 
	
func getRandomEnemyAerial() -> Node: 
	var listAerial = []
	for ae in  $enemies.get_children():
		if ae.get("hilicopter") != null &&  ae.get("hilicopter") == true:
			listAerial.append(ae)
	randomize() 
	if listAerial.size() > 0:
		var random = rand_range(0, listAerial.size())			
		var enemySel = listAerial[random]
		if enemySel != null && enemySel.hp > 0 :
			return enemySel 
	return null	 
		
func getRandomChar() -> Node:
	randomize() 
	if Super.charactersNode.get_child_count() > 0:
		var random = randi() % Super.charactersNode.get_child_count() + 1 
		var charSel = Super.charactersNode.get_child(random - 1)
		if charSel != null && "Character" in charSel.get_name() && charSel.hp > 0 :
			return charSel 
	return null	 

func verifyEndLevel(deadEnemy):
	
	if deadEnemy != null && deadEnemy.get("hilicopter") == false:
		places.append(deadEnemy.enemyPlace)
	
	if Super.level == 1:
		nbLevel1 = nbLevel1 -1; 
		if  nbLevel1 == 0:
			Super.transitionUI.fadein_transition("res://scenes/LevelComplete.tscn")
			Super.level  = 2

	elif Super.level == 2 && deadEnemy == null:  
			Super.transitionUI.fadein_transition("res://scenes/LevelComplete.tscn")
			Super.level = 3		
	
	elif Super.level == 3:
		nbLevel3 = nbLevel3 -1; 
		if  nbLevel3 == 0:
			Super.transitionUI.fadein_transition("res://scenes/GameFinal.tscn")
			Super.level = 1
