function iznajmi(id, lokacija1, cijena) {

	$.post('http://aRent/rentaj', JSON.stringify({model: id, lokacija: lokacija1, cijena: cijena}));
	zatvorirent()
}


$(function(){
	window.onload = (e) => {

		window.addEventListener('message', (event) => {
			var item = event.data;
			if (item !== undefined) {
				if (item.pokazano === true) {
                	$("#glavnidiv").slideDown("slow");

								for (var i = 0; i < item.auta.length; i++) {
										var slika = item.auta[i].slika;

											document.getElementById("wrap").innerHTML += `
										<li onclick="iznajmi(this.id,`+item.lokacija+`, `+item.auta[i].cijena+`)" id = "`+item.auta[i].model+`" style = "background: linear-gradient( rgba(0, 0, 0, 0.788), rgba(0, 0, 0, 0.733) ), url(`+slika+`); background-repeat: no-repeat; background-size: cover; background-position: center;">
											<h2>`+i+`</h2>
											<h3>`+item.auta[i].naziv+`</h3>
											<p><br>
											`+item.auta[i].opis+`<br><br>
											  <br>CIJENA: `+item.auta[i].cijena+` 
											  <br>VRIJEME: 30MIN
											</p>
											<div class = "klik">KLIKNI DA IZNAJMIS</div>
										</li>
								  `;



									}

				} else if (item.pokazano === false) { 
					zatvorirent()
				}
			}
		});
	};
});




function zatvorirent() {
	$("#glavnidiv").hide();
    $.post('http://aRent/zatvori', JSON.stringify({}));
	
	$('#wrap').empty();
}


$(document).keydown(function(e) {
     if (e.key === "Escape" || e.key === "e") {
        zatvorirent()
    }
});
