# This imports all the layers for "sketch_mobile" into sketch_mobileLayers
mobile = Framer.Importer.load "imported/sketch_mobile"

Device = mobile.Company_Setup_M_000
Page_Start = mobile.Company_Setup_M_001
Button_Start = mobile.Button_Start

Page_Employer = mobile.Company_Setup_M_002
Button_Employer_1_Yes = mobile.Button_Employer_1_Yes
Button_Employer_1_No = mobile.Button_Employer_1_No
Button_Employer_2_Yes = mobile.Button_Employer_2_Yes
Button_Employer_2_No = mobile.Button_Employer_2_No
Button_Employer_3_Yes = mobile.Button_Employer_3_Yes
Button_Employer_3_No = mobile.Button_Employer_3_No
Link_Employer_Tooltip = mobile.Link_Employer_Tooltip
Tooltip_Employer = mobile.Tooltip_Employer
Button_Tooltip_Close = mobile.Button_Tooltip_Close
Button_Employer_Guidance = mobile.Button_Employer_Guidance
Guidance_Employer = mobile.Guidance_Employer
Button_Guidance_Close = mobile.Button_Guidance_Close
Button_Employer_Close = mobile.Button_Employer_Close
Button_Employer_Next = mobile.Button_Employer_Next

Page_FormEmpty = mobile.Company_Setup_M_006

Page_FormPartial = mobile.Company_Setup_M_007
DropDown_FormPartial_State = mobile.Dropdown
Button_FormPartial_Close = mobile.Button_FormPartial_Close
Button_FormPartial_Previous = mobile.Button_FormPartial_Previous

Page_Dropdown = mobile.Company_Setup_M_008
Select_DropDown_Oregon = mobile.Oregon
Button_DropDown_Close = mobile.Button_DropDown_Close

Page_FormFilled = mobile.Company_Setup_M_009

BG = new Layer({
	x:0,
	y:0
	height:Screen.height,
	width:Screen.width,
	backgroundColor:"#ffffff"
})
Overlay = new Layer({
	x:0,
	y:88
	opacity:.7,
	height:Screen.height,
	width:Screen.width,
	backgroundColor:"#4A4A4A"
})
Page_Employer.addSubLayer(Overlay)

BG.sendToBack()
Device.bringToFront()
Overlay.placeBehind(Guidance_Employer)
Page_Employer.placeBehind(Overlay)
Page_FormEmpty.placeBehind(Overlay)
Page_FormPartial.placeBehind(Overlay)
Page_FormFilled.placeBehind(Overlay)
Page_Dropdown.placeBehind(Overlay)

Device.center()

Page_Start.visible = true

Page_Employer.visible = false

Overlay.states.add
	hidden:
		opacity: 0
		visible: false
	visible:
		opacity: 0.7
		visible:true
Overlay.states.switchInstant('hidden')

Tooltip_Employer.states.add
	hidden:
		opacity: 0
	visible:
		opacity: 1
Tooltip_Employer.states.switchInstant('hidden')
Button_Tooltip_Close.states.add
	hidden:
		opacity: 0
	visible:
		opacity: 1
Button_Tooltip_Close.states.switchInstant('hidden')

Guidance_Employer.states.add
	hidden:
		opacity: 0
	visible:
		opacity: 1
Guidance_Employer.states.switchInstant('hidden')
Button_Guidance_Close.states.add
	hidden:
		opacity: 0
	visible:
		opacity: 1
Button_Guidance_Close.states.switchInstant('hidden')

Page_FormEmpty.visible = false

Page_FormPartial.visible = false

Page_Dropdown.visible = false

Page_FormFilled.visible = false

#PageStart Actions
Button_Start.on Events.Click, ->
	Page_Employer.maxY = 0
	Page_Employer.visible = true
	Button_Start.backgroundColor = "#D8D8D8"
	GoToEmployer = Page_Employer.animate
		properties:
			minY: 0
		curve: "spring(400,25,0)"
	GoToEmployer.on "end",->
		Button_Start.backgroundColor = "#ffffff"
		Page_Start.visible = false

#Employer Actions
#Button_Employer_1_Yes = mobile.Button_Employer_1_Yes
#Button_Employer_1_No = mobile.Button_Employer_1_No
#Button_Employer_2_Yes = mobile.Button_Employer_2_Yes
#Button_Employer_2_No = mobile.Button_Employer_2_No
#Button_Employer_3_Yes = mobile.Button_Employer_3_Yes
#Button_Employer_3_No = mobile.Button_Employer_3_No

Button_Employer_Close.on Events.Click, ->
	Page_Start.visible = true
	GoBackToStart = Page_Employer.animate
		properties:
			maxY: 0
		curve: "spring(400,25,0)"
	GoBackToStart.on "end",->
		Page_Employer.visible = false

Link_Employer_Tooltip.on Events.Click, ->
	Tooltip_Employer.states.switch('visible')
	Button_Tooltip_Close.states.switchInstant('visible')
	Overlay.states.switchInstant('visible')
	
Button_Tooltip_Close.on Events.Click, ->
	Tooltip_Employer.states.switch('hidden')
	Button_Tooltip_Close.states.switch('hidden')
	Overlay.states.switchInstant('hidden')

Button_Employer_Guidance.on Events.Click, ->
	Guidance_Employer.states.switch('visible')
	Button_Guidance_Close.states.switchInstant('visible')
	Overlay.states.switchInstant('visible')
	
Button_Guidance_Close.on Events.Click, ->
	Guidance_Employer.states.switch('hidden')
	Button_Guidance_Close.states.switch('hidden')
	Overlay.states.switchInstant('hidden')
	
Button_Employer_Next.on Events.Click, ->
	Button_Employer_Next.backgroundColor = "#D8D8D8"
	Page_FormEmpty.opacity = 0.0
	Page_FormEmpty.visible = true
	GoToForm = Page_FormEmpty.animate
		properties:
			opacity: 1
		curve: 'ease'
		time: .5
	GoToForm.on "end",->
		Button_Employer_Next.backgroundColor = "#ffffff"
		Page_Employer.visible = false


#PageFormEmpty Actions
Page_FormEmpty.on Events.Click, ->
	Page_FormPartial.opacity = 0.0
	Page_FormPartial.visible = true
	FillInForm = Page_FormPartial.animate
		properties:
			opacity: 1
		curve: 'ease'
		time: .5
	FillInForm.on "end",->
		Page_FormEmpty.visible = false



#PageFormPartial Actions
DropDown_FormPartial_State.on Events.Click, ->
	Page_Dropdown.opacity = 0.0
	Page_Dropdown.visible = true
	DropDown_FormPartial_State.backgroundColor = "#D8D8D8"
	ShowDropdown = Page_Dropdown.animate
		properties:
			opacity: 1.0
		curve: 'ease'
		time: .5
	ShowDropdown.on "end",->
		DropDown_FormPartial_State.backgroundColor = "#ffffff"
		Page_FormPartial.visible = false

Button_FormPartial_Close.on Events.Click, ->
	Page_Start.visible = true
	CloseForm = Page_FormPartial.animate
		properties:
			maxY: 0
		curve: "spring(400,25,0)"
	CloseForm.on "end",->
		Page_FormPartial.visible = false

Button_FormPartial_Previous.on Events.Click, ->
	Button_FormPartial_Previous.backgroundColor = "#D8D8D8"
	Page_Employer.visible = true
	GoBackToEmployer = Page_FormPartial.animate
		properties:
			opacity: 0.0
		curve: 'ease'
		time: .5
	GoBackToEmployer.on "end",->
		Button_FormPartial_Previous.backgroundColor = "#ffffff"
		Page_FormPartial.visible = false

#PageDropDown Actions
Select_DropDown_Oregon.on Events.Click, ->
	Select_DropDown_Oregon.backgroundColor = "#D8D8D8"
	Select_DropDown_Oregon.opacity = 0.5
	Page_FormFilled.visible = true
	Page_Dropdown.animate
		properties:
			opacity: 0.0
		curve: 'ease'
		time: .75

Button_DropDown_Close.on Events.Click, ->
	Page_FormPartial.visible = true
	Page_Dropdown.animate
		properties:
			opacity: 0.0
		curve: 'ease'
		time: .5
