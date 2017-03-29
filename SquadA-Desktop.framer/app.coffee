# This imports all the layers for "sketch_desktop" into sketch_desktopLayers
desktop = Framer.Importer.load "imported/sketch_desktop"

Device = desktop.Company_Setup_D_000

Page_Start = desktop.Company_Setup_D_001
Button_Start = desktop.Button_Start

Page_Employer = desktop.Company_Setup_D_003
Button_Employer_1_Yes = desktop.Button_Employer_1_Yes
Button_Employer_1_No = desktop.Button_Employer_1_No
Button_Employer_2_Yes = desktop.Button_Employer_2_Yes
Button_Employer_2_No = desktop.Button_Employer_2_No
Button_Employer_3_Yes = desktop.Button_Employer_3_Yes
Button_Employer_3_No = desktop.Button_Employer_3_No
Link_Employer_Tooltip = desktop.Link_Employer_Tooltip
Tooltip_Employer = desktop.Tooltip_Employer
Button_Employer_Close = desktop.Button_Employer_Close
Button_Employer_Next = desktop.Button_Employer_Next

Page_FormEmpty = desktop.Company_Setup_D_005

Page_FormPartial = desktop.Company_Setup_D_006
DropDown_FormPartial_State = desktop.DropDown_FormPartial_State
Button_FormPartial_Close = desktop.Button_FormPartial_Close
Button_FormPartial_Previous = desktop.Button_FormPartial_Previous
DropDown_FormPartial_Options = desktop.DropDown_FormPartial_Options
Select_DropDown_Oregon = desktop.Oregon

Page_FormFilled = desktop.Company_Setup_D_007

BG = new Layer({
	x:0,
	height:screen.height,
	width:screen.width,
	backgroundColor:"#ffffff"
})
Page_Employer.backgroundColor = '#ffffff'
Page_FormEmpty.backgroundColor = '#ffffff'
Page_FormPartial.backgroundColor = '#ffffff'
Page_FormFilled.backgroundColor = '#ffffff'

BG.sendToBack()
Device.bringToFront()
Page_Employer.placeBehind(Device)
Page_FormEmpty.placeBehind(Device)
Page_FormPartial.placeBehind(Device)
Page_FormFilled.placeBehind(Device)

Device.visible = false

Page_Start.visible = true
Page_Start.y = 0
Page_Start.x = 0

Page_Employer.visible = false
Page_Employer.y = 0
Page_Employer.x = 0
Tooltip_Employer.states.add
	hidden:
		opacity: 0
	visible:
		opacity: 1
Tooltip_Employer.states.switchInstant('hidden')

Page_FormEmpty.visible = false
Page_FormEmpty.y = 0
Page_FormEmpty.x = 0

Page_FormPartial.visible = false
Page_FormPartial.y = 0
Page_FormPartial.x = 0
DropDown_FormPartial_Options.states.add
	hidden:
		opacity: 0
	visible:
		opacity: 1
DropDown_FormPartial_Options.states.switchInstant('hidden')

Page_FormFilled.visible = false
Page_FormFilled.y = 0
Page_FormFilled.x = 0


#PageStart Actions
Button_Start.on Events.Click, ->
	Button_Start.backgroundColor = "#D8D8D8"
	Page_Employer.maxY = 0
	Page_Employer.visible = true
	Tooltip_Employer.states.switchInstant('hidden')
	#Set Buttons to Off
	GoToEmployer = 	Page_Employer.animate
		properties:
			y: 0
		curve: "spring(400,25,0)"
	GoToEmployer.on "end",->
		Button_Start.backgroundColor = "#ffffff"
		Page_Start.visible = false


#Employer Actions
#Button_Employer_1_Yes = desktop.Button_Employer_1_Yes
#Button_Employer_1_No = desktop.Button_Employer_1_No
#Button_Employer_2_Yes = desktop.Button_Employer_2_Yes
#Button_Employer_2_No = desktop.Button_Employer_2_No
#Button_Employer_3_Yes = desktop.Button_Employer_3_Yes
#Button_Employer_3_No = desktop.Button_Employer_3_No

Button_Employer_Close.on Events.Click, ->
	Page_Start.visible = true
	GoBackToStart = Page_Employer.animate
		properties:
			maxY: 0
		curve: "spring(400,25,0)"
	GoBackToStart.on "end",->
		Page_Employer.visible = false

Link_Employer_Tooltip.on Events.Click, ->
	Tooltip_Employer.states.next()

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
	DropDown_FormPartial_Options.states.next()

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
DropDown_FormPartial_Options.on Events.Click, ->
	Page_FormFilled.visible = true
	Page_FormPartial.visible = false