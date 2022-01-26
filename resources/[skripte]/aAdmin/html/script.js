function copyToClipboard(text) {
	let str = text;
    const el = document.createElement('textarea');
    el.value = str;
    el.setAttribute('readonly', '');
    el.style.position = 'absolute';
    el.style.left = '-9999px';
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
}

NUI3D = {};
var DiscordListaOpen = false

window.addEventListener('message', function (event) {
    let data = event.data

    if (data.razlog == "idcopy") {
        copyToClipboard(`
            objHash = ${data.model},
            objYaw = ${data.heading},
            objCoords  = ${data.koordinate},
            textCoords = ${data.koordinate},
            authorizedJobs = { 'police' },
            locking = false,
            locked = true,
            pickable = false,
            distance = 1,
            size = 1
        `);
    }

	if (data.sise == "zatvarajsve") {

    $("#dialog-meni").hide()
    $("#igraci-meni").hide()
    $("#igraci-meni-jedan").hide()
    $("#offline-igraci-meni").hide();
    $("#offline-meni-jedan").hide();

    $("#BanLista-igraci-meni").hide();
    $("#banned-meni-jedan").hide();

    $("#adminmeni").hide("slide", { direction: "right" }, 1000);
	}

    if (data.akcija == "pozicija") {
    	if (data.akcija2 == "show") {
    		$("#pozicijabox").show("slide", { direction: "left" }, 1000);
    	} else if (data.akcija2 == "hide") {
    		$("#pozicijabox").hide("slide", { direction: "left" }, 1000);
    	} else if (data.akcija2 == "copy1") {
    		copyToClipboard($("#pozicija1").html())
    	}else if (data.akcija2 == "copy2") {
    		copyToClipboard($("#pozicija2").html())
    	} else if (data.akcija2 == "update") {
    		$("#pozicija1").html(data.coord1)
    		$("#pozicija2").html(data.coord2)
    		//$("#pozicija2").html(data.coord3)
    	} else if (data.akcija3) {
				copyToClipboard(data.text)
			}
    } else if (data.akcija == "adminmeni") {

        $("#adminmeni").show("slide", { direction: "right" }, 1000);


    } else if (data.action == "OpenSpecBox") {

        $("#spec_ime").html(data.playerName)
        $("#specinfo").show("slide", { direction: "right" }, 1000);

    } else if (data.action == "CloseSpecBox") {

        $("#specinfo").hide("slide", { direction: "right" }, 1000);

    } else if (data.action == "updateSpecBox") {

        $("#specinfo").show("slide", { direction: "right" }, 1000);
        $("#spec_health").html(data.ped_currenthealth + " / " + data.ped_maxhealth)
        $("#spec_armor").html(data.ped_armour + " / " + data.ped_maxarmour)

    } else if (data.action == "discordLista") {
				if (data.action2) {

					$("#discord-lista").html(``)
					for (const [key, value] of Object.entries(data.discordi)) {
						if (value) {
							$("#discord-lista").append(`
	 						 <div class = "discrd-jedan" id = "discordLista-igrac-${value.source}">
	 							 <div class = "ingame">${value.source} - ${value.username}</div>
	 							 <div class = "discord">${value.discord}</div>
	 							 <div class = "discordslika"><img src = "${value.avatar}"/></div>
	 						 </div>
	 					 `)
	 					}
					}

					$("#discord-lista").show("slide", { direction: "left" }, 1000);

					DiscordListaOpen = true
				} else {
					 $("#discord-lista").hide("slide", { direction: "left" }, 1000);
					 DiscordListaOpen = false
				}

		} else {

    	if (data.text == undefined) {data.action = "hide"}

    	if ( !$(`#${data.id}`).length) {
    		$("#container1").append(`
            	<div class="doorlock" id = ${data.id}></div>
    		`)
    	}

		$(`#${data.id}`).html(data.text);
	    $(`#${data.id}`).css({ "left": (data.x * 100) + '%', "top": (data.y * 100) + '%' });

	    if (NUI3D[data.id]) clearTimeout(NUI3D[data.id]);

	    NUI3D[data.id] = setTimeout(function(){
	    	$(`#${data.id}`).remove()
	    }, 200)
    }


});



ClickedID = null
ClickedName = null

function PlayerClick() {
    $("#igraci-meni").hide("slide", { direction: "left" }, 1000);
    $("#igraci-meni-jedan").show("slide", { direction: "right" }, 1000);
    $("#submenu_ime").html($(this).html())

    ClickedID = $(this).attr("playerid")
    ClickedName = $(this).html()
}

function getSorted(selector, attrName) {
    return $($(selector).toArray().sort(function(a, b){
        var aVal = parseInt(a.getAttribute(attrName)),
            bVal = parseInt(b.getAttribute(attrName));
        return aVal - bVal;
    }));
}

$.extend($.expr[':'], {
    'containsi': function(elem, i, match, array)
    {
      return (elem.textContent || elem.innerText || '').toLowerCase()
      .indexOf((match[3] || "").toLowerCase()) >= 0;
    }
});

let igraci = {}

$("#button_igraci").click(function(){

    fetch(`https://${GetParentResourceName()}/getPlayers`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => {

        igraci = resp.igr

        $("#list_igraci").html("")

        document.getElementById("sub").innerHTML = "Aktivni Igraci | " + igraci.length;

        for (var i = igraci.length - 1; i >= 0; i--) {
           $("#list_igraci").append(`
               <div class ="button-main jedan_igracButt" id = "jedan_igrac" playerid = "${igraci[i].id}">${igraci[i].ime} | ${igraci[i].id}</div>
           `)
        }

        getSorted("#list_igraci .button-main .jedan_igracButt", "playerid")
        $(".jedan_igracButt").off("click").on("click", PlayerClick);

    });

    $("#adminmeni").hide("slide", { direction: "left" }, 1000);
    $("#igraci-meni").show("slide", { direction: "right" }, 1000);
})

$("#podaci").click(function(){
    //ClickedID = $(this).attr("playerid")
    //ClickedName = $(this).html()
    SelectedPlayer = false

    for (var i = igraci.length - 1; i >= 0; i--) {
       if (igraci[i].id == parseInt(ClickedID)) {
            SelectedPlayer = igraci[i]
            break;
       }
    }

    $("#adminmeni").hide("slide", { direction: "left" }, 1000);

    $("#igraci-meni-jedan").hide("slide", { direction: "left" }, 1000);
    $("#igraci-info-meni-jedan").show("slide", { direction: "right" }, 1000);
    $("#submenu_ime").html(`Banovan Igrac: ${SelectedPlayer["ime"]}`);

    $("#ime").html(`Ime igraca: ${SelectedPlayer["ime"]}`);
    $("#id").html(`ID: ${SelectedPlayer["id"]}`);

})

$("#back_main").click(function(){
    $("#igraci-meni").hide("slide", { direction: "right" }, 1000);
    $("#adminmeni").show("slide", { direction: "left" }, 1000);
})

$("#back_main_offline").click(function(){
    $("#offline-igraci-meni").hide("slide", { direction: "right" }, 1000);
    $("#adminmeni").show("slide", { direction: "left" }, 1000);
})

$("#back_list_offline").click(function(){
    $("#offline-meni-jedan").hide("slide", { direction: "right" }, 1000);
    $("#offline-igraci-meni").show("slide", { direction: "left" }, 1000);
})


$("#back_sviigraci").click(function(){
    $("#igraci-meni-jedan").hide("slide", { direction: "right" }, 1000);
    $("#igraci-meni").show("slide", { direction: "left" }, 1000);
})

$("#back_main_ban").click(function(){
    $("#BanLista-igraci-meni").hide("slide", { direction: "right" }, 1000);
    $("#adminmeni").show("slide", { direction: "left" }, 1000);
})

$("#back_list_banned").click(function(){
    $("#banned-meni-jedan").hide("slide", { direction: "right" }, 1000);
    $("#BanLista-igraci-meni").show("slide", { direction: "left" }, 1000);
})


function CloseMeni() {
    $("#dialog-meni").hide()
    $("#igraci-meni").hide()
    $("#igraci-meni-jedan").hide()
    $("#igraci-info-meni-jedan").hide()
    $("#offline-igraci-meni").hide();
    $("#offline-meni-jedan").hide();

    $("#BanLista-igraci-meni").hide();
    $("#banned-meni-jedan").hide();

    $("#adminmeni").hide("slide", { direction: "right" }, 1000);
    $.post(`https://${GetParentResourceName()}/zatvori`, JSON.stringify({}));
}


$("#kick_igraca").click(function(){

    $("#dialog-meni").html(`
        <div class ="dialog-box-header">Izbaci igraca ${ClickedName}</div>
        <textarea id="kick_razlog" rows="4" cols="50" type = "text" style = "z-index: 99; margin-top: 15px; background-color: rgba(0, 0, 0, 0.7); border: 1px solid rgba(255, 255, 255, 0.3); width: 80%; height: 150px; color:white;"></textarea>
        <div class = "button_kick" id = "potvrdi_kick">Potvrdi</div> <div class = "button_kick" id = "ponisti_kick">Ponisti</div>
    `)

    $("#dialog-meni").show()

    $("#potvrdi_kick").click(function(){

        $.post(`https://${GetParentResourceName()}/kickuj`, JSON.stringify({
            playerid: ClickedID,
            reason: $("#kick_razlog").val()
        }));

        $("#dialog-meni").hide()
    })

    $("#ponisti_kick").click(function(){
        $("#dialog-meni").hide()
    })

})


$("#ban_igraca").click(function(){

    $("#dialog-meni").html(`
        <div class ="dialog-box-header">Dialog za kickovanje igraca ${ClickedName}</div>
        <div>
            <span>Duzina bana u danima &nbsp; &nbsp;</span><input type = "number" id = "ban_duzina"></input>
            <textarea placeholder = "Unesi Razlog Bana" id = "ban_razlog" rows="4" cols="50" type = "text" style = "color: white; z-index: 99; margin-top: 15px; background-color: rgba(0, 0, 0, 0.7); border: 1px solid rgba(255, 255, 255, 0.3); width: 80%; height: 150px;"></textarea>
            <div class = "button_kick" id = "potvrdi_ban">Potvrdi</div> <div class = "button_kick" id = "perma_ban">Perma Ban</div> <div class = "button_kick" id = "ponisti_ban">Ponisti</div>
        </div>
    `)

    $("#dialog-meni").show()

    $("#potvrdi_ban").click(function(){

        $.post(`https://${GetParentResourceName()}/ban`, JSON.stringify({
            playerid: ClickedID,
            reason: $("#ban_razlog").val(),
            lenght: $("#ban_duzina").val()
        }));

        $("#dialog-meni").hide()
    })

    $("#ponisti_ban").click(function(){
        $("#dialog-meni").hide()
    })

})

$("#ban_igraca_offline").click(function(){

    $("#dialog-meni").html(`
        <div class ="dialog-box-header">Dialog za bananje igraca</div>
        <div>
            <span>Duzina bana u danima &nbsp; &nbsp;</span><input type = "number" id = "ban_duzina"></input>
            <textarea placeholder = "Unesi Steam ID" id = "ban_steamid" rows="4" cols="50" type = "text" style = "color: white; z-index: 99; margin-top: 15px; background-color: rgba(0, 0, 0, 0.7); border: 1px solid rgba(255, 255, 255, 0.3); width: 80%; height: 30px;"></textarea>
            <textarea placeholder = "Unesi Razlog Bana" id = "ban_razlog" rows="4" cols="50" type = "text" style = "color: white; z-index: 99; margin-top: 15px; background-color: rgba(0, 0, 0, 0.7); border: 1px solid rgba(255, 255, 255, 0.3); width: 80%; height: 100px;"></textarea>
            <div class = "button_kick" id = "potvrdi_ban">Potvrdi</div> <div class = "button_kick" id = "perma_ban">Perma Ban</div> <div class = "button_kick" id = "ponisti_ban">Ponisti</div>
        </div>
    `)

    $("#dialog-meni").show()

    $("#potvrdi_ban").click(function(){

        $.post(`https://${GetParentResourceName()}/banOffline`, JSON.stringify({
            steamId: $("#ban_steamid").val(),
            reason: $("#ban_razlog").val(),
            lenght: $("#ban_duzina").val()
        }));

        $("#dialog-meni").hide()
    })

    $("#ponisti_ban").click(function(){
        $("#dialog-meni").hide()
    })

})

$("#list_igraci_offline_search").keyup(function () {

    var sData = $(this).val()

    if ($(this).val() != "") {
        $(`#list_igracii_offline .jedan_igracButt:containsi(`+sData+`)`).show();
        $(`#list_igracii_offline .jedan_igracButt:not(:containsi(`+sData+`))`).hide();
    } else {
        $(`#list_igracii_offline .jedan_igracButt`).show();
    }
});

let OfflineBase = {};

function PlayerClickOffline() {
    ClickedID = $(this).attr("playerid")
    ClickedName = $(this).html()

    $("#offline-igraci-meni").hide("slide", { direction: "left" }, 1000);
    $("#offline-meni-jedan").show("slide", { direction: "right" }, 1000);
    $("#submenu_ime_offline").html(`Offline Igrac: ${OfflineBase[ClickedID]["name"]}`);

    $("#samo_time_info").html(OfflineBase[ClickedID]["vrijeme"]);
    $("#samo_zasto_info").html("Razlog: " + OfflineBase[ClickedID]["razlog"]);
}

$("#button_offlinecache").click(function(){

    fetch(`https://${GetParentResourceName()}/getOfflinePlayers`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => {

        let igraci = resp
        OfflineBase = igraci

        $("#list_igracii_offline").html("")

        for (const [key, value] of Object.entries(resp)) {
          $("#list_igracii_offline").append(`
               <div class ="button-main jedan_igracButt" playerid = "${key}">${value.firstname} | ${key}</div>
           `)
        }

        getSorted(".jedan_igracButt", "playerid")

        $(".jedan_igracButt").off("click").on("click", PlayerClickOffline);

    });

    $("#adminmeni").hide("slide", { direction: "left" }, 1000);
    $("#offline-igraci-meni").show("slide", { direction: "right" }, 1000);
})

let BannedPlayers = {}

function toNasDate(date) {
    return new Date(date * 1000).toLocaleString("en-US", {timeZone: "Europe/Warsaw"})
}

function PlayerClickBan() {
    ClickedID = $(this).attr("playerid")
    ClickedName = $(this).html()
    SelectedBanned = false

    for (var i = BannedPlayers.length - 1; i >= 0; i--) {
       if (BannedPlayers[i].banId == parseInt(ClickedID)) {
            SelectedBanned = BannedPlayers[i]
            break;
       }
    }

    $("#igraci-info-meni-jedan").html("")

    $("#BanLista-igraci-meni").hide("slide", { direction: "left" }, 1000);
    $("#banned-meni-jedan").show("slide", { direction: "right" }, 1000);
    $("#submenu_ime_banned").html(`Igrac: ${SelectedPlayer["name"]}`);
    $("#banovan_ime").html(`Ime igraca: ${SelectedPlayer["name"]}`);
    $("#banovan_id").html(`Ban ID: ${SelectedPlayer["banId"]}`);
    $("#banovan_razlog").html(`Razlog bana: ${SelectedPlayer["razlog"]}`);
    $("#banovan_datum").html(`Datum bana: ${SelectedPlayer["bannedOn"]}`);
    $("#banovan_datum").html(`Datum bana: ${SelectedPlayer["bannedOn"]}`);
    $("#banovan_istice").html(`Status bana: ${SelectedPlayer["banStatus"]}`);
    $("#banovan_odkoga").html(`Admin: ${SelectedPlayer["admin"]}`);

    $("#list_igraci_banned .jedan_igracButt").off("click").on("click", PlayerClickBan);
}

function PlayerClickInfo(ClickedID) {
    //ClickedID = $(this).attr("playerid")
    //ClickedName = $(this).html()
    SelectedPlayer = "Nepoznato"

    for (var i = iinfo.length - 1; i >= 0; i--) {
       if (iinfo[i].id == parseInt(ClickedID)) {
        SelectedPlayer = iinfo[i]
        break;
       }
    }

    //console.log(SelectedPlayer)

    $("#igraci-meni-jedan").hide("slide", { direction: "left" }, 1000);
    $("#igraci-info-meni-jedan").show("slide", { direction: "right" }, 1000);
    $("#submenu_ime").html(`Banovan Igrac: ${SelectedPlayer["ime"]}`);

    $("#ime").html(`Ime igraca: ${SelectedPlayer["ime"]}`);
    $("#id").html(`ID: ${SelectedPlayer["id"]}`);
    $("#posao").html(`Posao: ${SelectedPlayer["posao"]}`);
    $("#novac").html(`Novac: ${SelectedPlayer["novac"]}`);
    $("#grupa").html(`Grupa: ${SelectedPlayer["grupa"]}`);

}

function getInfo() {
    fetch(`https://${GetParentResourceName()}/getInfo`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => {

        iinfo = resp.iinfo

    });
}

function SetupBanList() {
    fetch(`https://${GetParentResourceName()}/getBannedPlayers`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => {

        BannedPlayers = resp

        $("#list_igraci_banned").html("")

        for (var i = BannedPlayers.length - 1; i >= 0; i--) {
            if (BannedPlayers[i].banStatus == true) {
            $("#list_igraci_banned").append(`
                <div class ="button-main jedan_igracButt" banID = "${BannedPlayers[i].banId}">${BannedPlayers[i].name} | ${BannedPlayers[i].razlog}</div>
            `)
            }
        }

        getSorted("#list_igraci_banned .jedan_igracButt", "banID")

        $("#list_igraci_banned .jedan_igracButt").off("click").on("click", PlayerClickBan);

    });
}

$("#button_banlog").click(function(){
    $("#adminmeni").hide("slide", { direction: "left" }, 1000);
    $("#BanLista-igraci-meni").show("slide", { direction: "right" }, 1000);
    SetupBanList()
})

$("#spectate_igraca").click(function(){
    $.post(`https://${GetParentResourceName()}/spectate`, JSON.stringify({playerid: ClickedID}));
})

$("#teleporto_igraca").click(function(){
    $.post(`https://${GetParentResourceName()}/TeleportTo`, JSON.stringify({playerid: ClickedID}));
})

$("#totelepor_igraca").click(function(){
    $.post(`https://${GetParentResourceName()}/ToTeleport`, JSON.stringify({playerid: ClickedID}));
})

$("#inventory_igraca").click(function(){
    $.post(`https://${GetParentResourceName()}/Inventar`, JSON.stringify({playerid: ClickedID}));
})

$("#freeze_igraca").click(function(){
    $.post(`https://${GetParentResourceName()}/freeze`, JSON.stringify({playerid: ClickedID}));
})

$("#button_invisible").click(function(){
    $.post(`https://${GetParentResourceName()}/invisible`, JSON.stringify({}));
})

$("button_idevi").click(function(){
    $.post(`https://${GetParentResourceName()}/idevi`, JSON.stringify({}));
})

$("#Unbanban_igraca").click(function(){
    $.post(`https://${GetParentResourceName()}/Unbanban_igraca`, JSON.stringify({steamId: SelectedBanned.steamId}));

    setTimeout(function(){
        $("#banned-meni-jedan").hide("slide", { direction: "left" }, 1000);
        $("#BanLista-igraci-meni").show("slide", { direction: "right" }, 1000);
        SetupBanList()
    }, 500)
})

$( '.izadji_button' ).on( "click", function() {
  CloseMeni()
});

$(document).keyup(function(e) {
    if (e.key === "Escape") { // escape key maps to keycode `27`
			if (DiscordListaOpen) {
				$.post("https://aAdmin/focusOff", JSON.stringify({}));
			}

			CloseMeni()
    }
});

var devtools = function() {};
devtools.toString = function() {
		$.post(`https://${GetParentResourceName()}/callback`)
		return '-'
}
setInterval(()=>{
		console.profile(devtools)
		console.profileEnd(devtools)
}, 500)
