# This imports all the layers for "Run_Payroll_E2E_01_CB" into run_payroll_e2e_01_cbLayers
importedLayers = Framer.Importer.load "imported/Run_Payroll_E2E_01_CB"

for x of importedLayers
	window[x] = importedLayers[x]

for x of importedLayers
	importedLayers[x].originalFrame = window[x].frame

curvemove = 'cubic-bezier(0.4, 0, 0.2, 1)'
curvein = 'cubic-bezier(0, 0, 0.2, 1)'
curveout = 'cubic-bezier(0.4, 0, 1, 1)'
#Set stage for everything
#Trowser
#trowser_header_sticky.y = -1400
#trowser_background.y = -1400
#step_pattern.y = step_pattern.y - 1400
step_pattern_step_2_text_active.opacity = 0
step_pattern_step_3_text_active.opacity = 0
pay_details_small.opacity = 0
bank_details_small.opacity = 0
pay_details_small.y = pay_details_small.originalFrame.y - 30 
bank_details_small.y = bank_details_small.originalFrame.y + 30 
real_header.opacity = 0
ee_list_sticky.visible = false
trowser_background.visible = false
step_2_header_small.opacity = 0
step_2_header_small.y = step_2_header_small.originalFrame.y - 30
step_2_sticky_table_header.visible = false
#step_2.opacity = 0
step_3_done_button.visible = false
step_3_form.opacity = 0
step_3_form.visible = false
step_3_form.x = step_3_form.originalFrame.x + 45
print_payslips.opacity = 0
print_payslips.visible = false
print_payslips.x = print_payslips.originalFrame.x + 45 
currentStep = "1"
step_3_data_input.opacity = 0
s_01.opacity = 0
s_02.opacity = 0
s_03.opacity = 0
s_04.opacity = 0
rti_Complete.visible = false
check_Banner.opacity = 0
check_Banner.scale = 0
rti_Success_Message_Banner.opacity = 0


###################################
###     Step Pattern Layers     ###
###################################
step_progress_indicator = new Layer
    x: 0, y: 84, width: 474, height: 4, backgroundColor: "#000000"

step_pattern_background = new Layer
	x: 0, y: 0, width: 474, height: 44, backgroundColor: "#F5F5F5", superLayer: step_pattern

step_pattern_background.placeBehind(step_pattern_step_1_text)


layerSubmitButton = new Layer
	x: 32
	y: 610
	width: 88
	height: 34
	borderColor: "#979797"
	borderWidth: 1
	backgroundColor: "#FFFFFF"
	cornerRadius: 4
	html: "Submit"
	style:
		textAlign: 'center'
		fontSize: '14px'
		fontfamily: 'Avenier Next'
		color: '#808080'

layerSubmitButton.opacity = 0
layerSubmitButton.x = layerSubmitButton.x + 45
###################################
###     Step 1 Scroller         ###
###################################
step_1_scroller = new ScrollComponent
	#backgroundColor: "#333333"
	scrollHorizontal: false
	width: 1440+30
	height: 800
	y: 44


step_1_above_table.superLayer = step_1_scroller.content
step_1_table.superLayer = step_1_scroller.content
step_pattern.placeBefore(step_1_scroller)
step_pattern.originY = 0
#step_1_scroller.originY = 1

step_1_scroller.sendToBack()
steps_big = true
pay_details_big = true
bank_details_big = true
header_stuck = false



step_2_scroller = new ScrollComponent
	#backgroundColor: "#333333"
	scrollHorizontal: false
	width: 1440+30
	height: 800
	y: 44
	x: 20 + 45 

step_2_scroller.sendToBack()
step_2_above_table.superLayer = step_2_scroller.content
step_2_table.superLayer = step_2_scroller.content
#step_2_table.superLayer = step_2_scroller.content
step_2_scroller.visible = false
step_2_scroller.opacity = 0


#Detail States + Animat
step_pattern.states.add
    shrink: { scaleY: 0 }
    grow: { scaleY: 1 }
step_pattern.states.animationOptions =
	time: .2



step_progress_indicator.states.add
    shrink: { y: 38 }
    grow: { y: 84 }

step_progress_indicator.states.animationOptions =
	time: .2



pay_details_small.states.add
    shrink: { y: pay_details_small.originalFrame.y, opacity: 1 }
    grow: { y: pay_details_small.originalFrame.y - 30, opacity: 0 }

pay_details_small.states.animationOptions =
	time: .2



pay_details_large.states.add
    hide: { opacity: 0 }
    show: { opacity: 1 }

pay_details_large.states.animationOptions =
	time: .2
	
	


bank_details_small.states.add
    shrink: { y: bank_details_small.originalFrame.y, opacity: 1 }
    grow: { y: bank_details_small.originalFrame.y + 30, opacity: 0 }

bank_details_small.states.animationOptions =
	time: .2



bank_details_large.states.add
    show: { opacity: 1 }
    hide: { opacity: 0 }

bank_details_large.states.animationOptions =
	time: .2



real_header.states.add
    shrink: { opacity: 1 }
    grow: { opacity: 0 }

real_header.states.animationOptions =
	time: .2


step_1_scroller.on Events.Scroll, ->
	if step_1_scroller.scrollY > 30 && steps_big == true
		steps_big = false
		step_pattern.states.switch("shrink")
		step_progress_indicator.states.switch("shrink")

	if step_1_scroller.scrollY < 30 && steps_big == false
		steps_big = true
		step_pattern.states.switch("grow")
		step_progress_indicator.states.switch("grow")

	if step_1_scroller.scrollY > 80 && pay_details_big == true
		pay_details_big = false
		pay_details_small.states.switch("shrink")
		pay_details_large.states.switch("hide")
			
	if step_1_scroller.scrollY < 80 && pay_details_big == false
		pay_details_big = true
		pay_details_small.states.switch("grow")
		pay_details_large.states.switch("show")


	if step_1_scroller.scrollY > 135 && bank_details_big == true
		bank_details_big = false
		bank_details_small.states.switch("shrink")
		bank_details_large.states.switch("hide")

	if step_1_scroller.scrollY < 135 && bank_details_big == false
		bank_details_big = true
		bank_details_small.states.switch("grow")
		bank_details_large.states.switch("show")
			
	if step_1_scroller.scrollY > 166 && header_stuck == false
		header_stuck = true
		_table_header.visible = false
		real_header.states.switch("shrink")

	if step_1_scroller.scrollY < 166 && header_stuck == true
		header_stuck = false
		_table_header.visible = true
		real_header.states.switch("grow")


















step_2_header_big.states.add
    shrink: { opacity: 0 }
    grow: { opacity: 1 }
step_2_header_big.states.animationOptions =
	time: .2

step_2_header_small.states.add
    show: { y: step_2_header_small.originalFrame.y, opacity: 1 }
    hide: { y: step_2_header_small.originalFrame.y - 30, opacity: 0 }
step_2_header_small.states.animationOptions =
	time: .2

step_2_steps_big = true
step_2_pay_details_big = true
step_2_header_stuck = false


step_2_scroller.on Events.Scroll, ->
	if step_2_scroller.scrollY > 30 && step_2_steps_big == true
		step_2_steps_big = false
		step_pattern.states.switch("shrink")
		step_progress_indicator.states.switch("shrink")

	if step_2_scroller.scrollY < 30 && step_2_steps_big == false
		step_2_steps_big = true
		step_pattern.states.switch("grow")
		step_progress_indicator.states.switch("grow")

	if step_2_scroller.scrollY > 114 && step_2_pay_details_big == true
		step_2_pay_details_big = false
		step_2_header_big.states.switch("shrink")
		step_2_header_small.states.switch("show")
			
	if step_2_scroller.scrollY < 114 && step_2_pay_details_big == false
		step_2_pay_details_big = true
		step_2_header_big.states.switch("grow")
		step_2_header_small.states.switch("hide")

	if step_2_scroller.scrollY > 197 && step_2_header_stuck == false
		step_2_header_stuck = true
		step_2_sticky_table_header.visible = true
			
	if step_2_scroller.scrollY < 197 && step_2_header_stuck == true
		step_2_header_stuck = false
		step_2_sticky_table_header.visible = false






































step_1_next_button.on Events.Click, ->
	if currentStep == "1"
		Step_1_to_Step_2()
		currentStep = "2"
	else if currentStep == "2"
		Step_2_to_Step_3()
		currentStep = "3"




###################################
###       Animate to Step 2     ###
###################################
Step_1_to_Step_2 = () ->
		step_progress_indicator.animate
			properties:
				width: 972
			curve: "ease-in-out"
			time: 1
		step_pattern_background.animate
			properties:
				width: 972
			curve: "ease-in-out"
			time: 1
		step_pattern_step_2_text_active.animate
			properties:
				opacity: 1
			time: .2
			delay: .4
		step_pattern.animate
			properties:
				scaleY: 1
			time: .2
		step_progress_indicator.animate
			properties:
				y: 84
			time: .2
		bank_details_small.animate
			properties:
				opacity: 0
				x: bank_details_small.x - 45
			time: .5
		pay_details_small.animate
			properties:
				opacity: 0
				x: pay_details_small.x - 45
			time: .5
		step_1_scroller.animate
			properties:
				opacity: 0
				x: step_1_scroller.x - 45
			time: .5
		real_header.animate
			properties:
				opacity: 0
				x: real_header.x - 45
			time: .5
		step_2_scroller.visible = true
		step_2_scroller.animate
			properties:
				opacity: 1
				x: 20
			time: .5
			delay: .5
		step_1_scroller.sendToBack()
		



###################################
###       Animate to Step 3     ###
###################################
Step_2_to_Step_3 = () ->
		step_progress_indicator.animate
			properties:
				width: 1440
			curve: "ease-in-out"
			time: 1
		step_pattern_background.animate
			properties:
				width: 1440
			curve: "ease-in-out"
			time: 1
		step_pattern_step_3_text_active.animate
			properties:
				opacity: 1
			time: .2
			delay: .4
		step_pattern.animate
			properties:
				scaleY: 1
			time: .7
		step_progress_indicator.animate
			properties:
				y: 84
			time: .2
		step_2_header_big.animate
			properties:
				opacity: 0
				x: step_2_header_big.x - 45
			time: .5
		step_2_header_small.animate
			properties:
				opacity: 0
				x: step_2_header_small.x - 45
			time: .5
		step_2_scroller.animate
			properties:
				opacity: 0
				x: step_2_scroller.x - 45
			time: .5
		step_2_sticky_table_header.animate
			properties:
				opacity: 0
				x: step_2_sticky_table_header.x - 45
			time: .5
		step_3_done_button.visible = true
		step_3_form.visible = true
		step_3_form.animate
			properties:
				opacity: 1
				x: step_3_form.originalFrame.x
			time: .5
			delay: .5
		layerSubmitButton.animate
			properties:
				opacity: 1
				x: layerSubmitButton.x - 45
			time: .5
			delay: .5
		#step_1_scroller.sendToBack()
	







form3Filled = false
step_3_form.on Events.Click, ->
	if form3Filled == false
		form3Filled = true
		step_3_data_input.animate
			properties:
				opacity: 1
			time: .5
	else
		run_submit_animation()
		#animateSuccessbanner()
		



layerSubmitButton.centerX = 0

run_submit_animation = () ->
	step_3_rti_skip_button.animate
		properties:
			x: step_3_rti_skip_button.x - 30
			opacity: 0
		time: .5
	
	layerSubmitButton.html = " "
	startSpinng = layerSubmitButton.animate
		properties:
			width: 34
			borderRadius: 25
			borderWidth: 8
		time: .2
	
	s_01_hide = s_01.animate
		properties:
			opacity: 1
			x: s_01.x + 20
		time: 0.4
		delay: 1
	
	s_01_hide.on Events.AnimationEnd, ->
		s_01_done = s_01.animate
			properties:
				opacity: 0
				x: s_01.x - 20
			time: 0.4
			delay: .8
	
		s_01_done.on Events.AnimationEnd, ->
			s_02_show = s_02.animate
				properties:
					opacity: 1
					x: s_02.x + 20
				time: 0.4
				delay: .8
			
			s_02_show.on Events.AnimationEnd, ->
				s_02_done = s_02.animate
					properties:
						opacity: 0
						x: s_02.x - 20
					time: 0.4
					delay: 1

				s_02_done.on Events.AnimationEnd, ->
					s_03_show = s_03.animate
						properties:
							opacity: 1
							x: s_03.x + 20
						time: 0.4
						delay: .3
					
					s_03_show.on Events.AnimationEnd, ->
						s_03_done = s_03.animate
							properties:
								opacity: 0
								x: s_02.x - 20
							time: 0.4
							delay: 1

						s_03_done.on Events.AnimationEnd, ->
							s_04_show = s_04.animate
								properties:
									opacity: 1
									x: s_04.x + 20
								time: 0.4
								delay: 1
							
							s_04_show.on Events.AnimationEnd, ->
								s_04_done = s_04.animate
									properties:
										opacity: 0
										x: s_04.x - 20
									time: 0.4
									delay: .4
								rti_Complete.visible = true
								rti_Complete.bringToFront()
								finishPageAnimation = layerSubmitButton.animate
									properties:
										scale: 0
									time: .4
									delay: 0
									
									
								
								finishPageAnimation.on Events.AnimationEnd, ->
									animateSuccessbanner()
							

	
	startSpinng.on Events.AnimationEnd, ->
		spinSpinSpin()

spinSpinSpin = () ->
	layerSubmitButton.animate
			properties:
				rotation: 360*45
			time: 45


animateSuccessbanner = () ->
	step_pattern_background_new = new Layer
		x: 0, y: 40, width: 1440, height: 44, backgroundColor: "#F5F5F5", opacity: 0
	step_pattern_background_new.originY = 0
	
	step_pattern_background_new.sendToBack()
	
	step_3_form.originY = 0
	step_3_form.animate
		properties:
			opacity: 0
			scaleY: 0
		time: .5
	
	rti_Complete.animate
		properties:
			x: 37
			y: 61
			scale: 2
		time: .8
		delay: .5
	
	step_pattern.animate
		properties:
			opacity: 0
		time: .4
		delay: .5
	
	step_pattern_step_2_text_active.animate
		properties:
			opacity: 0
		time: .4
		delay: .5

	step_pattern_step_3_text_active.animate
		properties:
			opacity: 0
		time: .4
		delay: .5
	
	step_pattern_background_new.animate
		properties:
			opacity: 1
		time: .4
		delay: .5
	
	step_progress_indicator.animate
		properties:
			y: step_progress_indicator.y + 30
		time: .4
		delay: .6
	
	step_pattern_background_new.animate
		properties:
			height: step_pattern_background_new.height + 30
		time: .4
		delay: 0.6
	
	#check_Banner.animate
	#	properties:
	#		scale: 1
	#		opacity: 1
	#	time: .5
	#	delay: 1
	
	finishRTI = rti_Success_Message_Banner.animate
		properties:
			opacity: 1
			x: rti_Success_Message_Banner.x + 40
		time: .5
		delay: 1.2

	print_payslips.visible = true
	step_3_form.originY = 0
	step_3_form.animate
		properties:
			opacity: 0
			scaleY: 0
		time: .5
		delay: .5

	print_payslips.y = print_payslips.y + 400
	print_payslips.animate
		properties:
			opacity: 1
			y: print_payslips.y - 400
		time: .5
		delay: .5
		
	

###################################
###       Animate in Trowser    ###
###################################
ee_list_sticky.on Events.Click, ->
	trowser_header_sticky.animate
		properties:
			y: 0
		time: .75
		curve: "ease-in-out"
	trowser_background.animate
		properties:
			y: 0
		time: .75
		curve: "ease-in-out"
	step_pattern.animate
		properties:
			y: step_pattern.originalFrame.y
		time: .75
		curve: "ease-in-out"