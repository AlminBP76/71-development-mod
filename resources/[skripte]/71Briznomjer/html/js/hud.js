var speedText = ''

window.addEventListener("message", function(event) {
	var item = event.data

	if (item.ShowHud) {

		s_Rpm = item.CurrentCarRPM
		s_Gear = item.CurrentCarGear
		s_fuelamount = item.CurrentCarFuelAmount
		s_nitro = item.CurrentNitro
		s_displaykmh = item.CurrentDisplayKMH
		s_Handbrake = item.CurrentCarHandbrake
		s_Brake = item.CurrentCarBrake
		s_Speed = item.CurrentCarSpeed
		s_UnitDistance = item.CurrentUnitDistance

		if (s_UnitDistance == "KMH"){
			$(".unitdisplay").html("KM/H");
		}
		
		if (item.seatbelt) {
			$(".seatbelt-info img").attr('src', './images/seatbelt-on.png');
		} else {
			$(".seatbelt-info img").attr('src', './images/seatbelt.png');
		}

		if (s_nitro <= 0) {
			$("#nitroshow").css("display","none")
			$(".nitrodisplay").css("display","none")
		} else {	
			$("#nitroshow").css("display","block")						
			$(".nitrodisplay").css("display","block")
			$("#nitroshow").attr("data-value", s_nitro/10)
		}

		// Vehicle RPM display
		$("#rpmshow").attr("data-value", s_Rpm.toFixed(2))

		// Vehicle Gear display
		if(s_Gear == 0) {
			$(".geardisplay span").html("R")
			$(".geardisplay").attr("style", "color: rgba(255,255,255,0.5)border-color:rgba(255,255,255,0.5)")
		} else {
			$(".geardisplay span").html(s_Gear)
			if(s_Rpm > 7.5) {
				$(".geardisplay").attr("style", "color: rgba(235,5,61,0.5)border-color:rgba(235,5,61,.5)")
			} else {
				$(".geardisplay").removeAttr("style")
			}
		}

		// Vehicle Speed Display
		if (s_Speed > 999) {
			s_Speed = 999
		} else if(s_Speed >= 100) {
			var tmpSpeed = Math.floor(s_Speed) + ''
			speedText = '<span class="int1">' + tmpSpeed.substr(0, 1) + '</span><span class="int2">' + tmpSpeed.substr(1, 1) + '</span><span class="int3">' + tmpSpeed.substr(2, 1) + '</span>'
		} else if(s_Speed > 9 && s_Speed <= 99) {
			var tmpSpeed = Math.floor(s_Speed) + ''
			speedText = '<span class="gray int1">0</span><span class="int2">' + tmpSpeed.substr(0, 1) + '</span><span class="int3">' + tmpSpeed.substr(1, 1) + '</span>'
		} else if(s_Speed > 0 && s_Speed <= 9) {
			speedText = '<span class="gray int1">0</span><span class="gray int2">0</span><span class="int3">' + Math.floor(s_Speed) + '</span>'
		} else {
			speedText = '<span class="gray int1">0</span><span class="gray int2">0</span><span class="gray int3">0</span>'
		}

		// Handbrake
		if(s_Handbrake) {
			$(".handbrake").html("HBK")
		} else {
			$(".handbrake").html('<span class="gray">HBK</span>')
		}

		if(s_displaykmh!= 0) {
			$(".displaykmh").html(("000000" + s_displaykmh).slice(-6))
		}

		if(s_fuelamount != 0) {
			$(".fuel").html('GAS<span class="gray" style="margin-left: 5px">'+s_fuelamount+'</span>')
		}

		// Brake ABS
		if(s_Brake > 0) {
			$(".abs").html("ABS")
		} else {
			$(".abs").html('<span class="gray">ABS</span>')
		}

		// Display speed and container
		$(".speeddisplay").html(speedText)
		$("#container").fadeIn(500)

	} else if (item.HideHud) {
		// Hide GUI
		$("#container").fadeOut(500)
	}
})