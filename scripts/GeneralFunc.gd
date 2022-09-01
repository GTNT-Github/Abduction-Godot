extends Node

func checkUI():
	return !Dialogic.has_current_dialog_node() && !Values.invOpen
