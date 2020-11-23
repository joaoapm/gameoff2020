extends Spatial
 
var skillUtil = preload("res://util/SkillUtil.gd").new()

var nbLevel1 = 1
var maxLvl1 = 3

var nbLevel2 = 1000
var maxLvl2 = 6

var nbLevel3 = 1000
var maxLvl3 = 9

var places = []

func init():
	
	places = [$p1,$p2,$p3,$p4,$p6,$p7,$p8,$p9]
	
	spawEnemy()
	spawEnemy()
	
	var timer = Timer.new()
	timer.connect("timeout",self,"spawEnemy") 
	timer.set_wait_time(10)
	add_child(timer) 
	timer.start() 

	var timerAtack = Timer.new()
	timerAtack.connect("timeout",self,"atack") 
	timerAtack.set_wait_time(5)
	add_child(timerAtack) 
	#timerAtack.start() 	
 
func spawEnemy():
	if Super.level == 1 && $enemies.get_child_count() == maxLvl1 || Super.level == 2 && $enemies.get_child_count() == maxLvl2 || Super.level == 3 && $enemies.get_child_count() == maxLvl3:
		return
	var place = getRandomPlace()
	if place != null:
		places.erase(place)
		
		var characterAdd = load("res://comp/Character.tscn").instance()	
		characterAdd.isEnemy = true
		
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
			addEnemy(characterAdd, place)
		elif random >= 50 &&  random <= 100 :
			characterAdd.init(Super.CHARACTERS.CANNON,place.transform.origin) 
			characterAdd.typeBullet = Super.TYPE_BULLET.BULLET
			characterAdd.canDodge = true 
			addEnemy(characterAdd, place)
		elif random > 100 && random <= 125 :
			characterAdd.init(Super.CHARACTERS.HELICOPTER,$a1.transform.origin) 
			characterAdd.typeBullet = Super.TYPE_BULLET.BULLET
			characterAdd.canDodge = true 
			characterAdd.isAutoMove = true
			characterAdd.hilicopter = true
			addEnemy(characterAdd, place)
			
func addEnemy(characterAdd, place):
		characterAdd.enemyPlace = place
		$enemies.add_child(characterAdd)	
		characterAdd.look_at($p5.transform.origin, Vector3(0,1,0))

func atack():
	for i in $enemies.get_child_count():
		randomize() 
		var random = rand_range(0, 150)
		if random < 50:
			var target = getRandomChar()
			var charAtack = getRandomEnemy()
			if target != null && charAtack != null:
				skillUtil.IA_SHOT(charAtack,target) 

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
		if enemySel != null && enemySel.hp > 0 :
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
	var random = randi() % Super.charactersNode.get_child_count() + 1 
	var charSel = Super.charactersNode.get_child(random - 1)
	if charSel != null && charSel.hp > 0 :
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
			Super.transitionUI.fadein_transition("res://scenes/LevelComplete.tscn")
			Super.level = 4
