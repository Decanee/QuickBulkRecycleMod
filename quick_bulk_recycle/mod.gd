extends ContentInfo

const RESOURCES = {
	"res://menus/inventory/RecycleBox.gd": preload("files/recyclebox.gd"),
	"res://menus/inventory/InventoryDetailPanel.gd": preload("files/inventorydetailpanel.gd"),
}

func _init() -> void:

	for k in RESOURCES:
		RESOURCES[k].take_over_path(k)
