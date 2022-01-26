window.addEventListener('message', function (event) {
    $("#StatusHud #stress").hide()
    let data = event.data
    loadStats = function(){
        $('#shieldval').html(Math.round(data.armour))
        $('#hungerlevel').html(Math.round(data.food))
        $('#waterlevel').html(Math.round(data.thirst))
        $('#stresslevel').html(Math.round(data.stress))
        $('#spavanjelevel').html(Math.round(data.spavanje))
        //     $('#sefBato').hide()
        // }
    }
    if (data.hud && !data.pauseMenu){
        $("body").show();
        if (data.health != -100){
            $('#healtlevel').html(Math.round(data.health))
            if (data.health < 50 ){
                $('#healtlevel').addClass('white')
            }else{
                $('#healtlevel').removeClass('white')
            }
        }else if(data.health == -100){
            $('#healtlevel').html("0")
            $('#healtlevel').addClass('white')
        }
        if(data.hudPosition == 'right'){
            $("#StatusHud").animate({"left": '1.55%', "bottom":'0.5%'},200 );
            $("#tekst").animate({"left": '4.25%', "bottom":'0.5%'},200 );
            $("#kontrole").animate({"left": '1.5%', "top":'30%'},200 );
            $("#naslovKontrole").animate({"left": '3%', "top":'27%'},200 );

        }else{
            $("#StatusHud").animate({"left": '1.25%', "bottom":'20%'},350 );
        }
        loadStats();
        if (data.stress) {
            $("#StatusHud #stress").show() 
        }else if(!data.stress){
            $("#StatusHud #stress").hide()
        }
    }
});
