$(document).keyup(function(e) {
	if (e.key === "Escape") {
	  $('.container-fluid').css('display', 'none');
	  $.post('http://harun_rentica/harunskloni', JSON.stringify({}));
 }
});
$(document).ready(function() {
	window.addEventListener('message', function(event) {
		var item = event.data;
		if (item.ativa == true) {
			$('.container-fluid').css('display', 'block');
		} else if (item.ativa == false) {
			$('.container-fluid').css('display', 'none');
		}
	});

	$("#button1").click(function() {
		$.post('http://harun_rentica/button1', JSON.stringify({}));
		2
		$(".container-fluid").fadeOut();
		$.post('http://harun_rentica/harunskloni', JSON.stringify({}));

	});

	$("#button2").click(function() {
		$.post('http://harun_rentica/button2', JSON.stringify({}));
		2
		$(".container-fluid").fadeOut();
		$.post('http://harun_rentica/harunskloni', JSON.stringify({}));

	});

	$("#button3").click(function() {
		$.post('http://harun_rentica/button3', JSON.stringify({}));
		2
		$(".container-fluid").fadeOut();
		$.post('http://harun_rentica/harunskloni', JSON.stringify({}));

	});



})

let scale = 0;
const cards = Array.from(document.getElementsByClassName("job"));
const inner = document.querySelector(".inner");

function slideAndScale() {
cards.map((card, i) => {
	card.setAttribute("data-scale", i + scale);
	inner.style.transform = "translateX(" + scale * 8.5 + "em)";
});
}


$('.button1').hover(
	function() {
		$(".slikaauta1").show('0')
	}, function() {
		$(".slikaauta1").hide('5')
	}
  );

  $('.button1').hover(
	function() {
		$(".cjena").show('5')
	}, function() {
		$(".cjena").hide('5')
	}
  );

  $('.button2').hover(
	function() {
		$(".slikaauta2").show('0')
	}, function() {
		$(".slikaauta2").hide('5')
	}
  );
  $('.button2').hover(
	function() {
		$(".cjena2").show('5')
	}, function() {
		$(".cjena2").hide('5')
	}
  );
  $('.button3').hover(
	function() {
		$(".slikaauta3").show('0')
	}, function() {
		$(".slikaauta3").hide('5')
	}
  );
  $('.button3').hover(
	function() {
		$(".cjena3").show('5')
	}, function() {
		$(".cjena3").hide('5')
	}
  );
(function init() {
slideAndScale();
cards.map((card, i) => {
	card.addEventListener("click", () => {
		const id = card.getAttribute("data-scale");
		if (id !== 2) {
			scale -= id - 2;
			slideAndScale();
		}
	}, false);
});
})();

