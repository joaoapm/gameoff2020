extends KinematicBody
   
var team = Super.TEAM.PLAYER
var target
var _canDodge
const lifespan = 5
var time_alive = 0.0 
var muzzle_velocity = 25 
var velocity = Vector3.ZERO

func _physics_process(delta):
	
	if _canDodge: 
		look_at(transform.origin + velocity.normalized(), Vector3.UP)
		transform.origin += 4 *  velocity * delta
		time_alive += delta
		if time_alive > lifespan:
			queue_free() 
				
	if target != null:   
		var	dir = (target.get_global_transform().origin  - get_global_transform().origin).normalized()	
		global_translate(dir*(100 * delta))	  
 
func init(charShot,targetChar,teamBullet,canDodge):
	_canDodge = canDodge
	team = teamBullet
	Super.charactersNode.get_parent().add_child(self)
	 
	if canDodge:
		transform = charShot.getAtackPos().global_transform
		velocity = transform.basis.z * muzzle_velocity
	else:
		transform = charShot.getAtackPos().global_transform 
		target	= targetChar
