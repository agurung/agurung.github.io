# This imports all the layers for "Keyboard Forms" into keyboardFormsLayers
layers = Framer.Importer.load "imported/Keyboard Forms"

for x of layers
	window[x] = layers[x]
	#print window[x]

BG = new Layer({
	x:0,
	y:0
	height:Screen.height,
	width:Screen.width,
	backgroundColor:"#ffffff"
})
BG.sendToBack()
Device.visible = true

Indicators.visible = true
for x of Indicators.subLayers
	Indicators.subLayers[x].visible = false

Form.visible = true
for x of Filled_Fields.subLayers
	Filled_Fields.subLayers[x].visible = false
Typeahead_Close.visible = false
Typeahead_List.visible = false

scroll = ScrollComponent.wrap(Form)
scroll.x = 0
scroll.y = 170
scroll.width = Screen.width
scroll.height = 1056
scroll.scrollHorizontal = false
scroll.scrollVertical = true

Keyboard.bringToFront()
Keyboard.states.add
	keyboardShowing:
		maxY: Screen.height
	keyboardHidden:
		y: Screen.height
Keyboard.states.switchInstant('keyboardHidden')

Dropdown.bringToFront()
Indicators.bringToFront()

#Form Field Actions
your_industry_empty.on Events.Click, ->
	Keyboard.states.switch('keyboardShowing')
	Typeahead_Close.visible = true
	Indicator_Keyboard_C.opacity = 0.0
	Indicator_Keyboard_C.scale = 0.1
	Indicator_Keyboard_C.visible = true
	Indicator_Keyboard_C.animate
		properties:
			opacity: 1.0
			scale: 1.0
		curve:"spring(200,15,0)"
		delay: 1.0
		time: .5


your_industry_filled.on Events.Click, ->
	your_industry_empty.visible = true
	your_industry_filled.visible = false
	Keyboard.states.switch('keyboardShowing')
	Typeahead_Close.visible = true
	Indicator_Keyboard_C.opacity = 0.0
	Indicator_Keyboard_C.scale = 0.1
	Indicator_Keyboard_C.visible = true
	Indicator_Keyboard_C.animate
		properties:
			opacity: 1.0
			scale: 1.0
		curve:"spring(200,15,0)"
		delay: 1.0
		time: .5

Indicator_Keyboard_C.on Events.Click, ->
	Indicator_Keyboard_C.visible = false
	Typeahead_List.opacity = 0.0
	Typeahead_List.visible = true
	Typeahead_List.animate
		properties:
			opacity: 1.0
		curve:"ease"
		time: .5
		
Typeahead_Close.on Events.Click, ->
	Keyboard.states.switch('keyboardHidden')
	Typeahead_List.visible = false
	Typeahead_Close.visible = false	
	Indicator_Keyboard_C.visible = false

Typeahead_List.on Events.Click, ->
	Keyboard.states.switch('keyboardHidden')
	Typeahead_List.visible = false
	Typeahead_Close.visible = false
	your_industry_empty.visible = false
	your_industry_filled.visible = true
	
	
you_sell_empty.on Events.Click, ->
	funcShowDropdown()
	
you_sell_filled.on Events.Click, ->
	funcShowDropdown()
	
Dropdown_Close.on Events.Click, ->
	funcHideDropdown()
	
Dropdown_Selection.on Events.Click, ->
	Indicator_Dropdown_Select.visible = false
	SelectOption = Dropdown_Selection.animate
		properties:
			opacity: 1.0
		curve:"ease"
		time: .25
	SelectOption.on "end",->
		funcHideDropdown()
		you_sell_empty.visible = false
		you_sell_filled.visible = true
	
company_type_empty.on Events.Click, ->
	company_type_empty.visible = false
	company_type_filled.visible = true
	
company_type_filled.on Events.Click, ->
	company_type_empty.visible = true
	company_type_filled.visible = false
		
accountants_empty.on Events.Click, ->
	accountants_empty.visible = false
	accountants_filled.visible = true
	
accountants_filled.on Events.Click, ->
	accountants_empty.visible = true
	accountants_filled.visible = false
	
handle_payroll_empty.on Events.Click, ->
	handle_payroll_empty.visible = false
	handle_payroll_filled.visible = true
	
handle_payroll_filled.on Events.Click, ->
	handle_payroll_empty.visible = true
	handle_payroll_filled.visible = false
	
get_paid_empty.on Events.Click, ->
	get_paid_empty.visible = false
	get_paid_filled.visible = true
	
get_paid_filled.on Events.Click, ->
	get_paid_empty.visible = true
	get_paid_filled.visible = false
	
	
funcShowDropdown = () ->
	Dropdown.opacity = 0.0
	Dropdown.visible = true
	Dropdown_Selection.opacity = 0.0
	Indicator_Dropdown_Select.opacity = 0.0
	Indicator_Dropdown_Select.scale = 0.1
	Indicator_Dropdown_Select.visible = true
	ShowDropdown = Dropdown.animate
		properties:
			opacity: 1.0
		curve: 'ease'
		time: .5
	ShowDropdown.on "end",->
		Indicator_Dropdown_Select.animate
			properties:
				opacity: 1.0
				scale: 1.0
			curve:"spring(200,15,0)"
			time: .5
			
funcHideDropdown = () ->
	Indicator_Dropdown_Select.visible = false
	HideDropdown = Dropdown.animate
		properties:
			opacity: 0.0
		curve: 'ease'
		time: .5
	HideDropdown.on "end",->
		Dropdown.visible = false