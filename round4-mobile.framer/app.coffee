# This imports all the layers for "Squad_A_StepPattern_03_SK" into squad_a_steppattern_03_skLayers
layers = Framer.Importer.load "imported/Squad_A_StepPattern_03_SK"
Step = 1
ScrollPoint = 0

for x of layers
	window[x] = layers[x]
for x of step1_filled.subLayers
	step1_filled.subLayers[x].visible = false
for x of step2_filled.subLayers
	step2_filled.subLayers[x].visible = false
for x of chk_selected.subLayers
	chk_selected.subLayers[x].visible = false
	
scroll = new ScrollComponent
	x: 0, y: 260, width: Screen.width * 3, height:1056, scrollHorizontal: false, scrollVertical: true
scroll.contentInset = {
    top: 0
    bottom: 0
    right: 0
    left: 0
}
Step1.superLayer = scroll.content
Step2.superLayer = scroll.content
Step2.x = Screen.width
Step3.superLayer = scroll.content
Step3.x = Screen.width * 2

StepIndicator = new Layer({
	x:0,
	y:Steps.height - 10
	height:10,
	width:0,
	backgroundColor:"#000000"
})
StepIndicator.superLayer = Steps

Keyboard.states.add
	keyboardShowing:
		maxY: Screen.height
	keyboardHidden:
		y: Screen.height
Keyboard.states.switchInstant('keyboardHidden')
Keyboard.visible = true

funcShowKeyboard = () ->
	Keyboard.states.switch('keyboardShowing')
	if scroll.contentInset.bottom == 0 
		scroll.contentInset = {
			top: 0
			bottom: Keyboard.height
			right: 0
			left: 0
		}

	
funcHideKeyboard = () ->
	Keyboard.states.switch('keyboardHidden')
	scroll.contentInset = {
	    top: 0
	    bottom: 0
	    right: 0
	    left: 0
	}


funcGoToStep = (step) ->
	funcHideKeyboard()
	Step1_Text.visible = if step == 1 then true else false
	Step2_Text.visible = if step == 2 then true else false
	Step3_Text.visible = if step == 3 then true else false
	Steps.y = header.y + header.height
	scroll.scrollVertical = if step == 2 then false else true
	scroll.scrollY = 0
	scroll.y = Trowser.y + Steps.maxY
	scroll.animate
		properties:
			x: -((step * Screen.width) - Screen.width)
		curve:"ease"
		time: .75
	StepIndicator.animate
		properties:
			width: (step/3) * Screen.width
		curve:"ease"
		time: .75
		
Btn_Prev_S2.on Events.Click, ->
	Step = Step - 1
	funcGoToStep(Step)
Btn_Prev_S3.on Events.Click, ->
	Step = Step - 1
	funcGoToStep(Step)
	
Btn_Next_S1.on Events.Click, ->
	Step = Step + 1
	funcGoToStep(Step)
Btn_Next_S2.on Events.Click, ->
	Step = Step + 1
	funcGoToStep(Step)

scroll.on Events.Scroll, ->
	deltaY = 54 - scroll.scrollPoint.y
	deltaY = if deltaY > 0 then 0 else deltaY
	newY = (header.y + header.height) + deltaY
	Steps.y = if newY > 0 then newY else 0
	scroll.y = Trowser.y + Steps.maxY

funcScrollToPoint = (point) ->
	if(point != ScrollPoint)
		deltaY = 54 - point
		deltaY = if deltaY > 0 then 0 else deltaY
		newY = (header.y + header.height) + deltaY
		Steps.y = if newY > 0 then newY else 0
		scroll.y = Trowser.y + Steps.maxY
		scroll.scrollY = ScrollPoint
		scroll.animate
			properties:
				scrollY: point
			curve:"ease"
			time: .25
		ScrollPoint = point
			
Device.visible = true
Trowser.visible = true

Step1.visible = true
Step2.visible = true
Step3.visible = true

scroll.bringToFront()
Trowser.bringToFront()
State_Dropdown.bringToFront()
Industry_Dropdown.bringToFront()
Business_Dropdown.bringToFront()
Keyboard.bringToFront()

funcGoToStep(Step)

Keyboard.on Events.Click, ->
	funcHideKeyboard()
	point = if ScrollPoint == 0 then 0 else (txt_name.y - 84)
	funcScrollToPoint(point)

#Step 1 Functions
txt_name.on Events.Click, ->
	funcShowKeyboard()
	txt_name_filled.visible = true
txt_address.on Events.Click, ->
	funcShowKeyboard()
	txt_address_filled.visible = true
	funcScrollToPoint(txt_address.y - 84)
txt_city.on Events.Click, ->
	funcShowKeyboard()
	txt_city_filled.visible = true
	funcScrollToPoint(txt_city.y - 84)
ddl_state.on Events.Click, ->
	funcHideKeyboard()
	funcShowDropdown(State_Dropdown, State_Selection)
txt_zip.on Events.Click, ->
	funcShowKeyboard()
	txt_zip_filled.visible = true
	funcScrollToPoint(txt_zip.y - 84)
txt_phone.on Events.Click, ->
	funcShowKeyboard()
	txt_phone_filled.visible = true
	funcScrollToPoint(txt_zip.y - 84)
txt_web.on Events.Click, ->
	funcShowKeyboard()
	txt_web_filled.visible = true
	funcScrollToPoint(txt_zip.y - 84)
	
#Step 2 Functions
ddl_industry.on Events.Click, ->
	funcShowDropdown(Industry_Dropdown, Industry_Selection)
ddl_business.on Events.Click, ->
	funcShowDropdown(Business_Dropdown, Business_Selection)

#Step 3 Functions
chk_excel_default.on Events.Click, ->
	chk_excel_selected.visible = !(chk_excel_selected.visible)
chk_quickbooks_default.on Events.Click, ->
	chk_quickbooks_selected.visible = !(chk_quickbooks_selected.visible)
chk_google_default.on Events.Click, ->
	chk_google_selected.visible = !(chk_google_selected.visible)
chk_penpaper_default.on Events.Click, ->
	chk_penpaper_selected.visible = !(chk_penpaper_selected.visible)
chk_banking_default.on Events.Click, ->
	chk_banking_selected.visible = !(chk_banking_selected.visible)
chk_other_default.on Events.Click, ->
	chk_other_selected.visible = !(chk_other_selected.visible)
	
State_Dropdown_Close.on Events.Click, ->
	funcHideDropdown(State_Dropdown)

State_Selection.on Events.Click, ->
	SelectOption = State_Selection.animate
		properties:
			opacity: 1.0
		curve:"ease"
		time: .25
	SelectOption.on "end",->
		funcHideDropdown(State_Dropdown)
		ddl_state_filled.visible = true
	
Industry_Dropdown_Close.on Events.Click, ->
	funcHideDropdown(Industry_Dropdown)

Industry_Selection.on Events.Click, ->
	SelectOption = Industry_Selection.animate
		properties:
			opacity: 1.0
		curve:"ease"
		time: .25
	SelectOption.on "end",->
		funcHideDropdown(Industry_Dropdown)
		ddl_industry_filled.visible = true
		ddl_industry_default.visible = false
	
Business_Dropdown_Close.on Events.Click, ->
	funcHideDropdown(Business_Dropdown)

Business_Selection.on Events.Click, ->
	SelectOption = Business_Selection.animate
		properties:
			opacity: 1.0
		curve:"ease"
		time: .25
	SelectOption.on "end",->
		funcHideDropdown(Business_Dropdown)
		ddl_business_filled.visible = true
		ddl_business_default.visible = false
		
funcShowDropdown = (dd, dds) ->
	dd.opacity = 0.0
	dd.visible = true
	dds.opacity = 0.0
	ShowDropdown = dd.animate
		properties:
			opacity: 1.0
		curve: 'ease'
		time: .5
	ShowDropdown.on "end",->
		dds.animate
			properties:
				opacity: 0.25
				scale: 1.0
			curve:"spring(200,15,0)"
			time: .5
			
funcHideDropdown = (dd) ->
	HideDropdown = dd.animate
		properties:
			opacity: 0.0
		curve: 'ease'
		time: .5
	HideDropdown.on "end",->
		dd.visible = false
	
