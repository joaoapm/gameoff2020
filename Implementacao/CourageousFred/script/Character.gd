extends Spatial

var skillUtil = preload("res://util/SkillUtil.gd").new()

var idChar = Super.CHARACTERS.FRED

var action
var actionChanged

var finalPoint
var actualPoint
var path
var actualPath:int
var changePath:bool 
var movSpeed:int = 20
var turnSpeed:int = 8

var hp:int = 10
 
func _ready():
	Super.connect("on_click_btn_skill",self,"on_click_btn_skill")
	Super.connect("on_complete_skill",self,"on_complete_skill")
	
func _process(delta):

	if actualPoint:
		var dir = (actualPoint - get_global_transform().origin).normalized()
		global_translate(dir*(delta * movSpeed ))
		 
		var quatDirLook = Quat(get_global_transform().looking_at(actualPoint, Vector3(0,1,0)).basis)
		var quatVlDirLook = Quat(get_global_transform().basis).slerp(quatDirLook, (turnSpeed * delta))
		transform.basis = Basis(quatVlDirLook)		

	if path!= null and path.size() > 1:
		#player.play("CORRENDO")	
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
			#player.play("ESPERANDO")

func doAction(pathMove) -> void:
	if action == Super.ACTIONS.MOVE:
		move(pathMove) 
	 
func move(pathMove): 
	if !actionChanged:
		changePath = true 
		actualPath = 1		
		path = pathMove	
		set_process(true)		
		
func setSelected(isSelected:bool) -> void :
	$selected.visible = isSelected;	
	Super.menuAction.show()
	
func setAction(newAction) -> void:
	action = newAction 
	
	if action == Super.ACTIONS.ATACK:
		Super.menuAction.showSubActions(idChar)
		 
func on_click_btn_skill(idSkill) -> void :
	if self == Super.selectedCharacter:
		skillUtil.process(self,idSkill, null)
		
func on_complete_skill(point) -> void :
	if self == Super.selectedCharacter:
		skillUtil.process(self,Super.idSkillCurrent,point)		
