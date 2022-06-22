$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: 
            break;
    }
});

var moneyTimeout = null;
var CurrentProx = 0;

var imageWidth = 100;
var containerWidth = 100;
var width =  0;
var south = (-imageWidth) + width;
var west = (-imageWidth * 2) + width;
var north = (-imageWidth * 3) + width;
var east = (-imageWidth * 4) + width;
var south2 = (-imageWidth * 5) + width;

let setHealOnOff = true;
let setArmorOnOff = true;
let setFoodOnOff = true;
let setWateronOff = true;
let setOxyOnOff = true;
let setStressOnOff = true;

let nitroTrail = true;
let nitrolevel = true;

let chealth = 100;
let carmor = 100;
let cfood = 100;
let cwater = 100;

function calcHeading(direction) {
    if (direction < 90) {
        return lerp(north, east, direction / 90);
    } else if (direction < 180) {
        return lerp(east, south2, rangePercent(90, 180, direction));
    } else if (direction < 270) {
        return lerp(south, west, rangePercent(180, 270, direction));
    } else if (direction <= 360) {
        return lerp(west, north, rangePercent(270, 360, direction));
    }
}

function lerp(min, max, amt) {
	return (1 - amt) * min + amt * max;
}

function rangePercent(min, max, amt) {
	return (((amt - min) * 100) / (max - min)) / 100;
}



(() => {
    NPUI = {};

    // NPUI.CarHud = function(data) {
    //     if (calcHeading(data.direction)) {
    //         $(".direction").find(".image").attr('style', 'transform: translate3d(' + calcHeading((data.direction)) + 'px, 0px, 0px)');
    //         return;
    //     }
    //     if (data.show) {
    //         $(".ui-car-container").show();
    //         $(".direction").show()
    //     } else {
    //         $(".ui-car-container").hide();
    //         $(".direction").hide()
    //     }
    // };

    // NPUI.car = function(data) {

    //     if (data.speed > 0) {
    //         $(".speedamount").text(data.speed);
    //         setProgressSpeed(data.speed, '.progress-speed');
    //     } else if (data.speed == 0) {
    //         $(".speedamount").text("0");
    //     }
    
    //     if (data.fuel) {
    //         setProgressFuel(data.fuel, ".progress-fuel");
    //     }
 
    //     if (data.showCarUi == true) {
    //         $(".Vehicle_hud").fadeIn();
    //     } else if (data.showCarUi == false) {
    //         $(".Vehicle_hud").fadeOut();
    //     }

    //     if (data.belt == false) {
    //         $(".belt").fadeIn(1000);
    //     } else if (data.belt == true) {
    //         $(".belt").fadeOut(1000);
    //     }
    // };

    NPUI.UpdateVoice = function(data) {
        if (data.talking == 'radio') {
            $('.mic').css("stroke", "#e1405a");
            $('.micro').css("stroke", "#e1405a");
        } else if (data.talking == 'normal') {
            $('.mic').css("stroke", "#ffeb3a");
            $('.micro').css("stroke", "#ffeb3a");
        } else if (data.talking == 'nottalking') {
            $('.mic').css("stroke", "#ffff");
            $('.micro').css("stroke", "#ffff");
        }
    }

    NPUI.UpdateHud = function(data) {
        var Show = "block";
        if (data.show) {
            Show = "none";
            $(".ui-container").css("display", Show);

            // Health
            $('.hvida').fadeIn(0);
            $('.fa-heart').fadeIn(0);

            // Armor
            $('.harmor').fadeIn(0);
            $('.fa-shield-alt').fadeIn(0);

            // Hunger
            $('.hhunger').fadeIn(0);
            $('.fa-hamburger').fadeIn(0);

            // Thirst
            $('.hthirst').fadeIn(0);
            $('.fa-tint').fadeIn(0);

            // Oxygen
            $('.hoxygen').fadeIn(0);
            $('.fa-lungs').fadeIn(0);

            // Stress
            $('.hstress').fadeIn(0);
            $('.fa-brain').fadeIn(0);

            // Harness
            $('.hcinturon').fadeIn(0);
            $(".fa-user-slash").fadeIn(0);

            // Pursuit Mode
            $('.hpursuit').fadeIn(0);
            $('.fa-tachometer-alt').fadeIn(0);

            // Arrow
            $('.hcompass').fadeIn(0);
            $('.fa-location-arrow').fadeIn(0);

            // Mircochip
            $('.hchip').fadeIn(0);
            $('.fa-microchip ').fadeIn(0);
            
            // Stream
            $('.hshootmode').fadeIn(0);
            $('.fa-stream').fadeIn(0);

            // Nitrous
            $('.hnitrous').fadeIn(0);
            $(".fa-meteor").fadeIn(0);

            // Casino
            $('.htiempous').fadeIn(0);
            $(".fa-stopwatch-20").fadeIn(0);

            // Bio
            $('.hbioh').fadeIn(0);
            // hswim
            $('.hswim').fadeIn(0);
            // hdollar
            $('.hdollar').fadeIn(0);
            // hping
            $('.hping').fadeIn(0);
            // hlight
            $('.hlight').fadeIn(0);
            // hdumbell
            $('.hdumbell').fadeIn(0);
            // hdatabase
            $('.hdatabase').fadeIn(0);
            // hsmart
            $('.hsmart').fadeIn(0);
            
            
            return;
        } else {

        }
        $(".ui-container").css("display", Show);
        if (data.mic == 1) {
            data.mic = 33;
            Progress(data.mic, ".mic");
        } else if (data.mic == 2) {
            data.mic = 66;
            Progress(data.mic, ".mic");
        } else if (data.mic == 3) {
            data.mic = 100;
            Progress(data.mic, ".mic");
        } 

        if (data.health - 100 === 20) {
            Progress(0, ".hp");
        } else {
            Progress(data.health - 100, ".hp");
        }
        
        if (setHealOnOff) {
            if ( data.health / 2 <= chealth || chealth === 100) {
                $('.hvida').fadeIn(2500);
                $('.fa-heart').fadeIn(2500);
            } else if ( data.health / 2 >= chealth || setHealOnOff) {
                $('.hvida').fadeOut(2500);
                $('.fa-heart').fadeOut(2500);
            }
        } else {
            $('.hvida').fadeOut(2500);
            $('.fa-heart').fadeOut(2500);
        }
        if (data.health <= 145) {
            $('.vida').css("stroke", "red");
            $('.vida').css("stroke-opacity", "1.0");
        } else {
            $('.vida').css("stroke", "#3eb174");
            $('.vida').css("stroke-opacity", "0.3");
        }
        Progress(data.armor, ".armor");
        if (setArmorOnOff) {
            if ( data.armor <= carmor || carmor === 100) {
                $('.harmor').fadeIn(2500);
                $('.fa-shield-alt').fadeIn(2500);
            } else if ( data.armor / 2 >= carmor || setArmorOnOff) {
                $('.harmor').fadeOut(2500);
                $('.fa-shield-alt').fadeOut(2500);
            }
        } else {
            $('.harmor').fadeOut(2500);
            $('.fa-shield-alt').fadeOut(2500);
        }
        if (data.armor <= 15) {
            $('.amr').css("stroke", "red");
            $('.amr').css("stroke-opacity", "1.0");
        } else {
            $('.amr').css("stroke", "#1666c0");
            $('.amr').css("stroke-opacity", "0.3");
        }

        Progress(data.hunger, ".hunger");
        if (setFoodOnOff) {
            if ( data.hunger <= cfood || cfood === 100) {
                $('.hhunger').fadeIn(2500);
                $('.fa-hamburger').fadeIn(2500);
            } else if ( data.hunger / 2 >= cfood || setFoodOnOff) {
                $('.hhunger').fadeOut(2500);
                $('.fa-hamburger').fadeOut(2500);
            }
        } else {
            $('.hhunger').fadeOut(2500);
            $('.fa-hamburger').fadeOut(2500);
        }
        if (data.hunger <= 15) {
            $('.fome').css("stroke", "red");
            $('.fome').css("stroke-opacity", "1.0");
        } else {
            $('.fome').css("stroke", "#fc6d02");
            $('.fome').css("stroke-opacity", "0.3");
        }

        Progress(data.thirst, ".thirst");
        if (setWateronOff) {
            if ( data.thirst <= cwater || cwater === 100) {
                $('.hthirst').fadeIn(2500);
                $('.fa-tint').fadeIn(2500);
            } else if ( data.thirst / 2 >= cwater || setWateronOff) {
                $('.hthirst').fadeOut(2500);
                $('.fa-tint').fadeOut(2500);
            }
        } else {
            $('.hthirst').fadeOut(2500);
            $('.fa-tint').fadeOut(2500);
        }
        if (data.thirst <= 15) {
            $('.cede').css("stroke", "red");
            $('.cede').css("stroke-opacity", "1.0");
        } else {
            $('.cede').css("stroke", "#0176bd");
            $('.cede').css("stroke-opacity", "0.3");
        }

        Progress(data.oxygen, ".oxygen");
        if (!setOxyOnOff) {
            $('.hoxygen').hide();
            $('.fa-lungs').hide();
        } else {
            if (data.oxygen >= 26 || data.oxygen <= 20) { // less then or greater
                $('.hoxygen').fadeIn(2500);
                $('.fa-lungs').fadeIn(2500);
                $('.oxy').css("stroke", "red");
                $('.oxy').css("stroke-opacity", "1.0");

            } else if (data.oxygen <= 26) {  // Less then
                $('.hoxygen').fadeOut(2500);
                $('.fa-lungs').fadeOut(2500);
            }
        }

        // if (data.oxygen <= 20) { // Less then 20
        //     $('.hoxygen').fadeIn(2500);
        //     $('.fa-lungs').fadeIn(2500);
        //     $('.oxy').css("stroke", "red");
        //     $('.oxy').css("stroke-opacity", "1.0");
        // } else {
        //     $('.oxy').css("stroke", "#90a4ae");
        //     $('.oxy').css("stroke-opacity", "0.3");
        // }


        Progress(data.stress, ".stress");
        if (data.stress >= 3) {
            $('.hstress').fadeIn(2500);
            $('.fa-brain').fadeIn(2500);
        }
        if (data.stress <= 2) {
            $('.hstress').fadeOut(2500);
            $('.fa-brain').fadeOut(2500);
        }
        Progress(data.speedometeron, ".nitrous");
        if (data.speedometeron== true) {
            $(".hnitrous").fadeIn(2500);
            $('.fa-tachometer-altwa').fadeIn(2500);
            $(".nitrous").css({"stroke":"#e1405a"});
        } else if (data.speedometeron == false) {
            $(".hnitrous").fadeOut(2500);
            $('.fa-tachometer-altwa').fadeOut(2500);
            $(".fa-meteor").fadeOut(2500);
        }  
        Progress(data.casino, ".tiempous");
        if (data.casino >= 1) {
            $(".htiempous").fadeIn(0);
            $(".fa-stopwatch-20").fadeIn(0);
        } else {
            $(".htiempous").fadeOut(0);
            $(".fa-stopwatch-20").fadeOut(0);
        }  
        setProgressHarness(data.cinturon, ".cinturon");
        if (data.cinturon >= 0.1 && data.inVehicle) {
            $(".hcinturon").fadeIn(2500);            
            $(".fa-user-slash").fadeIn(2500);
            $(".cinturon").css({"stroke":"#a847b6"});                      
        } else {
            $(".hcinturon").fadeOut(2500);            
            $(".fa-user-slash").fadeOut(2500);
        }        
        Progress(data.shoot, ".shootmode");
        if (data.shoot >= 5) {
            $('.hshootmode').fadeIn(2500);
            $('.fa-stream').fadeIn(2500);
        } else {
            $('.hshootmode').fadeOut(2500);
            $('.fa-stream').fadeOut(2500);
        }
        Progress(data.pursuitmode, ".pursuit");
        if (data.pursuitmode >= 5  && data.inVehicle) {
            $('.hpursuit').fadeIn(2500);
            $('.fa-tachometer-alt').fadeIn(2500);
        } else {
            $('.hpursuit').fadeOut(2500);
            $('.fa-tachometer-alt').fadeOut(2500);
        }
        
        Progress(data.chipmode, ".chip");
        if (data.chipmode >= 5) {
            $('.hchip').fadeIn(2500);
            $('.fa-microchip ').fadeIn(2500);
        } else {
            $('.hchip').fadeOut(2500);
            $('.fa-microchip ').fadeOut(2500);
        }
        Progress(data.hcompass, ".compass");
        if (data.ecompass) {
            $('.hcompass').fadeIn(2500);
            $('.fa-location-arrow').fadeIn(2500);
        } else {
            $('.hcompass').fadeOut(2500);
            $('.fa-location-arrow').fadeOut(2500);
        }
        Progress(data.swim, ".swimming");
        if (data.swim <= 99) {
            $(".hswim").fadeIn(2500);
        } else {
            $(".hswim").fadeOut(2500);
        }
        Progress(data.dollar, ".dollar");
        if (data.dollar <= 99) {
            $(".hdollar").fadeIn(2500);
        } else {
            $(".hdollar").fadeOut(2500);
        }
        
        if (data.ping == 100) {
            $(".hping").fadeIn(2500);
        } else {
            $(".hping").fadeOut(2500);
        }
        Progress(data.light, ".light");
        if (data.light <= 99) {
            $(".hlight").fadeIn(2500);
        } else {
            $(".hlight").fadeOut(2500);
        }

        Progress(data.dev, ".developer");  
        if (data.dev) {
            $('.hdeveloper').fadeIn(0);
            $('.fa-terminal').fadeIn(0);
        }
        else {
            $('.hdeveloper').fadeOut(0);
            $('.fa-terminal').fadeOut(0);
        }

        Progress(data.hbioh, ".bioh");
        if (data.hbioh) {
            $('.hbioh').fadeIn(2500);
        } else {
            $('.hbioh').fadeOut(2500);
        }

        Progress(data.hdatabase, ".database");
        if (data.hdatabase) {
            $('.hdatabase').fadeIn(2500);
        } else {
            $('.hdatabase').fadeOut(2500);
        }
        
        Progress(data.hdumbell, ".dumbell");
        if (data.hdumbell) {
            $('.hdumbell').fadeIn(2500);
        } else {
            $('.hdumbell').fadeOut(2500);
        }
        
        Progress(data.hfast, ".fast");
        if (data.hfast) {
            $('.hfast').fadeIn(2500);
        } else {
            $('.hfast').fadeOut(2500);
        }

        Progress(data.dev2, ".developer2");  
        if (data.dev2) {
            $('.hdeveloper2').fadeIn(0);
            $('.fa-bug').fadeIn(0);
        }
        else {
            $('.hdeveloper2').fadeOut(0);
            $('.fa-bug').fadeOut(0);
        }

        if (data.radio == true) {
            $("#VoiceIcon").removeClass("fa-microphone");
            $("#VoiceIcon").addClass("fa-headset");
          } else if (data.radio == false) {
            $("#VoiceIcon").removeClass("fa-headset");
            $("#VoiceIcon").addClass("fa-microphone");
        }
    };

    //window.onload = function(e) {
        window.addEventListener('message', function(event) {
            var lol = event.data;
            switch(event.data.action) {
                case "open":
                    NPUI.Open(event.data);
                    break;
                case "close":
                    NPUI.Close();
                    break;
                case "update":
                    NPUI.Update(event.data);
                    break;
                case "show":
                    NPUI.Show(event.data);
                    break;
                case "hudtick":
                    NPUI.UpdateHud(event.data);
                    break;
                case "voiceupdate":
                    NPUI.UpdateVoice(event.data);
                    break;
                case "car":
                    NPUI.CarHud(event.data);
                    break;
                case "ShowCarHud":
                    NPUI.car(event.data);
                    break;
                case "compass":
                    NPUI.CarCompass(event.data);
                    break;
                case "displayUI":
					$(".mapborder").fadeIn(0);
					break;
				case "hideUI":
					$(".mapborder").fadeOut(0);
					break;
                case 'closeMenu':
                    ronin.CloseAyarMenu()
                    break;
                case 'showMenu':
                    $(".ayar-menu-ana").fadeIn(200)
                    setTimeout(function(){
                        $(".ayar-menu-ana").css({"display":"flex"});
                    },1);
                    $('#hud-on').on('change',function(){
                        let hud_on = this.checked
                        $.post('https://np-hud/hud_on',JSON.stringify({
                            hud_on: hud_on
                        }));
                    });
                    $('#can-on').on('change',function(){
                        setHealOnOff = this.checked
                    });
                    
                    $('#zırh-on').on('change',function(){
                        setArmorOnOff = this.checked
                    });
                    
                    $('#yemek-on').on('change',function(){
                        setFoodOnOff = this.checked
                    });
                    
                    $('#su-on').on('change',function(){
                        setWateronOff = this.checked
                    });
                    
                    $('#stress-on').on('change',function(){
                        setStressOnOff = this.checked
                    });

                    $('#nitroTrail').on('change',function(){
                        nitroTrail = this.checked
                    });

                    $('#nitrolevel').on('change',function(){
                        nitrolevel = this.checked
                    });

                    $('#compassinput').on('change',function(){
                        compassinput = this.checked
                        $.post('https://np-hud/compassinput',JSON.stringify({
                            compassinput: compassinput
                        }));
                    });

                    $('#compassTime').on('change',function(){
                        compassTime = this.checked
                        $.post('https://np-hud/compassTime',JSON.stringify({
                            compassTime: compassTime
                        }));
                    });

                    $('#compassStreet').on('change',function(){
                        compassStreet = this.checked
                        $.post('https://np-hud/compassStreet',JSON.stringify({
                            compassStreet: compassStreet
                        }));
                    });

                    $('#d_minimap').on('change',function(){
                        d_minimap = this.checked
                        $.post('https://np-hud/minimap_clip',JSON.stringify({
                            d_minimap: d_minimap
                        }));
                    });

                    $('#speedmeter').on('change',function(){
                        let fps_speed = $('#speedmeter').val();
                        $.post('https://np-hud/update:timer:speed',JSON.stringify({
                            fps_speed: fps_speed
                        }));
                    });

                    $('#girilen-can').keyup(function(){
                        chealth = $('#girilen-can').val();
                    });

                    $('#girilen-zırh').keyup(function(){
                        carmor = $('#girilen-zırh').val();
                    });

                    $('#girilen-yemek').keyup(function(){
                        cfood = $('#girilen-yemek').val();
                    });

                    $('#girilen-water').keyup(function(){
                        cwater = $('#girilen-water').val();
                    });
                    
                    $(document).on('click', '.close-ayar-menu', function(e){
                        ronin.CloseAyarMenu()
                        
                    });

                    break
            }
            
        })
    //}

})();


$('#blackbar-container #labeliste, #blackbar-container #blackbar-ac').click(function(){
    if ( $('#blackbar-container #blackbar-ac').is(':checked') ) {
        $('#bar1').css('display', 'block')
        $('#bar2').css('display', 'block')
    } else {
        $('#bar1').css('display', 'none')
        $('#bar2').css('display', 'none')
    }
});

$('#blackbarVal').keyup(function(){
    var deger = $('#blackbarVal').val();

    $('#bar1').css('height', deger+'vh')
    $('#bar2').css('height', deger+'vh')
    
    if ( deger > 40 ) {
        $('#bar1').css('height', '40vh')
        $('#bar2').css('height', '40vh')
    } else if ( deger == '' || deger == 0) {
        $('#bar1').css('height', '0')
        $('#bar2').css('height', '0')
    }

});


$('#minimap').change(function(){
    let on = this.checked
    $.post('https://np-hud/ayar-minimap',JSON.stringify({
        minimap: on
    }));
});

ronin = {};

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
        ronin.CloseAyarMenu();
            break;
    }
});

ronin.CloseAyarMenu = function() {
    $(".ayar-menu-ana").fadeOut(200)
    $.post('https://np-hud/close-ayar-menu');
};


function Progress(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
  
    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;
  
    const offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
    circle.style.strokeDashoffset = -offset;
}

function ProgressHealth(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
  
    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;
  
    const offset = circumference - ((-percent * 80) / 80 / 80) * circumference;
    circle.style.strokeDashoffset = -offset;
}
function ProgressCasino(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
  
    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;
  
    const offset = circumference - ((-percent * 20) / 20 / 20) * circumference;
    circle.style.strokeDashoffset = -offset;
}

// function setProgressSpeed(value, element) {
//     var circle = document.querySelector(element);
//     var radius = circle.r.baseVal.value;
//     var circumference = radius * 2 * Math.PI;
//     var html = $(element).parent().parent().find('span');
//     var percent = value * 100 / 220;

//     circle.style.strokeDasharray = `${circumference} ${circumference}`;
//     circle.style.strokeDashoffset = `${circumference}`;

//     const offset = circumference - ((-percent * 50) / 100) / 100 * circumference;
//     circle.style.strokeDashoffset = -offset;

//     var predkosc = Math.floor(value * 1.8)
//     if (predkosc == 81 || predkosc == 131) {
//         predkosc = predkosc - 1
//     }

//     html.text(predkosc);
// }

// function setProgressFuel(percent, element) {
//     var circle = document.querySelector(element);
//     var radius = circle.r.baseVal.value;
//     var circumference = radius * 2 * Math.PI;
//     var html = $(element).parent().parent().find('span');

//     circle.style.strokeDasharray = `${circumference} ${circumference}`;
//     circle.style.strokeDashoffset = `${circumference}`;

//     const offset = circumference - ((-percent * 62) / 100) / 100 * circumference;
//     circle.style.strokeDashoffset = -offset;

//     html.text(Math.round(percent));
// }

function setProgressHarness(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent * 100) / 1.0) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
}