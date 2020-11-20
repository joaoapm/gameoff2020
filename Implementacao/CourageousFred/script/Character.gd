extends Spatial

var skillUtil = preload("res://util/SkillUtil.gd").new()

var idChar = Super.CHARACTERS.FRED 
var hp:int = 15

var action
var actionChanged
var player

var atacking:bool = false
var finalPoint
var actualPoint
var path
var actualPath:int
var changePath:bool 
var movSpeed:int = 20
var turnSpeed:int = 8
var isDead = false
var enemyPlace 
var typeBullet
var canDodge = false

var idSkillCurrent = null
 
export(bool) onready var isEnemy
export(Resource) onready var node

func _ready():
	Super.connect("on_click_btn_skill",self,"on_click_btn_skill")
	Super.connect("on_complete_skill",self,"on_complete_skill")
	
	if node != null:
		self.get_node("mesh").add_child(node.instance())
		player  = get_node("mesh").get_child(0).get_node("AnimationPlayer")
		$ProgBarLIfe.setValueMax(hp)

func init(character, point) -> void: 
	var assetAdd =  Super.CHAR_ASSETS[character].instance() 
	hp = 5
	idChar = character
	$mesh.add_child(assetAdd) 
	player  = get_node("mesh").get_child(0).get_node("AnimationPlayer")
	transform.origin = point 
	$ProgBarLIfe.setValueMax(hp)
	
func _process(delta):

	if actualPoint:
		var dir = (actualPoint - get_global_transform().origin).normalized()
		global_translate(dir*(delta * movSpeed ))
		 
		var quatDirLook = Quat(get_global_transform().looking_at(actualPoint, Vector3(0,1,0)).basis)
		var quatVlDirLook = Quat(get_global_transform().basis).slerp(quatDirLook, (turnSpeed * delta))
		transform.basis = Basis(quatVlDirLook)		

	if path!= null and path.size() > 1:
		player.play("MOVENDO")	
		var d = get_global_transform().origin.distance_to(path[actualPath]) 
		if d <= delta * movSpeed:
			actualPath += 1
			actualPoint = null
			
		if  (changePath) or (actualPath < path.size()):  
			actualPoint = path[actualPath]
			changePath = false
 
		else: if 	actualPath == path.size():
			actualPath = 1 
			path = null
			set_process(false)
			player.play("ESPERANDO")

func setAction(newAction) -> void:
	if !atacking && !isEnemy && !isDead:
		action = newAction 
	
func doAction(pathMove) -> void:
	if !isEnemy && action == Super.ACTIONS.MOVE && !atacking && !isDead:
		move(pathMove) 
	 
func move(pathMove): 
	if !atacking && !isEnemy && !actionChanged && !isDead:
		changePath = true 
		actualPath = 1		
		path = pathMove	
		set_process(true)		
		
func setSelected(isSelected:bool) -> void :
	if !isEnemy:
		action = Super.ACTIONS.MOVE
		$selected.visible = isSelected;	
		Super.menuAction.showSubActions()
		if !isSelected:
			$selected/range.hide()
	
func on_click_btn_skill(idSkill) -> void :
	if !atacking && self == Super.selectedCharacter:
		skillUtil.process(self,idSkill, null) 
		
func on_complete_skill(point) -> void :
	if !atacking && self == Super.selectedCharacter:
		skillUtil.process(self,idSkillCurrent,point)	
		$selected/range.hide()	
		set_process(false)

func resetActions() -> void:
	idSkillCurrent = null
	$selected/range.hide()
	
func doAtack(point,block): 
	if !atacking:
		if point != null:
			look_at(point,Vector3(0,1,0))
		if block:
			atacking = true
		player.play("ATAQUE")
	
func endAtack():
	atacking = false
	player.play("ESPERANDO")	
	
func showAtackProgress(time):
	$ProgBarCoolDown.start(time)	

func showRange():
	$selected/range.show()
	
func getAtackPos():
	return $mesh.get_child(0).get_node("posAtaque")		
	
func getTarget():
	return $mesh.get_child(0).get_node("target")							

func _on_damageArea_body_entered(body):
	if body != null && body.get("team") != null &&  body != self && ((isEnemy && body.team == Super.TEAM.PLAYER) || (!isEnemy && body.team == Super.TEAM.ENEMY)):
		body.queue_free()
		hp = hp - 1 
		$ProgBarLIfe.setValue(hp)
		if hp == 0:
			if atacking:
				idSkillCurrent = null 
			set_process(false)
			isDead = true
			player.play("MORTO")
			yield(get_tree().create_timer(1.0), "timeout")
			queue_free()
			if idChar == Super.CHARACTERS.FRED:
				Super.transitionUI.fadein_transition("res://scenes/EngGame.tscn")
			if isEnemy:
				Super.enemyNode.verifyEndLevel(self)	
			else:
				Super.menuAction.hide()	
			
