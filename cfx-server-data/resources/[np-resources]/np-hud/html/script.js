var dogalgaz, db, wind, ping, ampul, dollar, yuzme, gym, harness, cruise, gpu, nos
var time = false
var compass = true
var yamert = false 

var setOxyOnOff = true
var setStressOnOff = true
var setHealOnOff = false
var setArmorOnOff = false
var setFoodOnOff = false
var setWateronOff = false

let SetDefaultMap = false
let SetOutline = true

let SetHealthAmount = 95;
let SetArmorAmount = 95;
let SetFoodAmount = 95;
let SetWaterAmount = 95;
let SetSpeedFPS = 500;
let SetCompassFPS = 15;

window.addEventListener('message', function(event){
    data = event.data;


    if (data.action == "open") {
        $(".menu").fadeIn(500);
    }

    if (data.action == "SetSettings") {

        document.getElementById('healthValue').value = data.SetHealthValue;
        document.getElementById('armorValue').value = data.SetArmorValue;
        document.getElementById('hungerValue').value = data.SetHungerValue;
        document.getElementById('thirstValue').value = data.SetThirstValue;

        SetHealthAmount = data.SetHealthValue;
        SetArmorAmount = data.SetArmorValue;
        SetFoodAmount = data.SetHungerValue;
        SetWaterAmount = data.SetThirstValue;

        if (data.SetHealthToggled == 0) {
            $("#healthInput").attr("checked", true);
            setHealOnOff = false
        } else if (data.SetHealthToggled == 1) {
            $("#healthInput").attr("checked", false);
            setHealOnOff = true
        }

        if (data.SetArmorToggled == 0) {
            $("#armorInput").attr("checked", true);
            setArmorOnOff = false
        } else if (data.SetArmorToggled == 1) {
            $("#armorInput").attr("checked", false);
            setArmorOnOff = true
        }

        if (data.SetHungerToggled == 0) {
            $("#foodInput").attr("checked", true);
            setFoodOnOff = false
        } else if (data.SetHungerToggled == 1) {
            $("#foodInput").attr("checked", false);
            setFoodOnOff = true
        }

        if (data.SetThirstToggled == 0) {
            $("#thirstInput").attr("checked", true);
            setWateronOff = false
        } else if (data.SetThirstToggled == 1) {
            $("#thirstInput").attr("checked", false);
            setWateronOff = true
        }

        if (data.SetSpeedFPSValue == 500) {
            $('.speedmeterOptionBtn').html('15')
            SetSpeedFPS = 500
        } else if (data.SetSpeedFPSValue == 250) {
            $('.speedmeterOptionBtn').html('35')
            SetSpeedFPS = 250
        } else if (data.SetSpeedFPSValue == 50) {  
            $('.speedmeterOptionBtn').html('60')
            SetSpeedFPS = 50
        }

        if (data.SetCompassFPSValue == 50) {
            $('.compassOptionBtn').html('15')
            SetCompassFPS = 50
        } else if (data.SetCompassFPSValue == 15) {
            $('.compassOptionBtn').html('35')
            SetCompassFPS = 15
        } else if (data.SetCompassFPSValue == 1) {  
            $('.compassOptionBtn').html('60')
            SetCompassFPS = 1
        }

        if (data.SetDefaultMapToggled == 0) {
            $("#defaultmap").attr("checked", false);
            SetDefaultMap = false
        } else if (data.SetDefaultMapToggled == 1) {
            $("#defaultmap").attr("checked", true);
            SetDefaultMap = true
        }

        if (data.SetOutlineToggled == 0) {
            $("#outlinemap").attr("checked", false);
            SetOutline = false
        } else if (data.SetOutlineToggled == 1) {
            $("#outlinemap").attr("checked", true);
            SetOutline = true
        }
    }

    if (data.action == "carhud") {

        if (data.bar5 == true) {
            $(".mapborder").fadeIn();
        } else if (data.bar5 == false) {
            $(".mapborder").fadeOut();
        }
        
        if (data.show == true) {

            if (data.mil == 0) {
                $("#cambardak3").css("display", "none");
            } else if (data.mil > 0) {
                $("#cambardak3").css("display", "block");
                $("#cambardak3").empty();
                let waypointactive = data.mil.toString()
                $("#cambardak3").append(waypointactive.slice(0,4)  + "mi");
            }
        }
    }

    if (data.action == "show") {
        if (data.show) {
            $(".jss111").css("display", 'block');
            $("#healthfull").fadeIn(1500, function() { $("#healthfull").css("display", "flex"); });
            $("#armorfull").fadeIn(1500, function() { $("#armorfull").css("display", "flex"); });
            $("#hungerfull").fadeIn(1500, function() { $("#hungerfull").css("display", "flex"); });
            $("#thirstfull").fadeIn(1500, function() { $("#thirstfull").css("display", "flex"); });
            $("#oxyfull").fadeIn(1500, function() { $("#oxyfull").css("display", "flex"); });
            $("#dogalgazfull").fadeIn(1500, function() { $("#dogalgazfull").css("display", "flex"); });
            $("#stressfull").fadeIn(1500, function() { $("#stressfull").css("display", "flex"); });
            $("#dbfull").fadeIn(1500, function() { $("#dbfull").css("display", "flex"); });
            $("#windfull").fadeIn(1500, function() { $("#windfull").css("display", "flex"); });
            $("#pingfull").fadeIn(1500, function() { $("#pingfull").css("display", "flex"); });
            $("#ampulfull").fadeIn(1500, function() { $("#ampulfull").css("display", "flex"); });
            $("#dollarfull").fadeIn(1500, function() { $("#dollarfull").css("display", "flex"); });
            $("#yuzmefull").fadeIn(1500, function() { $("#yuzmefull").css("display", "flex"); });
            $("#gymfull").fadeIn(1500, function() { $("#gymfull").css("display", "flex"); });
            $("#harnessfull").fadeIn(1500, function() { $("#harnessfull").css("display", "flex"); });
            $("#cruisefull").fadeIn(1500, function() { $("#cruisefull").css("display", "flex"); });
            $("#nukefull").fadeIn(1500, function() { $("#nukefull").css("display", "flex"); });
            $("#gpsfull").fadeIn(1500, function() { $("#gpsfull").css("display", "flex"); });
            $("#gpufull").fadeIn(1500, function() { $("#gpsfull").css("display", "flex"); });
            $("#nosfull").fadeIn(1500, function() { $("#nosfull").css("display", "flex"); });
        } else {
            $("#hudfull").fadeOut(500);
        }
    }

    if (data.action == "update") {
        
        var HealthAmount = $("#healthValue").val();
        SetHealthAmount = HealthAmount;

        var ArmorAmount = $("#armorValue").val();
        SetArmorAmount = ArmorAmount;

        var HungerAmount = $("#hungerValue").val();
        SetFoodAmount = HungerAmount;

        var ThirstAmount = $("#thirstValue").val();
        SetWaterAmount = ThirstAmount;

        health = data.health
        armor = data.armor

        hunger = data.hunger
        thirst = data.thirst
        oxy = data.oxy
        stress = data.stress

        voicemod = data.voice;
        talking = data.talking;

        if (voicemod == "3") {
            $("#voice").attr('stroke-dashoffset', 0);
        } else if (voicemod == "2") {
            $("#voice").attr('stroke-dashoffset', 41);
        } else if (voicemod == "1") {
            $("#voice").attr('stroke-dashoffset', 85);
        }

        if (data.radioPush == true) {
            $('#voice').css("stroke", "#e1405a");
            $('#voicebar').css("stroke", "#e1405a");
        } else if (data.talking == true) {
            $('#voice').css("stroke", "#ffeb3a");
            $('#voicebar').css("stroke", "#ffeb3a");
        } else if (data.talking == false) {
            $('#voice').css("stroke", "#ffff");
            $('#voicebar').css("stroke", "#ffff");
        }

        if (data.radio == true) {
            $("#ShowHeadSet").show();
            $("#ShowMic").hide();
        } else if (data.radio == false) {
            $("#ShowMic").show();
            $("#ShowHeadSet").hide();
        }

        if (setHealOnOff == true) {
            $("#healthfull").fadeOut(500, function() { $("#healthfull").css("display", "none"); });
        } else {
            if (health) {
                if(data.health <= SetHealthAmount){ $("#healthfull").fadeIn(500, function() { $("#healthfull").css("display", "flex"); });}
                if(data.health > SetHealthAmount){ $("#healthfull").fadeOut(500, function() { $("#healthfull").css("display", "none"); }); }
                setBarValue(health, "#health")
            } else if (health == false) {
                $("#healthfull").fadeOut(500, function() { $("#healthfull").css("display", "none"); });
            }
        }

        if (setArmorOnOff == true) {
            $("#armorfull").fadeOut(500, function() { $("#armorfull").css("display", "none"); });
        } else {
            if (armor >= 0) {
                if(armor <= SetArmorAmount) { $("#armorfull").fadeIn(500, function() { $("#armorfull").css("display", "flex"); });}
                if(armor > SetArmorAmount) { $("#armorfull").fadeOut(500, function() { $("#armorfull").css("display", "none"); }); }
                setBarValue(armor, "#armor")
            } else if (armor == false) {
                $("#armorfull").fadeOut(500, function() { $("#armorfull").css("display", "none"); });
            }
        }

        if (setFoodOnOff == true && data.hunger != 0) {
            $("#hungerfull").fadeOut(500, function() { $("#hungerfull").css("display", "none"); });
        } else if (data.hunger == 0) {
            $("#hungerfull").fadeIn(500, function() { $("#hungerfull").css("display", "flex"); });
        } else {
            if (hunger) {
                if(data.hunger < SetFoodAmount){ $("#hungerfull").fadeIn(500, function() { $("#hungerfull").css("display", "flex"); });}
                if(data.hunger > SetFoodAmount){ $("#hungerfull").fadeOut(500, function() { $("#hungerfull").css("display", "none"); }); }
                setBarValue(hunger, "#hunger")
            } else if (hunger == false) {
                $("#hungerfull").fadeOut(500, function() { $("#hungerfull").css("display", "none"); });
            }
        }

        if (setWateronOff == true && data.thirst != 0) {
            $("#thirstfull").fadeOut(500, function() { $("#thirstfull").css("display", "none"); });
        } else if (data.thirst == 0) {
            $("#thirstfull").fadeIn(500, function() { $("#thirstfull").css("display", "flex"); });
        } else {
            if (thirst) {
                if(data.thirst < SetWaterAmount){ $("#thirstfull").fadeIn(500, function() { $("#thirstfull").css("display", "flex"); });}
                if(data.thirst > SetWaterAmount){ $("#thirstfull").fadeOut(500, function() { $("#thirstfull").css("display", "none"); }); }
                setBarValue(thirst, "#thirst")
            } else if (thirst == false) {
                $("#thirstfull").fadeOut(500, function() { $("#thirstfull").css("display", "none"); });
            }
        }

        if (!setOxyOnOff) {
            $("#oxyfull").fadeOut(500, function() { $("#oxyfull").css("display", "none"); });
        } else {
            if (oxy >= 26 || oxy <= 20) {
                setBarValue(oxy, "#oxy")
                $("#oxyfull").fadeIn(500, function() { $("#oxyfull").css("display", "flex"); });
            } else if (oxy <= 26) {  // Less then
                $("#oxyfull").fadeOut(500, function() { $("#oxyfull").css("display", "none"); });
            }
        }

        if (!setStressOnOff) {
            $("#stressfull").fadeOut(500, function() { $("#stressfull").css("display", "none"); });
        } else {
            if (stress >= 3) {
                setBarValue(stress, "#stress")
                $("#stressfull").fadeIn(500, function() { $("#stressfull").css("display", "flex"); });
            } else if (stress <= 2) {  // Less then
                $("#stressfull").fadeOut(500, function() { $("#stressfull").css("display", "none"); });
            }
        }


        if (data.dogalgaz) {
            dogalgaz = data.dogalgaz
            setBarValue(dogalgaz, "#dogalgaz")
            $("#dogalgazfull").fadeIn(500, function() { $("#dogalgazfull").css("display", "flex"); });
        } else if (data.dogalgaz == false) {
            $("#dogalgazfull").fadeOut(500, function() { $("#dogalgazfull").css("display", "none"); });
        }

        if (yamert == false) {
            if (data.db) {
                db = data.db
                setBarValue(db, "#db")
                $("#dbfull").fadeIn(500, function() { $("#dbfull").css("display", "flex"); });
            } else if (data.db == false) {
                $("#dbfull").fadeOut(500, function() { $("#dbfull").css("display", "none"); });
            }
    
            if (data.wind) {
                wind = data.wind
                setBarValue(wind, "#wind")
                $("#windfull").fadeIn(500, function() { $("#windfull").css("display", "flex"); });
            } else if (data.wind == false) {
                $("#windfull").fadeOut(500, function() { $("#windfull").css("display", "none"); });
            }
    
            if (data.ampul) {
                ampul = data.ampul
                setBarValue(ampul, "#ampul")
                $("#ampulfull").fadeIn(500, function() { $("#ampulfull").css("display", "flex"); });
            } else if (data.ampul == false) {
                $("#ampulfull").fadeOut(500, function() { $("#ampulfull").css("display", "none"); });
            }
    
            if (data.dollar) {
                dollar = data.dollar
                setBarValue(dollar, "#dollar")
                $("#dollarfull").fadeIn(500, function() { $("#dollarfull").css("display", "flex"); });
            } else if (data.dollar == false) {
                $("#dollarfull").fadeOut(500, function() { $("#dollarfull").css("display", "none"); });
            }
    
            if (data.yuzme) {
                yuzme = data.yuzme
                setBarValue(yuzme, "#yuzme")
                $("#yuzmefull").fadeIn(500, function() { $("#yuzmefull").css("display", "flex"); });
            } else if (data.yuzme == false) {
                $("#yuzmefull").fadeOut(500, function() { $("#yuzmefull").css("display", "none"); });
            }
    
            if (data.gym) {
                yuzme = data.gym
                setBarValue(gym, "#gym")
                $("#gymfull").fadeIn(500, function() { $("#gymfull").css("display", "flex"); });
            } else if (data.gym == false) {
                $("#gymfull").fadeOut(500, function() { $("#gymfull").css("display", "none"); });
            }
        } else {
            $("#dbfull").fadeOut(500, function() { $("#dbfull").css("display", "none"); });
            $("#windfull").fadeOut(500, function() { $("#windfull").css("display", "none"); });
            $("#ampulfull").fadeOut(500, function() { $("#ampulfull").css("display", "none"); });
            $("#dollarfull").fadeOut(500, function() { $("#dollarfull").css("display", "none"); });
            $("#yuzmefull").fadeOut(500, function() { $("#yuzmefull").css("display", "none"); });
            $("#gymfull").fadeOut(500, function() { $("#gymfull").css("display", "none"); });
        }

        if (data.ping > 500) {
            ping = data.ping
            $("#pingfull").fadeIn(500, function() { $("#pingfull").css("display", "flex"); });
        } else if (data.ping < 500) {
            $("#pingfull").fadeOut(500, function() { $("#pingfull").css("display", "none"); });
        }

        if (data.harness) {
            harness = data.harness
            setBarValue(harness, "#harness")
            $("#harnessfull").fadeIn(500, function() { $("#harnessfull").css("display", "flex"); });
        } else if (data.harness == false) {
            $("#harnessfull").fadeOut(500, function() { $("#harnessfull").css("display", "none"); });
        }

        if (data.cruise) {
            cruise = data.cruise
            setBarValue(cruise, "#cruise")
            $("#cruisefull").fadeIn(500, function() { $("#cruisefull").css("display", "flex"); });
        } else if (data.cruise == false) {
            $("#cruisefull").fadeOut(500, function() { $("#cruisefull").css("display", "none"); });
        }

        if (data.nuke) {
            $("#nukefull").fadeIn(500, function() { $("#nukefull").css("display", "flex"); });
        } else if (data.nuke == false) {
            $("#nukefull").fadeOut(500, function() { $("#nukefull").css("display", "none"); });
        }

        if (data.dev) {
            $("#devmode").fadeIn(500, function() { $("#devmode").css("display", "flex"); });
        } else if (data.dev == false) {
            $("#devmode").fadeOut(500, function() { $("#devmode").css("display", "none"); });
        }

        if (data.debug) {
            $("#debugmode").fadeIn(500, function() { $("#debugmode").css("display", "flex"); });
        } else if (data.debug == false) {
            $("#debugmode").fadeOut(500, function() { $("#debugmode").css("display", "none"); });
        }

        if (data.armed) {
            $("#armed").fadeIn(500, function() { $("#armed").css("display", "flex"); });
        } else if (data.debug == false) {
            $("#armed").fadeOut(500, function() { $("#armed").css("display", "none"); });
        }

        if (data.gps) {
            $("#gpsfull").fadeIn(500, function() { $("#gpsfull").css("display", "flex"); });
        } else if (data.gps == false) {
            $("#gpsfull").fadeOut(500, function() { $("#gpsfull").css("display", "none"); });
        }

        if (data.gpu) {
            gpu = data.gpu
            setBarValue(gpu, "#gpu")
            $("#gpufull").fadeIn(500, function() { $("#gpufull").css("display", "flex"); });
        } else if (data.gpu == false) {
            $("#gpufull").fadeOut(500, function() { $("#gpufull").css("display", "none"); });
        }

        if (data.nos) {
            nos = data.nos
            setBarValue(nos, "#nos")
            $("#nosfull").fadeIn(500, function() { $("#nosfull").css("display", "flex"); });
        } else if (data.nos == false) {
            $("#nosfull").fadeOut(500, function() { $("#nosfull").css("display", "none"); });
        }

        //

        //




        if (data.setHealOnOff == "true") {
            $("#hearth-icon").css("color", "yellow");
        } else if (data.setHealOnOff == "false") {
            $("#hearth-icon").css("color", "white");
        }

        if (data.setArmorOnOff == "true") {
            $("#armor-icon").css("color", "yellow");
        } else if (data.setArmorOnOff == "false") {
            $("#armor-icon").css("color", "white");
        }

        if (data.setFoodOnOff == "true") {
            $("#hunger-icon").css("color", "yellow");
        } else if (data.setFoodOnOff == "false") {
            $("#hunger-icon").css("color", "white");
        }

        if (data.setWateronOff == "true") {
            $("#thirst-icon").css("color", "yellow");
        } else if (data.setWateronOff == "false") {
            $("#thirst-icon").css("color", "white");
        }

        if (data.setOxyOnOff == "true") {
            $("#oxy-icon").css("color", "yellow");
        } else if (data.setOxyOnOff == "false") {
            $("#oxy-icon").css("color", "white");
        }



        if (health <= 24 && !(health == 0)) {
            $("#health").attr("stroke", "red");
            $("#healthbar").attr("stroke", "red");
            $('#healthbar').attr("stroke-opacity", "0.3");
        } else if (health == 0) {
            $("#health").attr("stroke", "red");
            $("#healthbar").attr("stroke", "red");
            $('#healthbar').attr("stroke-opacity", "1.0");
        } else if (health >= 25) {
            $("#health").attr("stroke", "#3BB273");
            $("#healthbar").attr("stroke", "#3BB273");
            $('#healthbar').attr("stroke-opacity", "0.3");
        }
    
        if (armor <= 24 && !(armor == 0)) {
            $("#armor").attr("stroke", "red");
            $("#armorbar").attr("stroke", "red");
            $('#armorbar').attr("stroke-opacity", "0.3");
        } else if (armor == 0) {
            $("#armor").attr("stroke", "red");
            $("#armorbar").attr("stroke", "red");
            $('#armorbar').attr("stroke-opacity", "1.0");
        } else if (armor >= 25) {
            $("#armor").attr("stroke", "#1565C0");
            $("#armorbar").attr("stroke", "#1565C0");
            $('#armorbar').attr("stroke-opacity", "0.3");
        }

        if (hunger <= 24 && !(hunger == 0)) {
            $("#hunger").attr("stroke", "red");
            $("#hungerbar").attr("stroke", "red");
            $('#hungerbar').attr("stroke-opacity", "0.3");
        } else if (hunger == 0) {
            $("#hunger").attr("stroke", "red");
            $("#hungerbar").attr("stroke", "red");
            $('#hungerbar').attr("stroke-opacity", "1.0");
        } else if (hunger >= 25) {
            $("#hunger").attr("stroke", "#FF6D00");
            $("#hungerbar").attr("stroke", "#FF6D00");
            $('#hungerbar').attr("stroke-opacity", "0.3");
        }

        if (thirst <= 24 && !(thirst == 0)) {
            $("#thirst").attr("stroke", "red");
            $("#thirstbar").attr("stroke", "red");
            $('#thirstbar').attr("stroke-opacity", "0.3");
        } else if (thirst == 0) {
            $("#thirst").attr("stroke", "red");
            $("#thirstbar").attr("stroke", "red");
            $('#thirstbar').attr("stroke-opacity", "1.0");
        } else if (thirst >= 25) {
            $("#thirst").attr("stroke", "#0277BD");
            $("#thirstbar").attr("stroke", "#0277BD");
            $('#thirstbar').attr("stroke-opacity", "0.3");
        }

        if (oxy <= 24 && !(oxy == 0)) {
            $("#oxy").attr("stroke", "red");
            $("#oxybar").attr("stroke", "red");
            $('#oxybar').attr("stroke-opacity", "0.3");
        } else if (oxy == 0) {
            $("#oxy").attr("stroke", "red");
            $("#oxybar").attr("stroke", "red");
            $('#oxybar').attr("stroke-opacity", "1.0");
        } else if (oxy >= 25) {
            $("#oxy").attr("stroke", "#90A4AE");
            $("#oxybar").attr("stroke", "#90A4AE");
            $('#oxybar').attr("stroke-opacity", "0.3");
        }
    }
})

function mat(x){
    var deger = x;

    var partialValue = 126;

    var yuzde = 100/deger;

    var mat = partialValue/yuzde;

    var lastVal = partialValue - mat;
    return lastVal
}

document.onkeyup = function (data) {
    if ( data.which == 27 ) { //esc
      $.post('https://np-hud/close', JSON.stringify({}));
      $(".menu").fadeOut(500);
    }
};

function setBarValue(value, element) {
    var matsa = mat(value);
    $(element).attr('stroke-dashoffset', matsa);
}



$(function(){
    $('.jss256').change(function(){
        if ($('#healthInput').prop('checked')) {
            setHealOnOff = false
        } else {
            setHealOnOff = true
        }

        if ($('#armorInput').prop('checked')) {
            setArmorOnOff = false
        } else {
            setArmorOnOff = true
        }

        if ($('#foodInput').prop('checked')) {
            setFoodOnOff = false
        } else {
            setFoodOnOff = true
        }

        if ($('#thirstInput').prop('checked')) {
            setWateronOff = false
        } else {
            setWateronOff = true
        }

        if ($('#time').prop('checked')) {
            time = true;
            $.post('https://np-hud/time', JSON.stringify({
                time: true
            }));
        } else {
            time = false;
            $.post('https://np-hud/time', JSON.stringify({
                time: false
            }));
        }

        if ($('#blackbarInput').prop('checked')) {
            $('.blackbars').css({
                'display': 'block', 
                'height': $('.blackbarInputNumber').val() + 'vh'
            });

        } else {
            $('.blackbars').css('display', 'none')
        }
    });


    $('.blackbarInputNumber').keyup(function(){
        $('.blackbars').css('height', $(this).val() + 'vh')
    });

    $("#defaultmap").change(function() {
        if ($('#defaultmap').prop('checked')) {
            SetDefaultMap = true
            $.post('https://np-hud/minimap', JSON.stringify({
                action: "default"
            }));
        } else {
            SetDefaultMap = false
            $.post('https://np-hud/minimap', JSON.stringify({
                action: "ovalmap"
            }));
        }
    });

    $("#compass").change(function() {
        if ($('#compass').prop('checked')) {
            $('#compassfull').css("display", "block");
            compass = true
        } else {
            $('#compassfull').css("display", "none");
            compass = false
        }
    });

    $("#openmap").change(function() {
        if ($('#openmap').prop('checked')) {
            $.post('https://np-hud/minimap', JSON.stringify({
                action: "open"
            }));
            $('#speedometerfps').css("display", "block");
        } else {
            $.post('https://np-hud/minimap', JSON.stringify({
                action: "close"
            }));
            $('#speedometerfps').css("display", "none");
        }
    });

    $("#outlinemap").change(function() {
        if ($('#outlinemap').prop('checked')) {
            SetOutline = true
            $.post('https://np-hud/minimap', JSON.stringify({
                action: "outline-open"
            }));
        } else {
            SetOutline = false
            $.post('https://np-hud/minimap', JSON.stringify({
                action: "outline-close"
            }));
        }
    });

    $(".menu").css("display", "none");
});


function pipidisabledSVG(input) {
    $(`${input}`).parent().parent().removeClass('Mui-checked')
    $(`${input} + svg path`).attr('d', 'M19 5v14H5V5h14m0-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2z')
}

function pipicheckedSVG(input) {
    $(`${input}`).parent().parent().addClass('Mui-checked')
    $(`${input} + svg path`).attr('d', 'M19 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.11 0 2-.9 2-2V5c0-1.1-.89-2-2-2zm-9 14l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z')
}

function isElement(element) {
    return element instanceof Element || element instanceof HTMLDocument;
}

document.body.addEventListener('click', function(e) {

    let id = "myid",
    elemWidth = 15,
    elemHeight = 9,
    borderThickness = 1;

    let div = document.createElement("div");
    div.id = id;

    div.style.position = "absolute";
    div.style.height = `${elemHeight}vh`;
    div.style.width = `${elemWidth}vh`;
    div.style.display = "none";
  
    e.clientX + elemWidth + borderThickness * 50 > window.innerWidth
    ? (div.style.right = `${window.innerWidth - e.clientX}px`)
    : (div.style.left = `${e.clientX}px`);
    e.clientY + elemHeight + borderThickness * 20 > window.innerHeight
    ? (div.style.bottom = `${window.innerHeight - e.clientY}px`)
    : (div.style.top = `${e.clientY}px`);

    if (isElement(document.getElementById(id)))
    document.getElementById(id).remove();
    document.body.appendChild(div);
    $(`#${id}`).show();


    let saveOptionContainer = `
        <div class='option-container'>
            <div class='option-select save-option-1'><p>1</p></div>
            <div class='option-select save-option-2'><p>2</p></div>
        <div>
    `;

    let speedmeterOption = `
    <div class='option-container'>
        <div class='option-select speedmeter-15'><p>15</p></div>
        <div class='option-select speedmeter-35'><p>35</p></div>
        <div class='option-select speedmeter-60'><p>60</p></div>
    <div>
    `;

    let compassOption = `
    <div class='option-container'>
        <div class='option-select compass-15'><p>15</p></div>
        <div class='option-select compass-35'><p>35</p></div>
        <div class='option-select compass-60'><p>60</p></div>
    <div>
    `;


    //console.log(e.target)

    if ( $(e.target).is('.select-save-number div')) { 
        $(`#${id}`).append(saveOptionContainer);
        
    } else if ($(e.target).is('.speedmeterOptionBtn')) {
        $(`#${id}`).append(speedmeterOption);

        var posX = $(this).offset().left;
        if ((e.pageX - posX) > 955){
            $(`#${id}`).css('margin-left', '-14vh')
        }   

    } else if ($(e.target).is('.compassOptionBtn')) {
        $(`#${id}`).append(compassOption);
        var posX = $(this).offset().left;
        if ((e.pageX - posX) > 955){
            $(`#${id}`).css('margin-left', '-14vh')
        }   

    } else {
        $(`#${id}`).remove();
    }

    if ($(`#${id}`).css('display') == 'block') {
        $('.jss1239').css('overflow', 'hidden')
    } else {
        $('.jss1239').css('overflow-y', 'scroll')
    }

    $('.speedmeter-15').click(function(){
        $('.speedmeterOptionBtn').html('15')
        SetSpeedFPS = 500
        $.post('https://np-hud/carhud', JSON.stringify({
            fps: 500
        }));
    });
    $('.speedmeter-35').click(function(){
        $('.speedmeterOptionBtn').html('35')
        SetSpeedFPS = 250
        $.post('https://np-hud/carhud', JSON.stringify({
            fps: 250
        }));
    });
    $('.speedmeter-60').click(function(){
        $('.speedmeterOptionBtn').html('60')
        SetSpeedFPS = 50
        $.post('https://np-hud/carhud', JSON.stringify({
            fps: 50
        }));
    });


    $('.compass-15').click(function(){
        $('.compassOptionBtn').html('15')
        SetCompassFPS = 50
        $.post('https://np-hud/compass', JSON.stringify({
            fps: 50
        }));
    });
    $('.compass-35').click(function(){
        $('.compassOptionBtn').html('35')
        SetCompassFPS = 15
        $.post('https://np-hud/compass', JSON.stringify({
            fps: 15
        }));
    });

    $('.compass-60').click(function(){
        $('.compassOptionBtn').html('60')
        SetCompassFPS = 1
        $.post('https://np-hud/compass', JSON.stringify({
            fps: 1
        }));
    });

    return false;
});


$(document).on('click', '#save-button', function (e) {
    e.preventDefault();
    $.post('https://np-hud/SaveSettings', JSON.stringify({
        healthValue: $("#healthValue").val(),
        armorValue: $("#armorValue").val(),
        hungerValue: $("#hungerValue").val(),
        thirstValue: $("#thirstValue").val(),
        
        healthToggled: setHealOnOff,
        armorToggled: setArmorOnOff,
        hungerToggled: setFoodOnOff,
        thirstToggled: setWateronOff,

        speedFPSValue: SetSpeedFPS,
        compassFPSValue: SetCompassFPS,

        defaultMapToggled: SetDefaultMap,
        outlineToggled: SetOutline,
        timeToggled: time,
    }));
});

const checkboxs = document.getElementsByClassName('jss256');
const inputColor = document.getElementsByClassName('MuiIconButton-root');
const inputSvg = document.querySelectorAll('.MuiIconButton-root .MuiIconButton-label .MuiSvgIcon-root path');
setTimeout(() => {
    for (let i = 0; i < checkboxs.length; i++) {
        checkboxs[i].addEventListener('change', function(){
            if (checkboxs[i].checked) {
                //console.log(checkboxs[i])
                inputColor[i].classList.add('Mui-checked')
                inputSvg[i].setAttribute('d', 'M19 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.11 0 2-.9 2-2V5c0-1.1-.89-2-2-2zm-9 14l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z')
        
            } else {
                inputColor[i].classList.remove('Mui-checked')
                inputSvg[i].setAttribute('d', 'M19 5v14H5V5h14m0-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2z')
            }
        });
    }        
}, 1);


