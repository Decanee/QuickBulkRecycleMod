extends "res://menus/inventory/InventoryDetailPanel.gd"

const DiscardBulk = preload("discardbulk.tscn")

func grab_focus():
	.grab_focus()
	var discardBulk = DiscardBulk.instance()
	discardBulk.set_bulk_item(item_node, amount)
	discardBulk.connect("pressed", self, "_on_discard_bulk_pressed")
	buttons.add_child(discardBulk)

func _on_discard_bulk_pressed():
	recycle_box.item_node = item_node
	recycle_box.do_bulk_recycle()
