extends Spatial

func _ready():
	Super.camera = $Camera
	Super.navMap = $Map.getNavMap()
	Super.menuAction = $MenuAction
	Super.charactersNode = $Characters
	Super.enemyNode = $EnemyGenerator   
	Super.transitionUI = $TransitionUI 
	GameHelper.processCoolDown(self)
	
	$EnemyGenerator.init() 
