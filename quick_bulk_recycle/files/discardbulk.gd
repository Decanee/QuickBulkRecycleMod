extends Button

onready var label = $Label

var item:Node

func _ready():
	set_bulk_item(item, item.amount)

func set_disabled(value:bool):
	.set_disabled(value)
	if label:
		label.add_color_override("default_color", get_color("font_color_disabled" if disabled else "font_color"))

func set_bulk_item(value:Node, amount:int):
	item = value
	if label:
		if item == null:
			set_disabled(true)
			return 
		var text_key = ""
		if item.is_recyclable():
			text_key = "ITEM_RECYCLE"
		else :
			text_key = "ITEM_DISCARD"
		
		var subs = {}
		if item.item.recycle_to:
			var font_height = label.get_font("normal_font").get_height()
			subs.icon = "[font=res://addons/platform/input_icons/bbcode_img_font.tres][img=0x" + str(font_height) + "]" + item.item.recycle_to.icon.resource_path + "[/img][/font]"
			subs.amount = item.get_recycle_amount(amount)
		label.bbcode_text = "[center]" + "(x" + str(amount) + ") " + Loc.trf(text_key, subs) + "[/center]"
		
		set_disabled( not item.is_discardable())
		
		if item.item is BlankTape and not SaveState.has_ability("glide"):
			
			set_disabled(true)
