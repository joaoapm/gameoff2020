extends Spatial

var velocity = Vector3.ZERO
var muzzle_velocity = 2 
const lifespan = 15
var time_alive = 0.0 

var hp = 1

func _ready():
	velocity = -transform.basis.x * muzzle_velocity
	
func _physics_process(delta): 
	transform.origin += 4 *  velocity * delta
	time_alive += delta	
	if time_alive > lifespan:
		queue_free() 		
 
