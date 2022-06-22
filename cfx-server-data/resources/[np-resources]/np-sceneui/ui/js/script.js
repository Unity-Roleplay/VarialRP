var settings = {
    "date.format":"YYYY-MM-DD hh:mm:ss",
    "date.timezone": "America/New_York",
    "hud.blackbars.enabled": false,
    "hud.blackbars.size": 10,
    "hud.compass.enabled": true,
    "hud.compass.fps": 16,
    "hud.compass.roadnames.enabled": true,
    "hud.compass.time.enabled": false,
    "hud.crosshair.enabled": true,
    "hud.phone.wallpaper": "",
    "hud.presetSelected": 1,
    "hud.presets": [
        {
            "hud.blackbars.enabled": false,
            "hud.blackbars.size": 10,
            "hud.compass.enabled": true,
            "hud.compass.fps": 16,
            "hud.compass.roadnames.enabled": true,
            "hud.compass.time.enabled": false,
            "hud.crosshair.enabled": true,
            "hud.status.armor.enabled": true,
            "hud.status.armor.hide": 100,
            "hud.status.food.enabled":  true,
            "hud.status.food.hide": 100,
            "hud.status.health.enabled": true,
            "hud.status.health.hide": 100,
            "hud.status.oxygen.enabled": true,
            "hud.status.stress.enabled": true,
            "hud.status.water.enabled": true,
            "hud.status.water.hide": 100,
            "hud.vehicle.harness.enabled": true,
            "hud.vehicle.minimap.default": false,
            "hud.vehicle.minimap.enabled": true,
            "hud.vehicle.minimap.outline": false,
            "hud.vehicle.nitrous.arcadetrail": false,
            "hud.vehicle.nitrous.enabled": true,
            "hud.vehicle.speedometer.fps": 60,
        },
        {
            "hud.blackbars.enabled": false,
            "hud.blackbars.size": 10,
            "hud.compass.enabled": true,
            "hud.compass.fps": 16,
            "hud.compass.roadnames.enabled": true,
            "hud.compass.time.enabled": false,
            "hud.crosshair.enabled": true,
            "hud.status.armor.enabled": true,
            "hud.status.armor.hide": 100,
            "hud.status.food.enabled":  true,
            "hud.status.food.hide": 100,
            "hud.status.health.enabled": true,
            "hud.status.health.hide": 100,
            "hud.status.oxygen.enabled": true,
            "hud.status.stress.enabled": true,
            "hud.status.water.enabled": true,
            "hud.status.water.hide": 100,
            "hud.vehicle.harness.enabled": true,
            "hud.vehicle.minimap.default": false,
            "hud.vehicle.minimap.enabled": true,
            "hud.vehicle.minimap.outline": false,
            "hud.vehicle.nitrous.arcadetrail": false,
            "hud.vehicle.nitrous.enabled": true,
            "hud.vehicle.speedometer.fps": 60,
        },
        {
            "hud.blackbars.enabled": false,
            "hud.blackbars.size": 10,
            "hud.compass.enabled": true,
            "hud.compass.fps": 16,
            "hud.compass.roadnames.enabled": true,
            "hud.compass.time.enabled": false,
            "hud.crosshair.enabled": true,
            "hud.status.armor.enabled": true,
            "hud.status.armor.hide": 100,
            "hud.status.food.enabled":  true,
            "hud.status.food.hide": 100,
            "hud.status.health.enabled": true,
            "hud.status.health.hide": 100,
            "hud.status.oxygen.enabled": true,
            "hud.status.stress.enabled": true,
            "hud.status.water.enabled": true,
            "hud.status.water.hide": 100,
            "hud.vehicle.harness.enabled": true,
            "hud.vehicle.minimap.default": false,
            "hud.vehicle.minimap.enabled": true,
            "hud.vehicle.minimap.outline": false,
            "hud.vehicle.nitrous.arcadetrail": false,
            "hud.vehicle.nitrous.enabled": true,
            "hud.vehicle.speedometer.fps": 60,
        }
    ],
    "hud.status.armor.enabled": true,
    "hud.status.armor.hide": 100,
    "hud.status.food.enabled":  true,
    "hud.status.food.hide": 100,
    "hud.status.health.enabled": true,
    "hud.status.health.hide": 100,
    "hud.status.oxygen.enabled": true,
    "hud.status.stress.enabled": true,
    "hud.status.water.enabled": true,
    "hud.status.water.hide": 100,
    "hud.vehicle.harness.enabled": true,
    "hud.vehicle.minimap.default": false,
    "hud.vehicle.minimap.enabled": true,
    "hud.vehicle.minimap.outline": false,
    "hud.vehicle.nitrous.arcadetrail": false,
    "hud.vehicle.nitrous.enabled": true,
    "hud.vehicle.speedometer.fps": 60,
    "phone.images.enabled": true,
    "phone.notifications.email": true,
    "phone.notifications.sms": true,
    "phone.notifications.twatter": true,
    "phone.shell": "ios",
    "phone.volume": 0.8,
    "phone.wallpaper": "",
    "radio.clicks.incoming.enabled": true,
    "radio.clicks.outgoing.enabled": true,
    "radio.clicks.volume": 0.8,
    "radio.stereo.enabled": true,
    "radio.volume": 0.8,
    "rtc.settings.device": {},
    "rtc.settings.phone.filter.enabled": true,
    "rtc.settings.phone.filter.gainNode": 1,
    "rtc.settings.phone.filter.highpassBiquad": 500,
    "rtc.settings.phone.filter.lowpassBiquad": 8000,
    "rtc.settings.phone.filter.pannerNode": 0.4,
    "rtc.settings.radio.filter.enabled": true,
    "rtc.settings.radio.filter.gainNode": 1.5,
    "rtc.settings.radio.filter.highpassBiquad": 1000,
    "rtc.settings.radio.filter.lowpassBiquad": 2000,
    "rtc.settings.radio.filter.pannerNode": -0.39,
    "rtc.settings.radio.filter.waveShaper": 9,
    "rtc.system": {},
}

// New 

$(function() {
    sleep(5000,function(){
        $.post('https://np-sceneui/np-sceneui:getKVPValue', JSON.stringify({
            key : "np-preferences",
        }),function(result){

            for (const key in result.data.value) {
                settings[key] = result.data.value[key];
            }

            if (settings["hud.status.health.enabled"] == true) {
                $(".health").fadeIn(1000);
                document.getElementById("showheath").checked = true;
                document.querySelector('#valhealthmenu').classList.remove('hidden');
            }else if(settings["hud.status.health.enabled"] == false){
                $(".health").fadeOut(1000);
                document.getElementById("showheath").checked = false;
                document.querySelector('#valhealthmenu').classList.add('hidden');
            }

            if (settings["hud.status.armor.enabled"] == true) {
                $(".armor").fadeIn(1000);
                document.getElementById("showarmor").checked = true;
                document.querySelector('#valarmormenu').classList.remove('hidden');
            }else if(settings["hud.status.armor.enabled"] == false){
                $(".armor").fadeOut(1000);
                document.getElementById("showarmor").checked = false;
                document.querySelector('#valarmormenu').classList.add('hidden');
            }

            if (settings["hud.status.food.enabled"] == true) {
                $(".hunger").fadeIn(1000);
                document.getElementById("showfood").checked = true;
                document.querySelector('#valfoodmenu').classList.remove('hidden');
            }else if(settings["hud.status.food.enabled"] == false){
                $(".hunger").fadeOut(1000);
                document.getElementById("showfood").checked = false;
                document.querySelector('#valfoodmenu').classList.add('hidden');
            }

            if (settings["hud.status.water.enabled"] == true) {
                $(".thirst").fadeIn(1000);
                document.getElementById("showwater").checked = true;
                document.querySelector('#valwatermenu').classList.remove('hidden');
            }else if(settings["hud.status.water.enabled"] == false){
                $(".thirst").fadeOut(1000);
                document.getElementById("showwater").checked = false;
                document.querySelector('#valwatermenu').classList.add('hidden');
            }

            if (settings["hud.status.oxygen.enabled"] == true) {
                $(".oxygen").fadeIn(1000);
                document.getElementById("showoxygen").checked = true;
            }else if(settings["hud.status.oxygen.enabled"] == false){
                $(".oxygen").fadeOut(1000);
                document.getElementById("showoxygen").checked = false;
            }

            if (settings["hud.status.stress.enabled"] == true) {
                $(".stress").fadeIn(1000);
                document.getElementById("showstress").checked = true;
            }else if(settings["hud.status.stress.enabled"] == false){
                $(".stress").fadeOut(1000);
                document.getElementById("showstress").checked = false;
            }

            document.querySelector('#valhealth').value = settings["hud.status.health.hide"];
            document.querySelector('#valarmor').value = settings["hud.status.armor.hide"];
            document.querySelector('#valfood').value = settings["hud.status.food.hide"];
            document.querySelector('#valwater').value = settings["hud.status.water.hide"];

            //Vehicle
            //document.querySelector('.speedometerfps').value = settings["hud.vehicle.speedometer.fps"];
            //document.querySelector(".showminimap").checked = settings["hud.vehicle.minimap.enabled"];
            //document.querySelector(".showharness").checked = settings["hud.vehicle.harness.enabled"];
            //document.querySelector(".shownitrolevel").checked = settings["hud.vehicle.nitrous.enabled"];
            //document.querySelector(".shownitrotrail").checked = settings["hud.vehicle.nitrous.arcadetrail"];
            //document.querySelector(".minimapoutline").checked = settings["hud.vehicle.minimap.outline"];
            //document.querySelector(".defaultminimap").checked = settings["hud.vehicle.minimap.default"];

            //Compass
            document.querySelector('.compassfps').value = settings["hud.compass.fps"];
            document.querySelector(".showcompass").checked = settings["hud.compass.enabled"];
            document.querySelector(".showtimecompass").checked = settings["hud.compass.roadnames.enabled"];
            document.querySelector(".showstreetcompass").checked = settings["hud.compass.time.enabled"];

            $.post('https://np-sceneui/np-sceneui:hudSetPreferences', JSON.stringify(settings),function(result){
    
            });
        });
    });
});

// Hud Settings

//HUD Settings
$("#showheath").change(function(){
    switch (this.checked) {
        case true:
            settings["hud.status.health.enabled"] = true;
            document.querySelector('#valhealthmenu').classList.remove('hidden');
            $(".health").fadeIn(1000);
            break;
        case false:
            document.querySelector('#valhealthmenu').classList.add('hidden');
            settings["hud.status.health.enabled"] = false;
            $(".health").fadeOut(1000);
            break;
    }
});

$("#showarmor").change(function(){
    switch (this.checked) {
        case true:
            settings["hud.status.armor.enabled"] = true;
            document.querySelector('#valarmormenu').classList.remove('hidden');
            $(".armor").fadeIn(1000)
            break;
        case false:
            settings["hud.status.armor.enabled"] = false;
            document.querySelector('#valarmormenu').classList.add('hidden');
            $(".armor").fadeOut(1000)
            break;
    }
});

$("#showfood").change(function(){
    switch (this.checked) {
        case true:
            settings["hud.status.food.enabled"] = true;
            document.querySelector('#valfoodmenu').classList.remove('hidden');
            $(".hunger").fadeIn(1000)
            break;
        case false:
            settings["hud.status.food.enabled"] = false;
            document.querySelector('#valfoodmenu').classList.add('hidden');
            $(".hunger").fadeOut(1000)
            break;
    }
});

$("#showwater").change(function(){
    switch (this.checked) {
        case true:
            settings["hud.status.water.enabled"] = true;
            document.querySelector('#valwatermenu').classList.remove('hidden');
            $(".thirst").fadeIn(1000)
            break;
        case false:
            settings["hud.status.water.enabled"] = false;
            document.querySelector('#valwatermenu').classList.add('hidden');
            $(".thirst").fadeOut(1000)
            break;
    }
});

$("#showstress").change(function(){
    switch (this.checked) {
        case true:
            settings["hud.status.stress.enabled"] = true;
            $(".stress").fadeIn(1000)
            break;
        case false:
            settings["hud.status.stress.enabled"] = false;
            $(".stress").fadeOut(1000)
            break;
    }
});

$("#showoxygen").change(function(){
    switch (this.checked) {
        case true:
            settings["hud.status.oxygen.enabled"] = true;
            $(".oxygen").fadeIn(1000)
            break;
        case false:
            settings["hud.status.oxygen.enabled"] = false;
            $(".oxygen").fadeOut(1000)
            break;
    }
});

document.querySelector('#valhealth').addEventListener('change', function(e){
    if (!isNaN(e.target.value)) {
        settings["hud.status.health.hide"] = parseInt(e.target.value);
    }
});

document.querySelector('#valarmor').addEventListener('change', function(e){
    if (!isNaN(e.target.value)) {
        settings["hud.status.armor.hide"] = parseInt(e.target.value);
    }
});

document.querySelector('#valfood').addEventListener('change', function(e){
    if (!isNaN(e.target.value)) {
        settings["hud.status.food.hide"] = parseInt(e.target.value);
    }
});

document.querySelector('#valwater').addEventListener('change', function(e){
    if (!isNaN(e.target.value)) {
        settings["hud.status.water.hide"] = parseInt(e.target.value);
    }
});

// Vehicle
$(".showminimap").change(function(){
    switch (this.checked) {
        case true:
            settings["hud.vehicle.minimap.enabled"] = true;
            break;
        case false:
            settings["hud.vehicle.minimap.enabled"] = false;
            break;
    }
});

$(".defaultminimap").change(function(){
    switch (this.checked) {
        case true:
            settings["hud.vehicle.minimap.default"] = true;
            break;
        case false:
            settings["hud.vehicle.minimap.default"] = false;
            break;
    }
});

$(".minimapoutline").change(function(){
    switch (this.checked) {
        case true:
            settings["hud.vehicle.minimap.outline"] = true;
            break;
        case false:
            settings["hud.vehicle.minimap.outline"] = false;
            break;
    }
});

$(".showharness").change(function(){
    switch (this.checked) {
        case true:
            settings["hud.vehicle.harness.enabled"] = true;
            break;
        case false:
            settings["hud.vehicle.harness.enabled"] = false;
            break;
    }
});

$(".shownitrolevel").change(function(){
    switch (this.checked) {
        case true:
            settings["hud.vehicle.nitrous.enabled"] = true;
            break;
        case false:
            settings["hud.vehicle.nitrous.enabled"] = false;
            break;
    }
});

document.querySelector('#hudmenu').addEventListener('click', function(){
    $(".hud-settings-menu").show();
    $("#hudmenu").css("background","#202730");
    $("#phonemenu").css("background","#30475c");
    $("#radiomenu").css("background","#30475c");

});

document.querySelector('#phonemenu').addEventListener('click', function(){
    $(".hud-settings-menu").hide();
    $("#phonemenu").css("background","#202730");
    $("#hudmenu").css("background","#30475c");
    $("#radiomenu").css("background","#30475c");
});

document.querySelector('#radiomenu').addEventListener('click', function(){
    $(".hud-settings-menu").hide();
    $("#radiomenu").css("background","#202730");
    $("#phonemenu").css("background","#30475c");
    $("#hudmenu").css("background","#30475c");
});

document.querySelector('#setting_hud_save').addEventListener('click', function(){
    var presetselect = parseInt(document.querySelector('.presetid').value);
    settings["hud.presetSelected"] = presetselect;
    var idx = presetselect - 1;
    for (const key in settings) {
        for (const key2 in settings["hud.presets"][idx]) {
            if (key2 == key) {
                settings["hud.presets"][idx][key2] = settings[key]
            }
        }
    }

    $.post('https://np-sceneui/np-sceneui:setKVPValue', JSON.stringify({
        key : "np-preferences",
        value:settings
    }),function(res){
        console.log("Get Callback SetKvp")
        $.post('https://np-sceneui/np-sceneui:hudSetPreferences', JSON.stringify(settings),function(result){
    
        });
    });
});


let playsomesound = {}
function playfuncsound(id,name,loop,volume) {
    playsomesound[id] = new Howl({
        src: ['../media/'+name+'.ogg'],
        loop: loop,
        volume: volume,
        // onend: function () {
        //     console.log('Finished!',name);
        // }
    });
    playsomesound[id].play();
}

function playfunsoundsetvolume(id,vol) {
    playsomesound[id].volume(vol);
}

function stopplayfunsound(id) {
    playsomesound[id].stop();
}

class minigame_captcha{
    range = (start, end, length = end - start + 1) => {
        return Array.from({ length }, (_, i) => start + i)
    }
    random = (min, max) => {
        return Math.floor(Math.random() * (max - min)) + min;
    }
    shuffle = (arr) => {
        for (let i = arr.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            const temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }
    }
    
    shapes = ['square', 'rectangle', 'circle', 'triangle'];
    colors = ['blue', 'green', 'red', 'orange', 'yellow', 'purple', 'black', 'white'];
    types = [
        {'type': 'shape','text': 'SHAPE'},
        {'type': 'shape_color','text': 'SHAPE COLOR'},
        {'type': 'text_color','text': 'TEXT COLOR'},
        {'type': 'text_shape','text': 'SHAPE TEXT'},
        {'type': 'text_bg_color','text': 'TEXT BACKGROUND COLOR'},
        {'type': 'background_color','text': 'BACKGROUND COLOR'},
        {'type': 'number_color','text': 'NUMBER COLOR'}
    ];

    create(numberask){
        let real_numbers, impostor_numbers, minigame, group, background_colors, types, quiz_numbers;

        real_numbers = this.range(1, numberask);
        this.shuffle(real_numbers);

        impostor_numbers = this.range(1, numberask);
        this.shuffle(impostor_numbers);

        minigame = {
            'real_numbers': real_numbers,
            'impostor_numbers': impostor_numbers,
            'groupscaptcha': []
        };

        for(let i = 0; i < numberask; i++){
            group = [];

            background_colors = this.colors;
            this.shuffle(background_colors);

            group['real_number'] = real_numbers[i];
            group['impostor_number'] = impostor_numbers[i];

            group['shape'] = this.shapes[this.random(0, this.shapes.length)];
            group['background_color'] = background_colors[0];
            group['shape_color'] = background_colors[1];
            group['text_bg_color'] = this.colors[this.random(0, this.colors.length)];
            group['number_color'] = this.colors[this.random(0, this.colors.length)];

            group['text_shape'] = this.shapes[this.random(0, this.shapes.length)];
            group['text_color'] = this.colors[this.random(0, this.colors.length)];

            minigame['groupscaptcha'].push(group);
        }

        quiz_numbers = this.range(0, (numberask - 1));
        this.shuffle(quiz_numbers);

        types = this.types;
        this.shuffle(types);

        minigame['quiz1'] = {
            'pos': quiz_numbers[0],
            'type': types[0],
            'solution': minigame['groupscaptcha'][quiz_numbers[0]][types[0]['type']]
        };

        minigame['quiz2'] = {
            'pos': quiz_numbers[1],
            'type': types[1],
            'solution': minigame['groupscaptcha'][quiz_numbers[1]][types[1]['type']]
        };

        minigame['solution'] = minigame['groupscaptcha'][quiz_numbers[0]][types[0]['type']] +
            ' ' + minigame['groupscaptcha'][quiz_numbers[1]][types[1]['type']];

        return minigame;
    }
}

let timer_start_captcha_game, timer_numbers_captcha_game, timer_game_captcha, timer_splash_captcha, data_captcha, durationGame_captcha, roundTotal_captcha, asktotal, minigame_captcha_endpoint;
let mode = 'vault';
let minigame = new minigame_captcha();
let streakcaptcha = 0;

let sleep = (ms, fn) => {return setTimeout(fn, ms)};

let audio_splash = document.querySelector('.splashcaptcha audio');
let audio_timer = document.querySelector('.timer audio');

// Options

// Process answer
document.querySelector('#answer').addEventListener('keydown', function(e) {
    if (e.key === 'Enter' && document.querySelector('.solution').offsetHeight === 0) {
        clearTimeout(timer_game_captcha);
        audio_timer.pause();

        const answer = e.target.value.toLowerCase().trim();
        let wrapper = document.querySelector('.answer-wrapper');
        if(data_captcha.solution === answer){
            wrapper.classList.remove('wrong');
            wrapper.classList.add('right');
            streakcaptcha++;
            //Success
            // console.log(mode,streak,roundTotal_captcha)
            if( (mode === 'vault' && streakcaptcha === roundTotal_captcha) ){
                streakcaptcha = 0;
                splash_screenminigamecaptcha();
                //document.querySelector('.splashcaptcha .icon .fa').innerHTML = '&#xf21b;';
                document.querySelector('.splashcaptcha .message').innerText = "The system has been bypassed.";
                sleep(5000, function(){ 
                    document.querySelector('.minigamecaptcha').classList.add('hidden');
                    $.post('https://np-sceneui/'+minigame_captcha_endpoint, JSON.stringify({
                        result : true
                    }));
                });
            }else{
                resetminigamecaptcha(false);
            }
        }else{
            //Failed
            streakcaptcha = 0;
            splash_screenminigamecaptcha();
            //document.querySelector('.splashcaptcha .icon .fa').innerHTML = '&#xf05e;';
            document.querySelector('.splashcaptcha .message').innerText = "The system didn't accept your answer";
            sleep(5000, function(){ 
                document.querySelector('.minigamecaptcha').classList.add('hidden');
                $.post('https://np-sceneui/'+minigame_captcha_endpoint, JSON.stringify({
                    result : false
                }));
            });
        }
    }
});

let splash_screenminigamecaptcha = (show = true) => {
    if(show){
        document.querySelectorAll('.groupscaptcha, .inputs').forEach(el => {el.classList.add('hidden');});
        document.querySelector('.splashcaptcha').classList.remove('hidden');
    }else{
        document.querySelector('.splashcaptcha').classList.add('hidden');
        document.querySelectorAll('.groupscaptcha').forEach(el => {el.classList.remove('hidden');});
    }
}

let resetminigamecaptcha = (gameDuration , gameRoundsTotal, ask) => {
    if (gameDuration) {
        $(".groupscaptcha").html("")
        for (let i = 0; i < ask; i++) {
            $(".groupscaptcha").append('<div class="groupcaptcha"><div class="real_number">&nbsp;</div><div class="shape hidden"></div><div class="text hidden">&nbsp;</div><div class="number hidden">&nbsp;</div></div>');
        }
    }
    
    document.querySelector('.minigamecaptcha').classList.remove('hidden');
    clearTimeout(timer_start_captcha_game);
    clearTimeout(timer_numbers_captcha_game );
    clearTimeout(timer_game_captcha);
    clearTimeout(timer_splash_captcha);

    audio_splash.pause();
    audio_splash.currentTime = 0;

    audio_timer.pause();
    audio_timer.currentTime = 0;

    document.querySelectorAll('.real_number').forEach(el => {
        el.innerHTML = '&nbsp;';
        el.style.fontSize = '190px';
        el.classList.remove('hidden');
    });
    document.querySelectorAll('.groupscaptcha .shape, .groupscaptcha .text, .groupscaptcha .number, .inputs').forEach(el => {
        el.classList.add('hidden');
    });
    document.querySelectorAll('.groupcaptcha .shape').forEach(el => {
        minigame.shapes.forEach(shape => {
            el.classList.remove(shape);
        });
    });
    document.querySelectorAll('.groupcaptcha, .groupcaptcha div, .groupcaptcha .shape').forEach(el => {
        el.classList.forEach(cl => {
            if( /^(bg_|txt_)/.test(cl) ) {
                el.classList.remove(cl);
            }
        });
    });

    document.querySelector(".progress-bar").style.width = '100%';

    document.querySelector('.answer-wrapper').classList.remove('wrong', 'right')
    document.querySelector('#answer').value = '';

    if(gameDuration){
        durationGame_captcha = gameDuration
        roundTotal_captcha = gameRoundsTotal;
        asktotal = ask;
        splashminigamecaptcha();
    }else{
        startminigamecaptcha(asktotal);
    }
}

let startminigamecaptcha = (askt) => {
    data_captcha = minigame.create(askt);
    console.log(data_captcha.solution)
    data_captcha.groupscaptcha.forEach(function(group, i) {
        let g = document.querySelectorAll('.groupscaptcha .groupcaptcha')[i];
        g.classList.add('bg_'+group.background_color);
        g.querySelector('.real_number').innerHTML = group.real_number;
        g.querySelector('.shape').classList.add(group.shape, 'bg_'+group.shape_color);
        g.querySelector('.text').classList.add('txt_'+group.text_bg_color);
        g.querySelector('.text').innerHTML = group.text_color+'<br>'+group.text_shape;
        g.querySelector('.number').classList.add('txt_'+group.number_color);
        g.querySelector('.number').innerHTML = group.impostor_number;
    });

    document.querySelector('.quiz1').innerHTML = data_captcha.quiz1.type.text + ' ('+data_captcha['real_numbers'][data_captcha.quiz1.pos]+')';
    document.querySelector('.quiz2').innerHTML = data_captcha.quiz2.type.text + ' ('+data_captcha['real_numbers'][data_captcha.quiz2.pos]+')';


    timer_start_captcha_game = sleep(1000, function(){
        document.querySelectorAll('.real_number').forEach(el => {el.style.fontSize = '0px';});
        timer_numbers_captcha_game = sleep(2000, function(){
            document.querySelectorAll('.real_number').forEach(el => {el.classList.add('hidden');});
            document.querySelectorAll('.groupscaptcha .shape, .groupscaptcha .text, .groupscaptcha .number, .inputs').forEach(
                el => {el.classList.remove('hidden');});
                audio_timer.play();
            document.querySelector('#answer').focus({preventScroll: true});

            
            document.querySelector(".progress-bar").style.transition = 'width '+(durationGame_captcha / 1000)+'s linear';
            document.querySelector(".progress-bar").style.width = '0';
            // console.log("Timer for end",durationGame_captcha)
            timer_game_captcha = sleep(durationGame_captcha, function(){
                //This if Timer habis
                streakcaptcha = 0;
                audio_timer.pause();
                splash_screenminigamecaptcha();
                //document.querySelector('.splashcaptcha .icon .fa').innerHTML = '&#xf05e;';
                document.querySelector('.splashcaptcha .message').innerText = "The system didn't accept your answer";
                sleep(5000, function(){ 
                    document.querySelector('.minigamecaptcha').classList.add('hidden');
                    $.post('https://np-sceneui/'+minigame_captcha_endpoint, JSON.stringify({
                        result : false
                    }));
                });
            });
        });
    });
}

let splashminigamecaptcha = () => {
    splash_screenminigamecaptcha();
    //document.querySelector('.splashcaptcha .icon .fa').innerHTML = '&#xf21b;';
    document.querySelector('.splashcaptcha .message').innerText = 'Device booting up...';
    timer_splash_captcha = sleep(3000, function(){
        document.querySelector('.splashcaptcha .message').innerText = 'Dialing...';
        audio_splash.play();
        timer_splash_captcha = sleep(8000, function(){
            document.querySelector('.splashcaptcha .message').innerText = 'Establishing connection...';

            timer_splash_captcha = sleep(6000, function(){
                document.querySelector('.splashcaptcha .message').innerText = 'Doing some hackermans stuff...';

                timer_splash_captcha = sleep(6000, function(){
                    document.querySelector('.splashcaptcha .message').innerText = 'Access code flagged; requires human captcha input...';

                    timer_splash_captcha = sleep(6000, function(){
                        document.querySelector('.splashcaptcha').classList.add('hidden');
                        document.querySelector('.groupscaptcha').classList.remove('hidden');
                        startminigamecaptcha(asktotal);
                    });
                });
            });
        });
    });
}

// resetminigamecaptcha(9500,2,4) //Testing
// resetminigamecaptcha(9500,6,3)

// Skilbar Think
let skillbaractive = false
let canvas_skillbar = document.getElementById("skillbarcanvas");
let ctx = canvas_skillbar.getContext("2d");

let W = canvas_skillbar.width;
let H = canvas_skillbar.height;
let degrees_skillbar = 0;
let new_degrees_skillbar = 0;
let time = 0;
let colorskillbar = "#ffffff";
let bgcolorskillbar = "#404b58";
let bgcolor2skillbar = "#41a491";
let key_to_press_skillbar;
let g_start_skillbar, g_end_skillbar;
let animation_loop_skillbar;

function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1) + min); //The maximum is inclusive and the minimum is inclusive
}

function init_skillbar() {
    // Clear the canvas every time a chart is drawn
    ctx.clearRect(0,0,W,H);

    // Background 360 degree arc
    ctx.beginPath();
    ctx.strokeStyle = bgcolorskillbar;
    ctx.lineWidth = 20;
    ctx.arc(W / 2, H / 2, 100, 0, Math.PI * 2, false);
    ctx.stroke();

    // Green zone
    ctx.beginPath();
    ctx.strokeStyle = bgcolor2skillbar;
    ctx.lineWidth = 20;
    ctx.arc(W / 2, H / 2, 100, g_start_skillbar - 90 * Math.PI / 180, g_end_skillbar - 90 * Math.PI / 180, false);
    ctx.stroke();

    // Angle in radians = angle in degrees * PI / 180
    let radians = degrees_skillbar * Math.PI / 180;
    ctx.beginPath();
    ctx.strokeStyle = colorskillbar;
    ctx.lineWidth = 20;
    ctx.arc(W / 2, H / 2, 100, 0 - 90 * Math.PI / 180, radians - 90 * Math.PI / 180, false);
    ctx.stroke();

    // Adding the key_to_press
    ctx.fillStyle = colorskillbar;
    ctx.font = "100px sans-serif";
    let text_width = ctx.measureText(key_to_press_skillbar).width;
    ctx.fillText(key_to_press_skillbar, W / 2 - text_width / 2, H / 2 + 35);
}

function draw_skillbar(duration,level) {
    $(".skillbar").show()
    skillbaractive = true
    if (typeof animation_loop_skillbar !== undefined) clearInterval(animation_loop_skillbar);

    g_start_skillbar = getRandomInt(20,40) / 10;
    g_end_skillbar = getRandomInt(5,10) / 10;
    g_end_skillbar = g_start_skillbar + g_end_skillbar;

    degrees_skillbar = 0;
    new_degrees_skillbar = 360;

    key_to_press_skillbar = ''+getRandomInt(1,4);

    time = (duration / 1000 ) * 3;

    animation_loop_skillbar = setInterval(animate_to, time);
}

function animate_to() {
    if (degrees_skillbar >= new_degrees_skillbar) {
        wrong_skillbar();
        return;
    }

    degrees_skillbar++;
    init_skillbar();
}

function correct_skillbar(){
    $(".skillbar").hide()
    clearInterval(animation_loop_skillbar);
    skillbaractive = false
    $.post('https://np-sceneui/np-sceneui:taskBarSkillResult', JSON.stringify({
        success: true,
    }));
}

function wrong_skillbar(){
    $(".skillbar").hide()
    clearInterval(animation_loop_skillbar);
    skillbaractive = false
    $.post('https://np-sceneui/np-sceneui:taskBarSkillResult', JSON.stringify({
        success: false,
    }));
}

document.addEventListener("keydown", function(ev) {
    if (skillbaractive) {
        let key_pressed = ev.key;
        let valid_keys = ['1','2','3','4'];

        if (valid_keys.includes(key_pressed)) {
            if (key_pressed === key_to_press_skillbar) {
                let d_start = (180 / Math.PI) * g_start_skillbar;
                let d_end = (180 / Math.PI) * g_end_skillbar;
                if (degrees_skillbar < d_start) {
                    console.log('Failed: Too soon!');
                    wrong_skillbar();
                } else if (degrees_skillbar > d_end) {
                    console.log('Failed: Too late!');
                    wrong_skillbar();
                } else {
                    console.log('Success!');
                    correct_skillbar();
                }
            } else {
                console.log('Failed: Pressed '+key_pressed+' instead of '+key_to_press_skillbar);
                wrong_skillbar();
            }
        }
    }
});

//Testing
// draw_skillbar(10000,15);

//Memory Minigame Think
let timer_start, timer_game, timer_finish, timer_time, good_positions, wrong, right, speed, timerStart, minigame_memory_endpoint;
let game_started = false;

const range = (start, end, length = end - start + 1) => {
    return Array.from({length}, (_, i) => start + i)
}

const shuffle = (arr) => {
    for (let i = arr.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        const temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}

let positions = range(0, 35);

function listener(ev){
    if(!game_started) return;

    if( good_positions.indexOf( parseInt(ev.target.dataset.position) ) === -1 ){
        wrong++;
        ev.target.classList.add('bad');
    }else{
        right++;
        ev.target.classList.add('good');
    }

    ev.target.removeEventListener('mousedown', listener);

    check();
}

function addListeners(){
    document.querySelectorAll('.group_memory').forEach(el => {
        el.addEventListener('mousedown', listener);
    });
}

function check(){
    if(wrong === 3){
        resetTimer();
        game_started = false;

        let blocks = document.querySelectorAll('.group_memory');
        good_positions.forEach( pos => {
            blocks[pos].classList.add('proper');
        });
        reset(false);
        return;
    }
    if(right === 14){
        stopTimer();
        console.log("Succcess")
        reset(true);
    }
}

function reset(checked){
    game_started = false;

    resetTimer();
    clearTimeout(timer_start);
    clearTimeout(timer_game);
    clearTimeout(timer_finish);

    document.querySelector('.splash_memory').classList.remove('hidden');
    document.querySelector('.groups_memory').classList.add('hidden');

    document.querySelectorAll('.group_memory').forEach(el => { el.remove(); });

    if (checked) {
        //Send hasil success or true
        document.querySelector('.groups_memory').classList.add('hidden');
        $(".splash_memory").html("<div class='fa hacker_memmory'>&#xf21b;</div>Remote Sequencing Complete");
        document.querySelector('.splash_memory').classList.remove('hidden');
        
        console.log("Success")
        sleep(4000, function(){
            document.querySelector('.minigame_memory').classList.add('hidden');
            $.post('https://np-sceneui/'+minigame_memory_endpoint, JSON.stringify({
                result : true
            }));
        })
    }else{
        //Send hasil Fail or false
        document.querySelector('.groups_memory').classList.add('hidden');
        $(".splash_memory").html("<div class='fa hacker_memmory'>&#xf21b;</div>Remote Sequencing Failed");
        document.querySelector('.splash_memory').classList.remove('hidden');
        console.log("Failed")
        sleep(4000, function(){
            document.querySelector('.minigame_memory').classList.add('hidden');
            $.post('https://np-sceneui/'+minigame_memory_endpoint, JSON.stringify({
                result : false
            }));
        })
    }
}

function start_memorygame(duration){
    $(".splash_memory").html("<div class='fa hacker_memmory'>&#xf21b;</div>Remote Sequencing Required");
    document.querySelector('.minigame_memory').classList.remove('hidden');
    wrong = 0;
    right = 0;

    shuffle(positions);
    good_positions = positions.slice(0, 14);

    let div = document.createElement('div');
    div.classList.add('group_memory');
    const groups = document.querySelector('.groups_memory');
    for(let i=0; i<36; i++){
        let group = div.cloneNode();
        group.dataset.position = i.toString();
        groups.appendChild(group);
    }

    addListeners();

    timer_start = sleep(4000, function(){
        document.querySelector('.splash_memory').classList.add('hidden');
        document.querySelector('.groups_memory').classList.remove('hidden');

        let blocks = document.querySelectorAll('.group_memory');
        good_positions.forEach( pos => {
            blocks[pos].classList.add('good');
        });

        timer_game = sleep(4000, function(){
            document.querySelectorAll('.group_memory.good').forEach(el => { el.classList.remove('good')});
            game_started = true;

            startTimer();
            // speed = document.querySelector('#speed').value;
            timer_finish = sleep((duration * 1000), function(){
                game_started = false;
                wrong = 3;
                check();
            });
        });
    });
}

function startTimer(){
    timerStart = new Date();
    timer_time = setInterval(timer,1);
}
function timer(){
    let timerNow = new Date();
    let timerDiff = new Date();
    timerDiff.setTime(timerNow - timerStart);
    let ms = timerDiff.getMilliseconds();
    let sec = timerDiff.getSeconds();
    if (ms < 10) {ms = "00"+ms;}else if (ms < 100) {ms = "0"+ms;}
}
function stopTimer(){
    clearInterval(timer_time);
}
function resetTimer(){
    clearInterval(timer_time);
}

// start_memorygame(10);

function showbadgepd(data) {
    $(".badge-app-wrapper").html("");
    $(".badge-app-wrapper").html('<div class="exterior-wrapper" >'+
        '<div class="interior-wrapper" >'+
            '<div class="row">'+
                '<div class="column">'+
                    '<div class="left-column" >'+
                        '<div class="information-wrapper">'+
                            '<div class="information">'+
                                '<div class="profile-image-holder">'+
                                    '<img src="./images/badge/'+data.image+'.png" alt="">'+ //thhis can using link or make in folder for image 
                                '</div>'+
                                '<div class="name-info">'+
                                    '<div class="banner">'+data.department+'</div>'+
                                    '<div class="name-info-wrap">'+
                                        '<p>'+data.rank+'</p>'+
                                        '<p>'+data.name+'</p>'+
                                    '</div>'+
                                    '<div class="callsign">'+
                                        '<p>#Nopixel</p>'+
                                    '</div>'+
                                '</div>'+
                            '</div>'+
                        '</div>'+
                    '</div>'+
                '</div>'+
                '<div class="column">'+
                    '<div class="right-column">'+
                        '<div class="badge-wrapper">'+
                            '<div class="badge"></div>'+
                        '</div>'+
                    '</div>'+
                '</div>'+
            '</div>'+
        '</div>'+
    '</div>');
    $(".badge").css("background-image",'url("../images/badge/'+data.badge+'.png")');
    document.querySelector('.badge-app-wrapper').classList.remove('hidden');
}

function vehmenuselect() {
    console.log("Test This Me Select menu Category")
}

//Showroom Think
var scrollAmount = 0
var carfulldata
document.querySelector('.btn.next').addEventListener('click', function(){
    scrollAmount = scrollAmount + 325
    $('.showcase').animate({scrollLeft:scrollAmount});
});

document.querySelector('.btn.prev').addEventListener('click', function(){
    scrollAmount = scrollAmount - 325
    $('.showcase').animate({scrollLeft:scrollAmount});
});

//Hud Think
function setHud(id, value) {
    const val = 100 - value
    $(".incomplete-" + id).css("stroke-dashoffset", val);
}

//News papper
function setdatanewspapper(data){
    $("#lockpicknews").html("");
    $("#drugnews").html("");
    $("#upcomingnews").html("");
    $("#electionsnews").html("");
    if (data.drugs) {
        for (let index = 0; index < data.drugs.length; index++) {
            $("#drugnews").append("<div class='headline'>Drugs</div>"+
            "<div class='subheadline'>by Chips Ahoy</div>"+
            "<div class='column-content'>Tsahalsjlakjkajsljsa</div>")
        }
    }

    if (data.upcoming) {
        for (let index = 0; index < data.upcoming.length; index++) {
            $("")
        }
    }

    if (data.electrons) {
        for (let index = 0; index < data.electrons.length; index++) {
            
        }
    }
}

//Minigame Numbers
let timer_start_numbers, timer_game_numbers, timer_finish_numbers, timer_time_numbers, answer_numbers,gameFinishedEndpointNumbers;
let game_started_numbers = false;

const rangeNumbers = (length = 1) => {
    return Array.from({length}, _ => Math.floor(Math.random() * 10))
}

document.querySelector('.minigamenumbers .numbers').addEventListener('keydown', function(e) {
    if (game_started_numbers == true) {
        if (e.ctrlKey === true && e.key === 'c'){
            console.log('Low tier cheater WeirdChamp');
            e.preventDefault();
            return false;
        }
    }
    
});
document.querySelector('#answernumbers').addEventListener('keydown', function(e) {
    if (game_started_numbers == true) {
        if (e.ctrlKey === true && e.key === 'v'){
            console.log('Low tier cheater WeirdChamp');
            e.preventDefault();
            return false;
        }
        if (e.key === 'Enter' && document.querySelector('.solution').offsetHeight === 0) {
            clearTimeout(timer_finish_numbers);
            checkanswernumbers();
        }
    }
    
});
document.querySelector('#answernumbers').addEventListener('drop', function(e) {
    console.log('Low tier cheater WeirdChamp');
    e.preventDefault();
    return false;
});

function checkanswernumbers(){
    stopTimer();

    let response = document.querySelector('#answernumbers').value.toLowerCase().trim();

    if(game_started_numbers && response === answer_numbers.join('')){
        console.log("Success")
        clearTimeout(timer_start_numbers);
        clearTimeout(timer_game_numbers);
        clearTimeout(timer_finish_numbers);
        
        document.querySelector('.splashnumbers').classList.remove('hidden');
        document.querySelector('.minigamenumbers .numbers').classList.add('hidden');
        document.querySelector('.minigamenumbers .inputnumbers').classList.add('hidden');
        $(".splashnumbers").html("<div class='fa hacker'>&#xf21b;</div>Password Correct");
        sleep(3000, function(){
            document.querySelector('.minigamenumbers').classList.add('hidden');
            $.post('https://np-sceneui/'+gameFinishedEndpointNumbers, JSON.stringify({
                success : true
            }));
        });
    }else{
        console.log("Failed");
        clearTimeout(timer_start_numbers);
        clearTimeout(timer_game_numbers);
        clearTimeout(timer_finish_numbers);
        document.querySelector('.splashnumbers').classList.remove('hidden');
        document.querySelector('.minigamenumbers .numbers').classList.add('hidden');
        document.querySelector('.minigamenumbers .inputnumbers').classList.add('hidden');
        $(".splashnumbers").html("<div class='fa hacker'>&#xf21b;</div>Password Incorrect");
        sleep(3000, function(){
            document.querySelector('.minigamenumbers').classList.add('hidden');
            $.post('https://np-sceneui/'+gameFinishedEndpointNumbers, JSON.stringify({
                success : false
            }));
        });
    }
}

function startminigamenumbers(gameTimeoutDuration,numberOfDigits,endPoint){
    gameFinishedEndpointNumbers = endPoint
    document.querySelector('.minigamenumbers').classList.remove('hidden');
    document.querySelector('#answernumbers').value = '';
    answer_numbers = rangeNumbers(numberOfDigits);
    document.querySelector('.minigamenumbers .numbers').innerHTML = answer_numbers.join('');

    timer_start_numbers = sleep(2000, function(){
        document.querySelector('.splashnumbers').classList.add('hidden');
        document.querySelector('.minigamenumbers .numbers').classList.remove('hidden');

        timer_game_numbers = sleep(3000, function(){
            document.querySelector('.minigamenumbers .numbers').classList.add('hidden');
            document.querySelector('.minigamenumbers .inputnumbers').classList.remove('hidden');
            setHud("health",80)
            game_started_numbers = true;
            document.querySelector('#answernumbers').focus({preventScroll: true});
            timer_finish_numbers = sleep(gameTimeoutDuration, function(){
                game_started_numbers = false;
                checkanswernumbers();
            });
        });
    });
}

// startminigamenumbers(14000,12);

//progbar event
let progbarp = 0
let curTask;
let progbarloop;

function animatprogbar(){
    $("#progress-bar").css("width", progbarp+"%");
}

function drawprogbar(duration,label,taskid){
    curTask = taskid
    $(".nicesexytext").html(label);
    if (typeof progbarloop !== undefined) clearInterval(progbarloop);
    const timeprog = (duration / 1000) * 10;
    progbarloop = setInterval(animateprog_to, timeprog);
}

function animateprog_to(){
    if (progbarp === 100) {
        clearInterval(progbarloop);
        progbarp = 0;
        // $("#progress-bar").css("width", "0%");
        console.log("Success")
        return
    }
    progbarp++;
    animatprogbar()
}
//End progbar event

// Textbox //
var textCallback;
var textData = {};
var textKey;
var textActive = false;

function buildTextBox(pData) {
    textActive = true
    textCallback = pData.callbackUrl
    textKey = pData.key
    $(".body-textbox").html("");
    for (const key in pData.items) {
        textData[pData.items[key].name] = null
        if (pData.items[key]._type) {
            if (pData.items[key]._type == "select") {
                $(".body-textbox").append('<label>'+pData.items[key].label+'</label>'+
                '<div class="flex-row" style="padding-top: 1vh; padding-bottom: 1vh;">'+
                    '<i class="fas fa-'+pData.items[key].icon+'" style="position: absolute;"></i>'+
                    '<select id="textbox_'+pData.items[key].name+'" style="padding-left: 2vh;"></select>'+
                '</div>');
                var selectobj = document.getElementById('textbox_'+pData.items[key].name);
                for (const keyj in pData.items[key].options) {
                    var opt = document.createElement('option');
                    opt.value = pData.items[key].options[keyj].id;
                    opt.innerHTML = pData.items[key].options[keyj].name;
                    selectobj.appendChild(opt);
                }
            }
        }else{
            $(".body-textbox").append('<label>'+pData.items[key].label+'</label>'+
            '<div class="flex-row" style="padding-top: 1vh; padding-bottom: 1vh;">'+
                '<i class="fas fa-'+pData.items[key].icon+'" style="position: absolute; padding-bottom: 1.2vh;"></i>'+
                '<input type="text" id="textbox_'+pData.items[key].name+'" style="width: 100%;">'+
            '</div>');
        }
    }
    $(".root-wrapper-textbox").css("display","block");
}

document.querySelector('#textbox_submit').addEventListener('click', function(){
    for (const key in textData) {
        textData[key] = document.querySelector('#textbox_'+key).value;
    }
    $.post('https://np-sceneui/np-sceneui:closeApp', JSON.stringify({}),function(res){
        $.post('https://np-sceneui/'+textCallback, JSON.stringify({
            key : textKey,
            values : textData,
        }),function(cb){
            textCallback = null;
            textKey = null;
            textData = {};
            textActive = false;
            $(".root-wrapper-textbox").css("display","none");
            $.post('https://np-sceneui/np-sceneui:applicationClosed', JSON.stringify({
                name : "textbox",
                fromEscape : false
            }));
        });
    });  
});
// Textbox //

// Context //
var contextData = {};
var contextActive = false;

function buildContextMenu(pData) {
    contextActive = true;
    $(".buttons-context").html("");
    if (pData.position == "right") {
        document.querySelector('.container-context').classList.remove('context-menu-left');
        document.querySelector('.container-context').classList.add('context-menu-right');
    }else if(pData.position == "left"){
        document.querySelector('.container-context').classList.remove('context-menu-right');
        document.querySelector('.container-context').classList.add('context-menu-left');
    }
    contextData = pData.options;
    for (const key in pData.options) {
        $(".buttons-context").append('<div class="button-context" id="contextmenu-'+key+'"><div class="title-context" id="contextmenu-'+key+'">'+pData.options[key].title+'</div></div>');
        if (pData.options[key].description) {
            $("#contextmenu-"+key).append('<div class="description-context" id="contextmenu-'+key+'">'+pData.options[key].description+'</div>');
        }
        $("#contextmenu-"+key).data("action",pData.options[key].action);
        $("#contextmenu-"+key).data("key",pData.options[key].key);
        $("#contextmenu-"+key).data("children",pData.options[key].children)
    }
    $(".container-context").css("display","block");
}

$(document).click(function(event){
    let $target = $(event.target);
    if ($target.closest('.button-context').length && $('.button-context').is(":visible")) {
        if (event.target.id == "backmenu") {
            $(".buttons-context").html("");
            $.each(contextData, function (index1, item1) {
                if (item1.children) {
                    $(".buttons-context").append('<div class="button-context" id="contextmenu-'+index1+'"><div class="title-context" id="contextmenu-'+index1+'">'+item1.title+'</div><div class="description-context" id="contextmenu-'+index1+'">'+item1.description+'</div></div>');
                    $("#contextmenu-"+index1).data("action",item1.action);
                    $("#contextmenu-"+index1).data("key",item1.key);
                    $("#contextmenu-"+index1).data("children",item1.children);
                }else{
                    $(".buttons-context").append('<div class="button-context" id="contextmenu-'+index1+'"><div class="title-context" id="contextmenu-'+index1+'">'+item1.title+'</div><div class="description-context" id="contextmenu-'+index1+'">'+item1.description+'</div></div>');
                    $("#contextmenu-"+index1).data("action",item1.action);
                    $("#contextmenu-"+index1).data("key",item1.key);
                    $("#contextmenu-"+index1).data("children",null);
                }
            })
        }else{
            if (event.target.id.split("-")[0] === 'contextmenu') {
                let action = $("#"+event.target.id).data('action');
                let key = $("#"+event.target.id).data('key');
                let children = $("#"+event.target.id).data('children');
                if (action) {
                    if (children) {
                        console.log("Have Child")
                        $.post('https://np-sceneui/'+action, JSON.stringify({
                            key:key
                        }));
                    }else{
                        contextActive = false;
                        $(".buttons-context").html("");
                        //$(".container-context").hide();
                        contextData = {};
                        $.post('https://np-sceneui/np-sceneui:closeApp', JSON.stringify({}),function (res) { 
                            $.post('https://np-sceneui/'+action, JSON.stringify({
                                key:key
                            }))
                            $.post('https://np-sceneui/np-sceneui:applicationClosed', JSON.stringify({
                                name : "contextmenu",
                                fromEscape : false
                            }),function(result){
                            });
                        });
                        console.log("This Not Have Child")
                    }
                }
                
                if (children) {
                    $(".buttons-context").html("");
                    $(".buttons-context").append('<div class="button-context" id="backmenu"><div class="title-context" id="backmenu">< Go back</div><div class="description-context" id="backmenu"></div></div>');
                    $.each(children, function (index1, item1) {
                        if (item1.children) {
                            if (item1.description) {
                                $(".buttons-context").append('<div class="button-context" id="subcontextmenu-'+index1+'"><div class="title-context" id="subcontextmenu-'+index1+'">'+item1.title+'</div><div class="description-context" id="subcontextmenu-'+index1+'">'+item1.description+'</div></div>');
                            }else{
                                $(".buttons-context").append('<div class="button-context" id="subcontextmenu-'+index1+'"><div class="title-context" id="subcontextmenu-'+index1+'">'+item1.title+'</div><div class="description-context" id="subcontextmenu-'+index1+'"></div></div>');
                            }
                            
                            $("#subcontextmenu-"+index1).data("action",item1.action);
                            $("#subcontextmenu-"+index1).data("key",item1.key);
                            $("#subcontextmenu-"+index1).data("children",item1.children);
                        }else{
                            if (item1.description) {
                                $(".buttons-context").append('<div class="button-context" id="subcontextmenu-'+index1+'"><div class="title-context" id="subcontextmenu-'+index1+'">'+item1.title+'</div><div class="description-context" id="subcontextmenu-'+index1+'">'+item1.description+'</div></div>');
                            }else{
                                $(".buttons-context").append('<div class="button-context" id="subcontextmenu-'+index1+'"><div class="title-context" id="subcontextmenu-'+index1+'">'+item1.title+'</div><div class="description-context" id="subcontextmenu-'+index1+'"></div></div>');
                            }
                            $("#subcontextmenu-"+index1).data("action",item1.action);
                            $("#subcontextmenu-"+index1).data("key",item1.key);
                            $("#subcontextmenu-"+index1).data("children",null);
                        }
                    })
                }
            }else if(event.target.id.split("-")[0] === 'subcontextmenu'){
                let subaction = $("#"+event.target.id).data('action');
                let subkey = $("#"+event.target.id).data('key');
                $.post('https://np-sceneui/'+subaction, JSON.stringify({
                    key:subkey
                }),function (res) { 
                    if (res.meta.message == "done" && res.meta.ok == true ) {
                        contextActive = false;
                        $(".buttons-context").html("");
                        //$(".container-context").hide();
                        contextData = {};
                        $.post('https://np-sceneui/np-sceneui:closeApp', JSON.stringify({}),function(res){
                            $.post('https://np-sceneui/np-sceneui:applicationClosed', JSON.stringify({
                                name : "contextmenu",
                                fromEscape : false
                            }),function(result){
                                
                            });
                        });
                        
                    }
                });
            }
        }
    }
})
// Context //

// Showroom Area
var showroomuiactive = false
// End Showroom Area

var arrayinteracteyeevent, contextdataeye, entitydataeye; //Eye Variale
var eyeactive = false;
var preferencesactive = false;
var newspapperactive = false;
var radiouiactive = false;
var radiostate = false;
var countDownstatusHud
// EVENT LISTENER
window.addEventListener('message',function(event){
    const listener = event.data;
    var source = listener.source
    var app = listener.app
    var showapp = listener.show
    var appdata = listener.data
    switch (app) {
        case "memorygame":
            if (showapp) {
                minigame_memory_endpoint = appdata.gameFinishedEndpoint
                var durationmemmory = appdata.gameTimeoutDuration / 1000
                start_memorygame(durationmemmory);
            }

            break;
        case "minigame-captcha":
            if (showapp) {
                minigame_captcha_endpoint = appdata.gameFinishedEndpoint
                resetminigamecaptcha(appdata.gameDuration, appdata.gameRoundsTotal, appdata.numberOfShapes);
            }

            break;
        case "minigame-numbers":
            if (showapp) {
                startminigamenumbers(appdata.gameTimeoutDuration, appdata.numberOfDigits, appdata.gameFinishedEndpoint)
            }
            
            break;
        case "minigame-hacking":

            break;
        case "taskbarskill":
            if (appdata.display) {
                draw_skillbar(appdata.duration, appdata.difficulty);
            }

            break;
        case "interactions":
            if (appdata.message && appdata.show) {
                $("#text-interactions").html("");
                $("#container-interactions").fadeIn(750);
                if (appdata.type == "success" ) {
                    $("#box-interactions").css("background","#3ab63e");
                }else if(appdata.type == "error" ){
                    $("#box-interactions").css("background","#fb3928");
                }else{
                    $("#box-interactions").css("background","#147efb");
                }
                $("#text-interactions").html(appdata.message);
            }else{
                $("#container-interactions").fadeOut(750)
            }
            break;
        case "contextmenu":
            if (showapp) {
                buildContextMenu(appdata);
            }
            break;
        case "eye":
            if (showapp) {
                if(appdata.action == "interact"){
                    eyeactive = true;
                    $("#eyenonactive").hide();
                    $("#eyeactive").show();
                    contextdataeye = appdata.payload.context;
                    entitydataeye = appdata.payload.entity;
                }
            }
            if (appdata.action == "refresh") {
                arrayinteracteyeevent = appdata.payload
            }else if(appdata.action == "update"){

                if(eyeactive != true){
                    $(".target-label").html("");
                    if (appdata.payload.active == true) {
                        $("#eyenonactive").hide();
                        $("#eyeactive").show();
                    }else{
                        $("#eyenonactive").show();
                        $("#eyeactive").hide();
                    }
    
                    $.each(arrayinteracteyeevent, function (index1, item1) {
                        $.each(appdata.payload.options, function (index2, item2) {
                            if (index1 == index2 && item2 == true) {
                                $(".target-label").append("<div id='target-" + index1 + "'<li><span class='target-icon'><i class='fas fa-" + item1.icon + "'></i></span>&nbsp" + item1.label + "</li></div>");
                                $("#target-" + index1).hover((e)=> {
                                    $("#target-" + index1).css("color",e.type === "mouseenter"?"#00b894":"white")
                                })
                                $("#target-" + index1).css("padding-top", "10px");
                                $("#target-" + index1).data('eventData', item1.event);
                                $("#target-" + index1).data('parametersData', item1.parameters);
                            }
                        })
                    })
                }

            }else if(appdata.action == "peek"){
                if (appdata.payload.display == true) {
                    if(eyeactive != true){
                        $(".target-label").html("");
                        $('.target-wrapper').show();
                        $("#eyenonactive").show();
                        $("#eyeactive").hide();
                    }
                }else{
                    if(eyeactive != true){
                        $(".target-label").html("");
                        $('.target-wrapper').hide();
                    };
                }

                if (appdata.payload.active == true) {
                }else{
                    if(eyeactive != true){
                        $(".target-label").html("");
                    }
                }
            }

            break;
        case "textbox": // Form Text Player
            if(showapp == true){
                buildTextBox(appdata);
            }

            if (showapp == false) {
                textActive = false;
                $(".root-wrapper-textbox").css("display","none");
            }

            break;
        case "badge":
            if (condition) {
                showbadgepd(appdata);
            }
            
            break;
        case "newspaper":
            if (showapp) {
                newspapperactive = true
                document.querySelector('.newspaper-wrapper').classList.remove('hidden');
            }
            
            break;
        case "drpager":
            $("#pager-notification").fadeIn(1500);
            sleep(8000,function(){
                $("#pager-notification").fadeOut(2000);
            });
            break;
        case "showroom":
            showroomuiactive = true
            document.querySelector('.main').classList.add('hidden');
            document.querySelector('.showcase').classList.add('hidden');
            document.querySelector('.actions').classList.add('hidden');
            document.querySelector('.showroom-wrapper').classList.remove('hidden');
            document.querySelector('.start-container').classList.remove('hidden');
            $(".ltr").css("background-color","red");
            $(".rtl").css("background-color","blue");

            sleep(4000,function(){
                document.querySelector('.main').classList.remove('hidden');
                document.querySelector('.showcase').classList.remove('hidden');
                document.querySelector('.actions').classList.remove('hidden');
                document.querySelector('.start-container').classList.add('hidden');
            });
            break;
        case "dispatch":

            break;
        case "preferences": // Hud Setting or UI Settings
            if (showapp) {
                $(".hud-settings-menu").hide();
                $(".phone-setting-menu").hide();
                $(".radio-setting-menu").hide();
                $("#radiomenu").css("background","#30475c");
                $("#phonemenu").css("background","#30475c");
                $("#hudmenu").css("background","#30475c");
                preferencesactive = true;
                $(".hud-settings-wrapper").show();
            }

            if (appdata.changeHud) {
                console.log("Change Preset", appdata.changeHud)
            }
            
            break;
        case "hud": // Hud
            if (appdata.display == true) {
                $(".hud-container").css("display","block");
            } 
            
            if (appdata.display == false){
                $(".hud-container").css("display","none");
            }

            if(appdata.health > 0){
                setHud("health", appdata.health)
                if(appdata.health < 25){
                    $(".health-background").css("fill","red");
                    $(".health-background").css("opacity","1");
                }else{
                    $(".health-background").css("fill","#3ac180");
                    $(".health-background").css("opacity","0.35");
                }
            }

            if (appdata.health <= 0) {
                setHud("health",0)
                $(".health-background").css("fill","red");
                $(".health-background").css("opacity","1");
            }

            if (appdata.armor > 0) {
                setHud("armor", appdata.armor)
                if(appdata.armor < 25){
                    $(".armor-background").css("fill","red");
                    $(".armor-background").css("opacity","1");
                }else{
                    $(".armor-background").css("fill","#2a7ae0");
                    $(".armor-background").css("opacity","0.35");
                }
            }

            if (appdata.armor <= 0) {
                setHud("armor",0)
                $(".armor-background").css("fill","red");
                $(".armor-background").css("opacity","1");
            }

            if (appdata.food > 0) {
                setHud("food", appdata.food)
                if(appdata.food < 25){
                    $(".hunger-background").css("fill","red");
                    $(".hunger-background").css("opacity","1");
                }else{
                    $(".hunger-background").css("fill","#f37928");
                    $(".hunger-background").css("opacity","0.35");
                }
            }

            if (appdata.food <= 0) {
                setHud("food",0)
                $(".hunger-background").css("fill","red");
                $(".hunger-background").css("opacity","1");
            }

            if (appdata.water > 0) {
                setHud("water", appdata.water)
                if(appdata.water < 25){
                    $(".thirst-background").css("fill","red");
                    $(".thirst-background").css("opacity","1");
                }else{
                    $(".thirst-background").css("fill","#3289d8");
                    $(".thirst-background").css("opacity","0.35");
                }
            }

            if (appdata.water <= 0) {
                setHud("water",0)
                $(".thirst-background").css("fill","red");
                $(".thirst-background").css("opacity","1");
            }

            if (appdata.oxygen > 0) {
                setHud("oxygen", appdata.oxygen)
                if(appdata.oxygen < 25){
                    $(".oxygen-background").css("fill","red");
                    $(".oxygen-background").css("opacity","1");
                }else{
                    $(".oxygen-background").css("fill","#495A74");
                    $(".oxygen-background").css("opacity","0.35");
                }
            }

            if (appdata.oxygen <= 0) {
                setHud("oxygen", 0)
                $(".oxygen-background").css("fill","red");
                $(".oxygen-background").css("opacity","1");
            }

            if (appdata.stress > 0) {
                setHud("stress", appdata.stress)
            }

            if (appdata.stress <= 0) {
                setHud("stress",0)
            }

            // Radar show or outline
            if (appdata.radarShow == true){
                // if (settings["hud.vehicle.minimap.outline"]){
                    console.log("radarMap true")
                    $(".radar-map").css("display","block");
                    $(".hud-vehicle").css("display","block");
                //}
            }else if (appdata.radarShow == false){
                console.log("radarMap false")
                $(".radar-map").css("display","none");
                $(".hud-vehicle").css("display","none");
            }

            if (appdata.collarShow == true) {
                
            }else if (appdata.collarShow == false) {
                
            }

            if (appdata.altitudeShow == true) {
                
            }else if (appdata.altitudeShow == false) {
                
            }

            //beltShow
            if (appdata.beltShow == true) {
                
            }else if (appdata.beltShow == false) {
                
            }

            //Fuel
            if (appdata.fuel > 0) {
                
            }else if (appdata.fuel <= 0) {
                
            }

            // Harness
            if (appdata.harnessDurability == true) {
                
            }else if (appdata.harnessDurability == false) {
                
            }

            // engineDamageShow
            if (appdata.engineDamageShow == true) {
                
            }else if (appdata.engineDamageShow == false) {
                
            }

            //partsDamageShow
            if (appdata.partsDamageShow == true) {
                
            }else if (appdata.partsDamageShow == false) {
                
            }

            //gasDamageShow
            if (appdata.gasDamageShow == true) {
                
            }else if (appdata.gasDamageShow == false) {
                
            }

            // Nos
            if (appdata.nos > 0) {
                
            }else if (appdata.nos <= 0) {
                
            }

            //nosEnabled
            if (appdata.nosEnabled == true) {
                
            }else if(appdata.nosEnabled == false){

            }

            //nosShow
            if (appdata.nosShow == true) {
                
            }else if(appdata.nosShow == false){

            }

            // pursuit
            if (appdata.pursuit > 0) {
                
            }else if (appdata.pursuit <= 0) {
                
            }

            //pursuitShow
            if (appdata.pursuitShow == true) {
                
            }else if(appdata.pursuitShow == false){

            }

            //waypointActive
            if (appdata.waypointActive == true) {
                
            }else if(appdata.waypointActive == false){

            }

            //waypointDistance
            if (appdata.waypointDistance) {
                
            }

            //manaShow
            if (appdata.manaShow == true) {
                
            }else if(appdata.manaShow == false){

            }

            // mana
            if (appdata.mana > 0) {
                
            }else if (appdata.mana <= 0) {
                
            }

            //oxygenShow
            if (settings["hud.status.oxygen.enabled"] == false) {
                if (appdata.oxygenShow == true) {
                    $(".oxygen").fadeIn(500);
                }
                if(appdata.oxygenShow == false){
                    $(".oxygen").fadeOut(500);
                }
            }

            //crosshairShow
            if (appdata.crosshairShow == true) {
                if (settings["hud.crosshair.enabled"]) {
                    $("#crosshair").show();
                }
            }
            if(appdata.crosshairShow == false){
                $("#crosshair").hide();
            }
        
            // Voice
            if (appdata.voiceRange > 0) {
                if (appdata.voiceRange == 1) {
                    sethud("voice",30)
                }

                if (appdata.voiceRange == 2) {
                    sethud("voice",65)
                }

                if (appdata.voiceRange == 3) {
                    sethud("voice",100)
                }
            }

            if (appdata.voiceActive == true) {
                $(".incomplete-voice").css("stroke","#fdcb6e");
            }

            if(appdata.voiceActive == false){
                $(".incomplete-voice").css("stroke","#ffffff");
            }

            if (appdata.voiceActiveRadio == true) {
                $(".incomplet-voice").css("stroke","#d63031");
            }

            break;
        case "radio":
            if (listener.show == true) {
                radiouiactive = true;
                document.querySelector('.radio-container').classList.remove('hidden');
            }else if (listener.show == false) {
                radiouiactive = false;
                document.querySelector('.radio-container').classList.add('hidden');
            }

            if (appdata.value) {
                $("#channelradio").value = appdata.value
            }

            if (appdata.state == true) {
                radiostate = true
            }else if(appdata.state == false){
                radiostate = false
            }
            break;    
        case "hud.compass": // Compass
            if (appdata.alt) {
                
            }

            if (appdata.area) {
                if (settings["hud.compass.enabled"] == true && settings["hud.compass.roadnames.enabled"] == true) {
                    $(".compass-area").html(appdata.area);
                }
            }

            if (appdata.heading) {
                var windowWidth =  window.innerWidth;
                var headingPluss = 0;
                if (windowWidth == 1360){
                    headingPluss = 0;
                }else if(windowWidth == 1920){
                    headingPluss = 90;
                }else if(windowWidth == 1400){
                    headingPluss = 2;
                }else if(windowWidth == 1440){
                    headingPluss = 0;
                }else if(windowWidth == 1600){
                    headingPluss = 300;
                }else if(windowWidth == 1680){
                    headingPluss = 250;
                }else if(windowWidth == 800){
                    headingPluss = -50;
                }else if(windowWidth == 1024){
                    headingPluss = 210;
                }else if(windowWidth == 1152){
                    headingPluss = 140;
                }else if(windowWidth == 1280){
                    headingPluss = 70;
                }
                var headingCompass = (100*((-1* appdata.heading) + -300 + headingPluss)) / window.innerWidth;
                $(".compass-image").find(".compass-image-main").attr('style', 'transform: translate3d(' + headingCompass + 'vw, 0px, 0px)');
            }

            if (appdata.speed > 0) {
                $(".speed").text(appdata.speed);
                setProgressSpeed(appdata.speed,'.speed');
            } else if (appdata.speed == 0) {
                $(".speed").text("0");
            }

            if (appdata.street) {
                if (settings["hud.compass.enabled"] == true && settings["hud.compass.roadnames.enabled"] == true) {
                    $(".compass-street").html(appdata.street);
                }
            }

            if (appdata.showCompass == true){
                $(".compass-wrapper").show();
            }else if(appdata.showCompass == false){
                $(".compass-wrapper").hide();
            }

            if (appdata.showRoadNames == true){
                $(".compass-area").show();
                $(".compass-street").show();
            }else if(appdata.showRoadNames == false){
                $(".compass-area").hide();
                $(".compass-street").hide();
            }
            break;
        case "status-hud":
            if (appdata.show == true) {
                $(".status-title").html("");
                $(".status-values").html("");
                if (appdata.title) {
                    $(".status-title").append("<span>"+appdata.title+"</span>");
                }
                var countTime = false;
                var timeCount = 0;
                if (appdata.values) {
                    for (const key in appdata.values) {
                        if (appdata.values[key].text) {
                            $(".status-values").append("<span>"+appdata.values[key].text+"</span><br>");
                        }else if(appdata.values[key].seconds){
                            var minutes = Math.floor(appdata.values[key].seconds / 60);
                            var seconds = appdata.values[key].seconds - minutes * 60;
                            var stringtime = minutes+":"+seconds
                            countTime = true
                            timeCount = appdata.values[key].seconds
                            $(".status-values").append("<span id='timeCounthdown'>"+stringtime+"</span><br>");
                        }else{
                            $(".status-values").append("<span>"+appdata.values[key]+"</span><br>");
                        }
                    }	
					if (countTime && timeCount > 0) {
                        clearInterval(countDownstatusHud);
                        countDownstatusHud = setInterval(function(){
                            if(timeCount <= 0){
                                clearInterval(countDownstatusHud);
                                $("#timeCounthdown").html("00:00");
                            } else {
                                var minutes2 = Math.floor(timeCount / 60);
                                var seconds2 = timeCount - minutes2 * 60;
                                var stringtime2 = minutes2+":"+seconds2
                                $("#timeCounthdown").html(stringtime2)
                            }
                            timeCount -= 1;
                        }, 1000);
                    }
                }
                $("#container-status").show();
            }else{
                $(".status-title").html("");
                $(".status-values").html("");
                $("#container-status").hide();
            }
            break;    
        case "sniper-scope":
            if (appdata.show == true) {
                $(".scopecontainer").show();
            }else{
                $(".scopecontainer").hide();
            }
            break;
        case "taskbar":
            if (appdata.display) {
                $(".progress-container").show();
                drawprogbar(appdata.duration, appdata.label, appdata.taskID)
            }else{
                $(".progress-container").hide();
                $("#progress-bar").css("width", "0%");
            }
            break;
        case "sounds":
            if (appdata.action == "play") {
                playfuncsound(appdata.id, appdata.name, appdata.loop, appdata.volume);
            }

            if (appdata.action == "volume") {
                playfunsoundsetvolume(appdata.id, appdata.volume)
            }

            if (appdata.action == "stop") {
                stopplayfunsound(appdata.id);
            }
            break;
        case "phone":

            break;
        case "ballot":

            break;
        case "game":
            if (appdata.modeDev == true) {
                $(".dev").fadeIn(1000);
            }

            if (appdata.modeDev == false) {
                $(".dev").fadeOut(1000);
            }

            if (appdata.modeDebug == true) {
                $(".debug").fadeIn(1000);
            }

            if (appdata.modeDebug == false) {
                $(".debug").fadeOut(1000)
            }
            break    
        case "system": // System Settings
            
            break;
        case "mdt":
            
            break;
        case "musicplayer":
            
            break;
        default:
            break;
    }
});

// Speed //
function setProgressSpeed(value, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var percent = value*100/220;

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(value);
}
// Speed //

// Radio
document.querySelector('.vol-up-wrapper').addEventListener('click', function(){
    $.post('https://np-sceneui/np-sceneui:radioVolumeUp', JSON.stringify({}));
});

document.querySelector('.vol-down-wrapper').addEventListener('click', function(){
    $.post('https://np-sceneui/np-sceneui:radioVolumeDown', JSON.stringify({}));
});

document.querySelector('.on-off-wrapper').addEventListener('click', function(){
    radiostate = !radiostate
    if (radiostate == true) {
        $.post('https://np-sceneui/np-sceneui:toggleRadioOn', JSON.stringify({}));
    }else if (radiostate == false) {
        $.post('https://np-sceneui/np-sceneui:toggleRadioOff', JSON.stringify({}));
    }
});

// Eye Click

$(document).on('mousedown', (event) => {
    let element = event.target;
    if (element.id.split("-")[0] === 'target') {
        let eventData = $("#"+element.id).data('eventData');
        let parametersData = $("#"+element.id).data('parametersData');
        $.post('https://np-sceneui/np-sceneui:targetSelectOption', JSON.stringify({
            entity : entitydataeye,
            option :{
                event: eventData,
                parameters: parametersData
            },
            context: contextdataeye,
        }));

        $(".target-label").html("");
        $('.target-wrapper').hide();
        eyeactive = false;
    }
});

// EXIT LISTENER
$(document).keydown(function(event) {
    var key = (event.keyCode ? event.keyCode : event.which);
    if (key == 27) {
        if (showroomuiactive) {
            showroomuiactive = false
            document.querySelector('.showroom-wrapper').classList.add('hidden');
            $.post('https://np-sceneui/np-sceneui:closeApp', JSON.stringify({}),function (cb) { 
                $.post('https://np-sceneui/np-sceneui:applicationClosed', JSON.stringify({
                    name : "showroom",
                    fromEscape : true
                }));
            });
            
        }
        if (contextActive) {
            contextActive = false
            $(".container-context").css("display","none");
            $(".button-context").html("");
            $.post('https://np-sceneui/np-sceneui:closeApp', JSON.stringify({}),function (cb) { 
                $.post('https://np-sceneui/np-sceneui:applicationClosed', JSON.stringify({
                    name : "contextmenu",
                    fromEscape : true
                }));
            });
            
        }
        if(eyeactive){
            eyeactive = false
            $(".target-label").html("");
            $('.target-wrapper').hide();
            $.post('https://np-sceneui/np-sceneui:closeApp', JSON.stringify({}),function (cb) { 
                $.post('https://np-sceneui/np-sceneui:applicationClosed', JSON.stringify({
                    name : "eye",
                    fromEscape : true
                }));
            });
            
        }
        if (preferencesactive) {
            $(".hud-settings-wrapper").hide();
            preferencesactive = false;
            $.post('https://np-sceneui/np-sceneui:closeApp', JSON.stringify({}),function (cb) { 
                $.post('https://np-sceneui/np-sceneui:applicationClosed', JSON.stringify({
                    name : "preferences",
                    fromEscape : true
                }));
            });
            
        }

        if (newspapperactive){
            document.querySelector('.newspaper-wrapper').classList.add('hidden');
            newspapperactive = false
            $.post('https://np-sceneui/np-sceneui:closeApp', JSON.stringify({}),function (cb) { 
                $.post('https://np-sceneui/np-sceneui:applicationClosed', JSON.stringify({
                    name : "newspapper",
                    fromEscape : true
                }));
            });
            
        } 

        if (textActive) {
            textActive = false;
            $(".root-wrapper-textbox").css("display","none");
            $.post('https://np-sceneui/np-sceneui:closeApp', JSON.stringify({}),function (cb) { 
                $.post('https://np-sceneui/np-sceneui:applicationClosed', JSON.stringify({
                    name : "textbox",
                    fromEscape : true
                }));
            });
            
        }

        if (minigame_capthcha_active) {
            minigame_capthcha_active = false
            $.post('https://np-sceneui/np-sceneui:closeApp', JSON.stringify({}),function (cb) { 
                $.post('https://np-sceneui/'+minigame_captcha_endpoint, JSON.stringify({
                    result : minigame_capthcha_result
                }),function(res){
                    $.post('https://np-sceneui/np-sceneui:applicationClosed', JSON.stringify({
                        name : "minigame-captcha",
                        fromEscape : true
                    }),function(result){
                        document.querySelector('.minigamecaptcha').classList.add('hidden');
                        minigame_capthcha_result = false;
                    });
                });
            });
            
        }

        if (game_memmory_active) {
            game_memmory_active = false;
            $.post('https://np-sceneui/np-sceneui:closeApp', JSON.stringify({}),function (cb) { 
                $.post('https://np-sceneui/'+minigame_memory_endpoint, JSON.stringify({
                    result : game_memmory_result
                }),function (res) { 
                    $.post('https://np-sceneui/np-sceneui:applicationClosed', JSON.stringify({
                        name : "memorygame",
                        fromEscape : true
                    }),function(result){
                        document.querySelector('.minigame_memory').classList.add('hidden');
                        game_memmory_result = false;
                    });
                });
            });
            
        }

        if (radiouiactive) {
            radiouiactive = false
            $.post('https://np-sceneui/np-sceneui:closeApp', JSON.stringify({}),function (cb) { 
                $.post('https://np-sceneui/np-sceneui:applicationClosed', JSON.stringify({
                    name : "radio",
                    fromEscape : true
                }),function(result){
                    document.querySelector('.radio-container').classList.add('hidden');
                });
            });
            
        }
    }
});