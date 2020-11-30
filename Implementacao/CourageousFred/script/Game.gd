extends Spatial

func _ready():
	Super.camera = $Map.getCamera()
	Super.navMap = $Map.getNavMap()
	Super.enemyNode = $Map.getEnemyGenerator()
	Super.charactersNode = $Map.getCharactersNode()
	Super.selectedCharacter = null
	Super.menuAction = $MenuAction
	Super.transitionUI = $TransitionUI
	
	GameHelper.processCoolDown(self)
	 
	Super.enemyNode.init()
