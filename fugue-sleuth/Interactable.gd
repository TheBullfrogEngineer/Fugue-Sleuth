class_name InteractableObject
#This acts as a class that can be added as a child
#to any component we want to make interactable
extends Node
signal interacted()
func interact_with():
	interacted.emit()
 
