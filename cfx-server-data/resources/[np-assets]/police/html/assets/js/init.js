$(document).ready(function(){
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.action == 'open') {
      // console.log(JSON.stringify(event.data.array['user']['gender']))
      var type        = event.data.type;
      var userData    = event.data.array['user'];
      var licenseData = event.data.array['licenses'];
      var sex         = userData['sex'];

        $('#name').css('color', '#282828');

        if ( sex.toLowerCase() == 'm' ) {
          $('#sex').text('male');
        } else {
          $('#sex').text('female');
        }

        $('#name').text(userData['firstname'] + ' ' + userData['lastname']);
        $('#dob').text(userData['dateofbirth']);
        $('#height').text(userData['height']);
        $('#signature').text(userData['firstname'] + ' ' + userData['lastname']);

        if ( type == 'driver' ) {
          if ( licenseData != null ) {
          Object.keys(licenseData).forEach(function(key) {
            var type = licenseData[key].type;

            if ( type == 'drive_bike') {
              type = 'bike';
            } else if ( type == 'drive_truck' ) {
              type = 'truck';
            } else if ( type == 'drive' ) {
              type = 'car';
            }

            if ( type == 'bike' || type == 'truck' || type == 'car' ) {
              $('#licenses').append('<p>'+ type +'</p>');
            }
          });
        }
          if (userData['pstate'] == 'lspd' || userData['pstate'] == null) {
                $('#id-card').css('background', 'url(assets/images/lspd.png)');
          }else if(userData['pstate'] == 'state') {
            $('#id-card').css('background', 'url(assets/images/state.png)');
          }else if(userData['pstate'] == 'ranger') {
            $('#id-card').css('background', 'url(assets/images/ranger.png)');
          }else if(userData['pstate'] == 'sheriff') {
            $('#id-card').css('background', 'url(assets/images/sheriff.png)');
          }
        } else {
          var userData    = event.data.array['user'];
          // $('#name').text(userData['firstname'] + ' ' + userData['lastname']);
          if (userData['pstate'] == 'lspd' || userData['pstate'] == null) {
            $('#id-card').css('background', 'url(assets/images/lspd.png)');
      }else if(userData['pstate'] == 'state') {
        $('#id-card').css('background', 'url(assets/images/state.png)');
      }else if(userData['pstate'] == 'ranger') {
        $('#id-card').css('background', 'url(assets/images/ranger.png)');
      }else if(userData['pstate'] == 'sheriff') {
        $('#id-card').css('background', 'url(assets/images/sheriff.png)');
      }
        }


      $('#id-card').show();
    } else if (event.data.action == 'close') {
      $('#name').text('');
      $('#dob').text('');
      $('#height').text('');
      $('#signature').text('');
      $('#sex').text('');
      $('#id-card').hide();
      $('#licenses').html('');
    }
  });
});

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

    NPUI.CarHud = function(data) {
        if (calcHeading(data.direction)) {
            $(".direction").find(".image").attr('style', 'transform: translate3d(' + calcHeading((data.direction)) + 'px, 0px, 0px)');
            return;
        }
        if (data.show) {
            $(".ui-car-container").show();
            $(".direction").show()
        } else {
            $(".ui-car-container").hide();
            $(".direction").hide()
        }
    };

    NPUI.car = function(data) {

        if (data.speed > 0) {
            $(".speedamount").text(data.speed);
          //  setProgressSpeed(data.speed, '.progress-speed');
        } else if (data.speed == 0) {
            $(".speedamount").text("0");
        }
    
        if (data.fuel == "update_fuel") {
            setProgressFuel(data.fuel, ".Gas_gauge");
        }
 
        if (data.showCarUi == true) {
            $(".Vehicle_hud").fadeIn();
        } else if (data.showCarUi == false) {
            $(".Vehicle_hud").fadeOut();
        }

        if (data.belt == false) {
            $(".belt").fadeIn(1000);
        } else if (data.belt == true) {
            $(".belt").fadeOut(1000);
        }
    };



    NPUI.UpdateHud = function(data) {
        var Show = "block";
        if (data.show) {
            Show = "none";
            $(".ui-container").css("display", Show);
            $('.hvida').fadeIn(0);
            $('.harmor').fadeIn(0);
            $('.hhunger').fadeIn(0);
            $('.hthirst').fadeIn(0);
            $('.hoxygen').fadeIn(0);
            $('.hstress').fadeIn(0);
            $('.hcinturon').fadeIn(0);
            $('.hpursuit').fadeIn(0);
            $('.hcompass').fadeIn(0);
            $('.hchip').fadeIn(0);
            $('.hshootmode').fadeIn(0);
            $('.hnitrous').fadeIn(0);
            $('.htiempous').fadeIn(0);
            return;
        } else {

        }
        $(".ui-container").css("display", Show);
        Progress(data.mic, ".mic");
        Progress(data.mic, ".mic2");
        if (data.talking) {
            $('.mic').css("stroke", "#ffeb3a");
            $('.micro').css("stroke", "#ffeb3a");
        }  else {
            $('.mic').css("stroke", "#ffff");
            $('.micro').css("stroke", "#ffff");
        }

        if (data.talking && !data.radioPush) {
            $('.mic2').css("stroke", "#ffeb3a");
            $('.micro2').css("stroke", "#ffeb3a");
        } else {
            $('.mic2').css("stroke", "#ffff");
            $('.micro2').css("stroke", "#ffff");
        }
        
        if (data.radio) {
            $('.hmic2').fadeIn(0);
            $('.hmic').fadeOut(0);
            if (data.radioPush) {
                $('.mic2').css("stroke", "#e1405a");
                $('.micro2').css("stroke", "#e1405a");
            }
        } else {
            $('.hmic').fadeIn(0);
            $('.hmic2').fadeOut(0);
        }

        if (data.health - 100 === 20) {
            Progress(0, ".hp");
        } else {
            Progress(data.health - 100, ".hp");
        }
        
        if (setHealOnOff) {
            if ( data.health / 2 <= chealth || chealth === 100) {
                $('.hvida').fadeIn(2500);
            } else if ( data.health / 2 >= chealth || setHealOnOff) {
                $('.hvida').fadeOut(2500);
            }
        } else {
            $('.hvida').fadeOut(2500);
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
            } else if ( data.armor / 2 >= carmor || setArmorOnOff) {
                $('.harmor').fadeOut(2500);
            }
        } else {
            $('.harmor').fadeOut(2500);
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
            } else if ( data.hunger / 2 >= cfood || setFoodOnOff) {
                $('.hhunger').fadeOut(2500);
            }
        } else {
            $('.hhunger').fadeOut(2500);
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
            } else if ( data.thirst / 2 >= cwater || setWateronOff) {
                $('.hthirst').fadeOut(2500);
            }
        } else {
            $('.hthirst').fadeOut(2500);
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
        } else {
            if (data.oxygen <= 95) {
                $('.hoxygen').fadeIn(2500);
            } else {
                $('.hoxygen').fadeOut(2500);
            }
        }
        if (data.oxygen <= 15) {
            $('.oxy').css("stroke", "red");
            $('.oxy').css("stroke-opacity", "1.0");
        } else {
            $('.oxy').css("stroke", "#90a4ae");
            $('.oxy').css("stroke-opacity", "0.3");
        }

        Progress(data.stress, ".stress");
        if (!setStressOnOff) {
            $('.hstress').hide();
        } else {
            if (data.stress >= 3) {
                $('.hstress').fadeIn(2500);
            }
            if (data.stress <= 2) {
                $('.hstress').fadeOut(2500);
            }
        }
        Progress(data.nitro, ".nitrous");
        if (data.nitro >= 3 && data.inVehicle && nitrolevel) {
            $(".hnitrous").fadeIn(2500);
            $(".nitrous").css({"stroke":"#e1405a"});
            if (data.nitron && nitroTrail) {
                document.getElementById('nos').classList.remove('nossymbol');
                document.getElementById('nos').classList.add('nossymbolon');
            } else {
                document.getElementById('nos').classList.remove('nossymbolon');
                document.getElementById('nos').classList.add('nossymbol');
            }
        } else {
            $(".hnitrous").fadeOut(2500);
        }  
        ProgressCasino(data.casino, ".tiempous");
        if (data.casino >= 1) {
            $(".htiempous").fadeIn(0);
        } else {
            $(".htiempous").fadeOut(0);
        }  
        Progress(data.cinturon, ".cinturon");
        if (data.cinturon <= 99) {
            $(".hcinturon").fadeIn(2500);
        } else {
            $(".hcinturon").fadeOut(2500);
        }
        Progress(data.pursuitmode, ".pursuit");
        if (data.pursuitmode >= 5) {
            $('.hpursuit').fadeIn(2500);
        } else {
            $('.hpursuit').fadeOut(2500);
        }
        Progress(data.shoot, ".shootmode");
        if (data.shoot >= 5) {
            $('.hshootmode').fadeIn(2500);
        } else {
            $('.hshootmode').fadeOut(2500);
        }
        Progress(data.chipmode, ".chip");
        if (data.chipmode >= 5) {
            $('.hchip').fadeIn(2500);
        } else {
            $('.hchip').fadeOut(2500);
        }
        Progress(data.hcompass, ".compass");
        if (data.ecompass) {
            $('.hcompass').fadeIn(2500);
        } else {
            $('.hcompass').fadeOut(2500);
        }
        Progress(data.dev, ".developer");  
        if (data.dev) {
            $('.hdeveloper').fadeIn(0);
        }
        else {
            $('.hdeveloper').fadeOut(0);
        }

        Progress(data.dev2, ".developer2");  
        if (data.dev2) {
            $('.hdeveloper2').fadeIn(0);
        }
        else {
            $('.hdeveloper2').fadeOut(0);
        }

        if (data.talking && data.radio) {
            $(".mic").css({"background-color": "#3467d4"}); 
        } else if (data.talking) {
            $(".mic").css({"background-color": "white"}); 
        } else {
            $(".mic").css({"background-color": "rgb(85, 85, 85)"}); 
        }
    };

    //window.onload = function(e) {
        window.addEventListener('message', function(event) {
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

                    $('#speedmeter').keyup(function(){
                        let fps_speed = $('#speedmeter').val();
                        $.post('https://np-hud/update:timer:speed',JSON.stringify({
                            fps_speed: fps_speed
                        }));
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

//function setProgressSpeed(value, element) {
 //   var circle = document.querySelector(element);
//    var radius = circle.r.baseVal.value;
 //   var circumference = radius * 2 * Math.PI;
  //  var html = $(element).parent().parent().find('span');
 //   var percent = value * 100 / 220;
//
 //   circle.style.strokeDasharray = `${circumference} ${circumference}`;
 //   circle.style.strokeDashoffset = `${circumference}`;
//
//    const offset = circumference - ((-percent * 50) / 100) / 100 * circumference;
 //   circle.style.strokeDashoffset = -offset;
//
//    var predkosc = Math.floor(value * 1.8)
 //   if (predkosc == 81 || predkosc == 131) {
 //       predkosc = predkosc - 1
 //   }
//
//    html.text(predkosc);
//}

function setProgressFuel(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent * 62) / 100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
}

function setProgressNos(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent * 62) / 100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
}
