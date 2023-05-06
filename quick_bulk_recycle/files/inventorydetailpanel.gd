extends "res://menus/inventory/InventoryDetailPanel.gd"

const DiscardBulk = preload("discardbulk.tscn")

func grab_focus():
	if recycle_box.visible:
		recycle_box.grab_focus()
		return 
	
	for button in buttons.get_children():
		buttons.remove_child(button)
		button.queue_free()
	
	if item_node != null and item_node.is_usable(context_kind, context):
		for option in item_node.get_use_options(context_kind, context):
			var button = Button.new()
			button.text = option.label
			button.disabled = option.get("disabled", false)
			button.connect("pressed", self, "_on_use_button_pressed", [button, option.arg])
			buttons.add_child(button)
	else :
		var button = Button.new()
		button.text = "ITEM_USE"
		button.set_disabled(true)
		buttons.add_child(button)
	
	var discardBulk = DiscardBulk.instance()
	discardBulk.set_bulk_item(item_node, amount)
	discardBulk.connect("pressed", self, "_on_discard_bulk_pressed")
	buttons.add_child(discardBulk)
	
	var discard = DiscardButton.instance()
	discard.set_item(item_node)
	discard.connect("pressed", self, "_on_discard_pressed")
	buttons.add_child(discard)
	
	var cancel_button = Button.new()
	cancel_button.text = "UI_BUTTON_CANCEL"
	cancel_button.connect("pressed", self, "_on_cancel_button_pressed")
	buttons.add_child(cancel_button)
	
	buttons.visible = true
	buttons.setup_focus()
	buttons.get_child(0).grab_focus()

func _on_discard_bulk_pressed():
	recycle_box.item_node = item_node
	recycle_box.do_bulk_recycle()
