extends RigidBody
  
var velocity = Vector3.ZERO
var team = Super.TEAM.PLAYER
var target
var _canDodge

func _physics_process(delta):
	if target != null:
		var dir
		if _canDodge:
			dir = (target - get_global_transform().origin).normalized()
			global_translate(dir*(100 * delta))	  
			if  get_global_transform().origin.distance_to(target) <= 1.7:
				queue_free()
		else:
			dir = (target.get_global_transform().origin  - get_global_transform().origin).normalized()	
			global_translate(dir*(100 * delta))	  
			if  get_global_transform().origin.distance_to(target.get_global_transform().origin) <= 1.7:
				queue_free()
  
func init(charShot,targetChar,teamBullet,canDodge):
	_canDodge = canDodge
	team = teamBullet
	Super.charactersNode.get_parent().add_child(self)
	transform = charShot.getAtackPos().global_transform 
	if canDodge:
		target = targetChar.get_global_transform().origin 
	else:
		target	= targetChar
