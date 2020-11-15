extends Control

var id
 
func _on_BtnSkill_button_up():
	Super.emit_signal("on_click_btn_skill",id)

func setLabel(label:String) -> void :
	pass
