extends Area2D


func _on_Whetstone_body_entered(body):
	if(body.get_name() == "Player"):
		globalSingleton.Items_collected.append($AnimatedSprite)
		globalSingleton.item_dictionary["Stone"] = true
		self.position = Vector2(1e5, 1e5)
