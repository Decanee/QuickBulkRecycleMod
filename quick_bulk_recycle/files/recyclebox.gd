extends "res://menus/inventory/RecycleBox.gd"

func do_bulk_recycle():
	accept_event()
	choose_value(item_node.amount)
