var selectedWindow = "none"
var sourceID = 0
var targetID = 0
var sourceName = ""
var targetName = ""
var targetNameSeller = ""
var vehicleModel = ""
var plateNumber = ""
var date = ""
var description = ""
var price = 0

window.addEventListener('message', function(event) {
	switch (event.data.action) {
		case 'openContractSeller':
			var popup = new Audio('popup.mp3');
			popup.volume = 0.4;
			popup.play();

			$("#source_name").html(event.data.source_playername);
			$("#target_name").html(event.data.target_playername);
			$("#vehicle_model").html(event.data.model);
			$("#plate_number").html(event.data.plate);
			$("#date").html(event.data.date);
			$("#description").html(event.data.description);
			$("#price").html(event.data.price);

			sourceID = event.data.sourceID;
			targetID = event.data.targetID;
			sourceName = event.data.source_playername;
			targetName = event.data.target_playername;
			vehicleModel = event.data.model;
			plateNumber = event.data.plate;
			date = event.data.date;
			description = event.data.description;
			price = event.data.price;

			$("#signtest").html("");
			$("#signtest2").html("");
			$("#signContract1").attr("disabled", false);

			$("#signContract1").removeClass('d-none');
			$("#signContract2").addClass('d-none');

			$(".contract1").fadeIn();

			selectedWindow = "openContractSeller"
			break
		case 'openContractInfo':
			var popup = new Audio('popup.mp3');
			popup.volume = 0.4;
			popup.play();

			$(".vehicleInformation").fadeIn();

			selectedWindow = "openContractInfo"
			break
		case 'openContractOnBuyer':
			var popup = new Audio('popup.mp3');
			popup.volume = 0.4;
			popup.play();

			$("#source_name").html(event.data.source_playername);
			$("#target_name").html(event.data.target_playername);
			$("#vehicle_model").html(event.data.model);
			$("#plate_number").html(event.data.plate);
			$("#date").html(event.data.date);
			$("#description").html(event.data.description);
			$("#price").html(event.data.price);

			sourceNameSeller = event.data.source_playername;
			targetNameSeller = event.data.target_playername;
			targetIDSeller = event.data.targetID;
			sourceIDSeller = event.data.sourceID;
			plateNumberSeller = event.data.plate;
			modelSeller = event.data.model;
			vehicle_price = event.data.price;

			$("#signtest").html("");
			$("#signtest2").html("");
			$("#signContract2").attr("disabled", false);

			var sellerSignatureP = new Vara("#signtest","SatisfySL.json", [{
				text: event.data.source_playername,
				fontSize: 18, 
				strokeWidth: 2,
				color: "#000",
				id: "",
				duration: 0,
				textAlign: "center",
				x: 0,
				y: 0, 
				fromCurrentPosition:{ 
					x: true,
					y: true,
				},
				autoAnimation: true,
				queued: true,
				delay: 0,
				letterSpacing: 0
			}]);

			$("#signContract1").addClass('d-none');
			$("#signContract2").removeClass('d-none');

			$(".contract1").fadeIn();

			selectedWindow = "openContractOnBuyer"
			break
	}
});

// Button Actions
$(document).on('click', '#submitContractInfo', function() {
	var vehicle_description = $("#vehicle_description").val();
	var vehicle_price = $("#vehicle_price").val();

	if(!vehicle_description || !vehicle_price) {
		$.post('http://okokContract/action', JSON.stringify({
			action: "missingInfo",
		}));
	} else {
		$(".vehicleInformation").fadeOut();

		$.post('http://okokContract/action', JSON.stringify({
			action: "submitContractInfo",
			vehicle_description: vehicle_description,
			vehicle_price: vehicle_price,
		}));

		setTimeout(function() {
			$("#vehicle_description").val("");
			$("#vehicle_price").val("");
		}, 400);
	}
})

$(document).on('click', "#signContract1", function() {
	var accept = new Audio('accept.mp3');
	accept.volume = 0.5;
	accept.play();

	var sellerSignature = new Vara("#signtest","SatisfySL.json", [{
		text: sourceName,
		fontSize: 18, 
		strokeWidth: 2,
		color: "#000",
		id: "",
		duration: 3000,
		textAlign: "center",
		x: 0,
		y: 0, 
		fromCurrentPosition:{ 
			x: true,
			y: true,
		},
		autoAnimation: true,
		queued: true,
		delay: 0,
		letterSpacing: 0
	}]);

	$("#signContract1").attr("disabled", true);

	setTimeout(function(){
		$.post('https://okokContract/action', JSON.stringify({
			action: "signContract1",
			sourceID: sourceID,
			targetID: targetID,
			sourceName: sourceName,
			targetName: targetName,
			vehicleModel: vehicleModel,
			plateNumber: plateNumber,
			date: date,
			description: description,
			price: price,
		}));

		$(".contract1").fadeOut();
	}, 6000);
});

$(document).on('click', "#signContract2", function() {
	var accept = new Audio('accept.mp3');
	accept.volume = 0.5;
	accept.play();

	//$(".mainmenu").fadeOut();

	var buyerSignature = new Vara("#signtest2","SatisfySL.json", [{
		text: targetNameSeller,
		fontSize: 18, 
		strokeWidth: 2,
		color: "#000",
		id: "",
		duration: 3000,
		textAlign: "center",
		x: 0,
		y: 0, 
		fromCurrentPosition:{ 
			x: true,
			y: true,
		},
		autoAnimation: true,
		queued: true,
		delay: 0,
		letterSpacing: 0
	}]);

	$("#signContract2").attr("disabled", true);

	setTimeout(function(){
		$.post('https://okokContract/action', JSON.stringify({
			action: "signContract2",
			targetIDSeller: targetIDSeller,
			plateNumberSeller: plateNumberSeller,
			sourceIDSeller: sourceIDSeller,
			modelSeller: modelSeller,
			sourceNameSeller: sourceNameSeller,
			targetNameSeller: targetNameSeller,
			vehicle_price: vehicle_price,
		}));
		
		$(".contract1").fadeOut();
	}, 6000);
});

$(document).on('click', "#closeVehicleInformation", function() {
	var popuprev = new Audio('popupreverse.mp3');
	popuprev.volume = 0.4;
	popuprev.play();

	$(".vehicleInformation").fadeOut();

	setTimeout(function() {
		$("#vehicle_description").val("");
		$("#vehicle_price").val("");

		$.post('https://okokContract/action', JSON.stringify({
			action: "close",
		}));
	}, 400);
});

// Close ESC Key
$(document).ready(function() {
	document.onkeyup = function(data) {
		if (data.which == 27) {
			var popuprev = new Audio('popupreverse.mp3');
			popuprev.volume = 0.4;
			popuprev.play();
			switch (selectedWindow) {
				case 'openContractSeller':
					$(".contract1").fadeOut();

					$.post('https://okokContract/action', JSON.stringify({
						action: "close",
					}));
					break
				case 'openContractInfo':
					$(".vehicleInformation").fadeOut();

					setTimeout(function() {
						$("#vehicle_description").val("");
						$("#vehicle_price").val("");
					}, 400);

					$.post('https://okokContract/action', JSON.stringify({
						action: "close",
					}));
					break
				case 'openContractOnBuyer':
					$(".contract1").fadeOut();

				    $.post('https://okokContract/action', JSON.stringify({
				        action: "close",
				    }));
					break
			}
		}
	};
});