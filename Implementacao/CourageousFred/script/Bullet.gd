extends KinematicBody
   
var team = Super.TEAM.PLAYER
var target
var _canDodge
const lifespan = 5
var time_alive = 0.0 
var muzzle_velocity = 25 
var velocity = Vector3.ZERO
var isArea = false
var isTargeted = false

func _physics_process(delta):
	
	if isTargeted && (target == null || target.hp < 1):
		queue_free()
		
	if _canDodge: 
		look_at(transform.origin + velocity.normalized(), Vector3.UP)
		transform.origin += 4 *  velocity * delta
				
	if target != null:   
		var	dir = (target.get_global_transform().origin  - get_global_transform().origin).normalized()	
		global_translate(dir*(100 * delta))	 
		$bullet.look_at(dir, Vector3.UP) 
	 
	time_alive += delta
	if time_alive > lifespan:
		queue_free()  
		
func init(charShot,targetChar,teamBullet,canDodge, typeBullet, _isArea):
	
	isArea = _isArea
	
	if _isArea:
		$granade.show()	
		$SoundCannon.play()
	elif typeBullet == Super.TYPE_BULLET.BULLET:
		$SoundCannon.play()
		$bullet.show()
	elif typeBullet == Super.TYPE_BULLET.ROCKET:
		$SoundRocket.play()
		$rocket.show() 
	elif typeBullet == Super.TYPE_BULLET.PHASER:
		$SoundPistol.play()
		$phaser.show() 
				
	_canDodge = canDodge
	team = teamBullet
	Super.charactersNode.get_parent().add_child(self)
	 
	if canDodge:
		transform = charShot.getAtackPos().global_transform
		velocity = transform.basis.z * muzzle_velocity
	else:
		transform = charShot.getAtackPos().global_transform 
		target	= targetChar
		isTargeted = true

func processAreaAtack(): 
	var bodies = $Area.get_overlapping_bodies ( )
	for charAtck in bodies:
		if charAtck.get("hp") != null && charAtck != self && charAtck.isImortal == false:
			charAtck._on_damageArea_body_entered(self)

 
