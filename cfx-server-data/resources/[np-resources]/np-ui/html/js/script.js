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
      //  console.log("Success")
        return
    }
    progbarp++;
    animatprogbar()
}
//End progbar event

// skillbarcode
let skillbaractive = false
let canvas = document.getElementById("canvas");
let ctx = canvas.getContext("2d");

let W = canvas.width;
let H = canvas.height;
let degrees = 0;
let new_degrees = 0;
let time = 0;
let color = "#ffffff";
let bgcolor = "#404b58";
let bgcolor2 = "#41a491";
let key_to_press;
let g_start, g_end;
let animation_loop;

function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1) + min); //The maximum is inclusive and the minimum is inclusive
}

function initskillbar() {
    // Clear the canvas every time a chart is drawn
    ctx.clearRect(0,0,W,H);

    // Background 360 degree arc
    ctx.beginPath();
    ctx.strokeStyle = bgcolor;
    ctx.lineWidth = 20;
    ctx.arc(W / 2, H / 2, 100, 0, Math.PI * 2, false);
    ctx.stroke();

    // Green zone
    ctx.beginPath();
    ctx.strokeStyle = bgcolor2;
    ctx.lineWidth = 20;
    ctx.arc(W / 2, H / 2, 100, g_start - 90 * Math.PI / 180, g_end - 90 * Math.PI / 180, false);
    ctx.stroke();

    // Angle in radians = angle in degrees * PI / 180
    let radians = degrees * Math.PI / 180;
    ctx.beginPath();
    ctx.strokeStyle = color;
    ctx.lineWidth = 20;
    ctx.arc(W / 2, H / 2, 100, 0 - 90 * Math.PI / 180, radians - 90 * Math.PI / 180, false);
    ctx.stroke();

    // Adding the key_to_press
    ctx.fillStyle = color;
    ctx.font = "100px sans-serif";
    let text_width = ctx.measureText(key_to_press).width;
    ctx.fillText(key_to_press, W / 2 - text_width / 2, H / 2 + 35);
}

function drawskillbar(duration,level) {
    $(".skillbar").show()
    skillbaractive = true
    if (typeof animation_loop !== undefined) clearInterval(animation_loop);

    g_start = getRandomInt(20,40) / 10;
    g_end = getRandomInt(5,10) / 10;
    g_end = g_start + g_end;

    degrees = 0;
    new_degrees = 360;

    key_to_press = ''+getRandomInt(1,4);

    time = (duration / 1000 ) * 3;

    animation_loop = setInterval(animate_to, time);
}

function animate_to() {
    if (degrees >= new_degrees) {
        wrong();
        return;
    }

    degrees++;
    initskillbar();
}

function correct(){
    $(".skillbar").hide()
    clearInterval(animation_loop);
    skillbaractive = false
    $.post('https://np-ui/np-ui:taskBarSkillResult', JSON.stringify({
        success: true,
    }));
}

function wrong(){
    $(".skillbar").hide()
    clearInterval(animation_loop);
    skillbaractive = false
    $.post('https://np-ui/np-ui:taskBarSkillResult', JSON.stringify({
        success: false,
    }));
}
// End skillbarcode

var saved = "";
arraydatainteract = null;
contextdata = null
entitydata = null
textmenucallbackurl = null
menucontextdata = null
contextmenuactive = false
textboxactive = false
eyeintactive = false
textmenukey = null;


var RowsData = {};
var Rows = {};

const OpenMenu = (data) => {
    $(`.main-wrapper`).fadeIn(0)

    $( ".body" ).empty();
    RowsData = {};
    Rows = {};

    AddRow(data)
}

const CloseMenu = () => {
    $(`.main-wrapper`).fadeOut(0);

    $( ".body" ).empty();
    RowsData = {};
    Rows = {};
};

function AddRow(data) {
    RowsData = data

    for (var i = 0; i < RowsData.length; i++) {
        let element

        element = `<div class="input-wrapper">`
        element += `<label>${RowsData[i].label}</label>`;
        element += `<input type="text" class="form-control" id="${RowsData[i].name}"/>`;
        element += `<span class="fas fa-${RowsData[i].icon} input-icon"></span>`;
        element += `</div>`

        $(".body").append(element);
        Rows[RowsData[i].name] = element
    }
}

$(`#submit`).click(() => {
    SubmitData();
})

function SubmitData() {
    const returnData = {};

    for (var i = 0; i < RowsData.length; i++) {
        var id = RowsData[i].name
        var data = document.getElementById(id)

        if (data.value) {
            returnData[id] = data.value;
        } else {
            returnData[id] = null;
        }
        $(Rows[id]).remove();
    }

    PostData({
        data: returnData
    })

    CloseMenu();
}

const PostData = (data) => {
    return $.post(`https://np-ui/dataPost`, JSON.stringify(data))
}

const CancelMenu = () => {
    for (var i = 0; i < RowsData.length; i++) {
        var id = RowsData[i].id
        $(Rows[id]).remove();
    }
    $.post(`https://np-ui/cancel`)
    return CloseMenu();
}

window.addEventListener("message", (evt) => {
    const data = evt.data
    const info = data.data
    const action = data.action
    switch (action) {
        case "OPEN_MENU":
            return OpenMenu(info);
        case "CLOSE_MENU":
            return CloseMenu();
        default:
            return;
    }
})

document.onkeyup = function (event) {
    event = event || window.event;
    var charCode = event.keyCode || event.which;
    if (charCode == 27) {
        CancelMenu();
    } else if (charCode == 13) {
        SubmitData()
    }
};
function closesettings(){
    $(".settings").hide();
    $.post('https://np-ui/close');
}

function Progress(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;
    const offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
    circle.style.strokeDashoffset = -offset;
}

function addGaps(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + '<span style="margin-left: 3px; margin-right: 3px;"/>' + '$2');
    }
    return x1 + x2;
}

function setProgressSpeed(value, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var percent = value*100/450;

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(value);
}

function setProgressFuel(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find("span");
    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;
    const offset = circumference - ((-percent * 73) / 100 / 100) * circumference;
    circle.style.strokeDashoffset = -offset;
    html.text(Math.round(percent));
}

window.addEventListener('message',function(event){
    const action = event.data.action;
    const msg = event.data;
    switch (action) {
        case "taskbarskill":
            if (msg.data.display) {
                drawskillbar(msg.data.duration,msg.data.difficulty)
            }
            break;
            case "contextmenu":
                if (msg.show == true) {
                    // console.log("Show Contextmenu")
                    $(".context-right-inner-container").html("");
                    $(".context-outer-container").show();
                    contextmenuactive = true
                    if (msg.data.options) {
                        menucontextdata = msg.data.options
                        $.each(msg.data.options, function (index1, item1) {
                            // console.log(index1,item1.title,item1.description,item1.action,item1.key)
                            let disabled = item1.disabled !== undefined ? item1.disabled : false
                            if (item1.children) {
    
                                if(item1.icon !== undefined) {
                                    console.log("icon", item1.icon)
    
                                    let title = item1.title !== undefined ? item1.title : ''
                                    let description = item1.description !== undefined ? item1.description : ''
                                    if(disabled) {
                                        $(".context-right-inner-container").append('<div class="context-button context-button-disabled padding-right" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="contextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-children-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="contextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                                    } else {
                                        $(".context-right-inner-container").append('<div class="context-button padding-right" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="contextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-children-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="contextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                                    }
                                } else {
                                    let title = item1.title !== undefined ? item1.title : ''
                                    let description = item1.description !== undefined ? item1.description : ''
                                    if(disabled) {
                                        $(".context-right-inner-container").append('<div class="context-button context-button-disabled padding-right" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-children-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="contextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                                    } else {
                                        $(".context-right-inner-container").append('<div class="context-button padding-right" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-children-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="contextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                                    }
                                }
    
                                if(!disabled) {
                                    $("#contextmenu-"+index1).data("action",item1.action);
                                    $("#contextmenu-"+index1).data("key",item1.key);
                                    $("#contextmenu-"+index1).data("children",item1.children);
                                }
                            }else{
    
                                if(item1.icon !== undefined) {
                                    let title = item1.title !== undefined ? item1.title : ''
                                    let description = item1.description !== undefined ? item1.description : ''
                                    if(disabled) {
                                        $(".context-right-inner-container").append('<div class="context-button context-button-disabled" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="contextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-normal-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                                    } else {
                                        $(".context-right-inner-container").append('<div class="context-button" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="contextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-normal-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                                    }
                                } else {
                                    let title = item1.title !== undefined ? item1.title : ''
                                    let description = item1.description !== undefined ? item1.description : ''
                                    if(disabled) {
                                        $(".context-right-inner-container").append('<div class="context-button context-button-disabled" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-normal-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                                    } else {
                                        $(".context-right-inner-container").append('<div class="context-button" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-normal-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                                    }
                                }
    
                                if(!disabled) {
                                    $("#contextmenu-"+index1).data("action",item1.action);
                                    $("#contextmenu-"+index1).data("key",item1.key);
                                    $("#contextmenu-"+index1).data("children",null);
                                }
                                // console.log("Dont Have")
                            }
                        })
                    }
                }else{
                    //console.log("hide context menu")
                    $(".context-outer-container").hide();
                    $(".context-right-inner-container").html("");
                }
                break;
        case "taskbar":
            if (msg.data.display) {
                //console.log("Display Progbar")
                $(".progress-container").show();
                drawprogbar(msg.data.duration,msg.data.label,msg.data.taskID)
            }else{
                //console.log("Hide Progbar")
                
                $(".progress-container").hide();
                $("#progress-bar").css("width", "0%");
            }
            break;
        case "hud.compass":

            if (msg.data.area != null) {
                $(".areainfo").html(msg.data.area);
            }

            if (msg.data.street != null) {
                $(".streetinfo").html(msg.data.street);
            }
            $(".direction").find(".image").attr('style', 'transform: translate3d(' + ((-1* msg.data.heading) + -300) + 'px, 0px, 0px)');
            if (msg.data.speed) {
                setProgressSpeed(msg.data.speed,".progress-speed")
            }
            
            break;
        case "eye":
            eyeintactive = true
            const payload = msg.data.payload
            if (msg.data.action == "refresh") {
                //Refresh data items entity
                arraydatainteract = payload
            }else if(msg.data.action == "update"){  
                eyeintactive = true
                //Update View of items looking
                $(".target-label").html("");
                if (payload.active == true) {
                    $(".target-eye").css("color", "#05f1b2");
                    $("#eyenonactive").hide();
                    $("#eyeactive").show();
                }else{
                    $("#eyenonactive").show();
                    $("#eyeactive").hide();
                    // $(".target-eye").css("color", "gray")
                }

                $.each(arraydatainteract, function (index1, item1) {
                    $.each(payload.options, function (index2, item2) {
                        if(index1 == index2 && item2 == true){
                            $(".target-label").append("<div id='target-"+index1+"'<li><span class='target-icon'><i class='"+item1.icon+"'></i></span>&nbsp"+item1.label+"</li></div>");
                            $("#target-"+index1).hover((e)=> {
                                $("#target-"+index1).css("color",e.type === "mouseenter"?"#05f1b2":"white")
                            })
                            $("#target-"+index1+"").css("padding-top", "13px");
                            $("#target-"+index1).data('eventData', item1.event);
                            $("#target-"+index1).data('parametersData', item1.parameters);
                        }
                    })
                })
            }else if(msg.data.action == "peek"){
                //Update eye event show or display
                if (payload.display == true) {
                    eyeintactive = true
                    $(".target-label").html("");
                    $('.target-wrapper').show();
                    $("#eyenonactive").show();
                    $("#eyeactive").hide();
                }else{
                    $(".target-label").html("");
                    $('.target-wrapper').hide();
                }

                if (payload.active == true) {
                    eyeintactive = true
                    $("#eyenonactive").hide();
                    $("#eyeactive").show();
                    // $(".target-eye").css("color", "#19a5dc");
                }else{
                    // $(".target-eye").css("color", "gray");
                    $("#eyenonactive").show();
                    $("#eyeactive").hide();
                    $(".target-label").html("");
                }
            }else if(msg.data.action == "interact"){
                eyeintactive = true
                contextdata = payload.context
                entitydata = payload.entity
            }else if(msg.data.action == "randap"){
                $.post('https://np-ui/closecontext', JSON.stringify({}));
            }
            break;
        case "sniper-scope":
            if (msg.data.show == true) {
                //Display Scope
                $(".scopecontainer").show();
            }else{
                //Hide Scope
                $(".scopecontainer").hide();
            }
            break;
        case "cash":
            if (msg.data.cash) {
                $('.cash').show();
                $('.cash').html('<p id="cash"><span class="green"> $ </span>' +addGaps(msg.data.cash)+'</p>');
                setTimeout(function(){
                    $('.cash').fadeOut(600)
                }, 5000)
            }

            if (msg.data.amountAdjustment >= 0) {
                $('.cashtransaction').show();
                var element = $('<p id="add-balance"><span class="pre">-</span><span class="red"> $ </span>' +addGaps(msg.data.amountAdjustment)+'</p>');
                $(".cashtransaction").append(element);
                setTimeout(function(){
                    $(element).fadeOut(600, function() { $(this).remove(); })
                }, 5000)
            }
            break;
        case "hud":
            if (msg.data.display == true) {
                $("#uicontent").css("display","block");
            }else if(msg.data.display == false){
                $("#uicontent").css("display","none");
            }

            if (msg.data.radarShow == true) {
                // Show Radar Border
                $(".radarmap").show()
                $(".vehiclehud").show()
                $(".areainfo").show();
                $(".direction").show();
                $(".streetinfo").show();
                $(".ditanceinfo").show();
            }else if(msg.data.radarShow == false){
                // Hide Radar Border
                $(".radarmap").hide()
                $(".vehiclehud").hide()
                $(".areainfo").hide();
                $(".direction").hide();
                $(".streetinfo").hide();
                $(".ditanceinfo").hide();
            }

            if (msg.data.waypointActive == true) {
                $(".ditanceinfo").show();
                var distan = msg.data.waypointDistance;
                $(".ditanceinfo").html(distan.toFixed(2) + "m");
            }else if(msg.data.waypointActive == false || msg.data.radarShow == false){
                $(".ditanceinfo").hide();
                $(".ditanceinfo").html("");
            }

            if (msg.data.health >= 0) {
                Progress(msg.data.health,"#health")
            }

            if (msg.data.armor >= 0) {
                Progress(msg.data.armor,"#armor")
            }

            if (msg.data.food >= 0) {
                Progress(msg.data.food,"#hunger")
            }

            if (msg.data.water >= 0) {
                Progress(msg.data.water,"#thirst")
            }

            if (msg.data.oxygen  >= 0) {
                Progress(msg.data.oxygen ,"#oxygen")
            }

            if (msg.data.stress >= 0) {
                Progress(msg.data.stress,"#stress")
            }

            if (msg.data.stamina >= 0) {
                Progress(msg.data.stamina,"#stamina")
            }
            
            // voice
            if (msg.data.voice >= 0) {
                Progress(msg.data.voice,"#voice")
            }

            if (msg.data.isTalking == true) {
                $("#voice").css("stroke","#F1C40F");
            }else{
                $("#voice").css("stroke","#FFF");
            }

            if (msg.data.isTransmitting == true) {
                $("#voice").css("stroke","#e74c3c");
            }else{
                $("#voice").css("stroke","#FFF");
            }

            if (msg.data.modeDev == true) {
                $("#develophud").show()
            }else{
                $("#develophud").hide()
            }

            if (msg.data.modeDebug == true) {
                $("#debuginghud").show()
            }else{
                $("#debuginghud").hide()
            }

            if (msg.data.fuel >= 0) {
                setProgressFuel(msg.data.fuel, ".progress-fuel");
            }

            if (msg.data.beltShow == true) {
                $(".car-seatbelt-info").show()
            }else{
                $(".car-seatbelt-info").hide()
            }

            if (msg.data.engineDamageShow == true) {
                $(".car-enginedamage-info").show()
            }else{
                $(".car-enginedamage-info").hide()
            }

            if (msg.data.gasDamageShow == true) {
                $(".car-fueldamage-info").show()
            }else{
                $(".car-fueldamage-info").hide()
            }
            break;
        case "game":
            //Its For Game Hud Like Show Hud vehicle compass and other
            // if (msg.data.modeDev == true) {
            //     $("#develophud").show()
            // }else{
            //     $("#develophud").hide()
            // }

            // if (msg.data.modeDebug == true) {
            //     $("#debuginghud").show()
            // }else{
            //     $("#debuginghud").hide()
            // }

            break;
        case "settings":
            $('.settings').show()
            document.getElementById("healthtoggle").checked = (msg.dataset.health == "true");
            document.getElementById("armortoggle").checked = (msg.dataset.armor == "true");
            document.getElementById("hungertoggle").checked = (msg.dataset.hunger == "true");
            document.getElementById("thirsttoggle").checked = (msg.dataset.thirst == "true");
            document.getElementById("staminatoggle").checked = (msg.dataset.stamina == "true");
            document.getElementById("oxygentoggle").checked = (msg.dataset.oxygen == "true");
            document.getElementById("stresstoggle").checked = (msg.dataset.stress == "true");
            document.getElementById("voicetoggle").checked = (msg.dataset.voice == "true");
            break;
        case "initialize":
            $('.cash').hide();
            $('.cashtransaction').hide();

            $("#develophud").hide()
            $("#debuginghud").hide()
            Progress(100,"#develop")
            Progress(100,"#debuging")

            if (msg.toggledata.health == "true") {
                $("#healthhud").fadeOut(500)
            }else{
                $("#healthhud").fadeIn(500)
            }

            if (msg.toggledata.armor == "true") {
                $("#armorhud").fadeOut(500)
            }else{
                $("#armorhud").fadeIn(500)
            }

            if (msg.toggledata.hunger == "true") {
                $("#hungerhud").fadeOut(500)
            }else{
                $("#hungerhud").fadeIn(500)
            }

            if (msg.toggledata.thirst == "true") {
                $("#thirsthud").fadeOut(500)
            }else{
                $("#thirsthud").fadeIn(500)
            }

            if (msg.toggledata.stamina == "true") {
                $("#staminahud").fadeOut(500)
            }else{
                $("#staminahud").fadeIn(500)
            }

            if (msg.toggledata.oxygen == "true") {
                $("#oxygenhud").fadeOut(500)
            }else{
                $("#oxygenhud").fadeIn(500)
            }

            if (msg.toggledata.stress == "true") {
                $("#stresshud").fadeOut(500)
            }else{
                $("#stresshud").fadeIn(500)
            }

            if (msg.toggledata.voice == "true") {
                $("#voicehud").fadeOut(500)
            }else{
                $("#voicehud").fadeIn(500)
            }
            // Color Data
            if (msg.colordata.health != "") {
                $("#health").css("stroke",msg.colordata.health)
            }

            if (msg.colordata.armor != "") {
                $("#armor").css("stroke",msg.colordata.armor)
            }

            if (msg.colordata.hunger != "") {
                $("#hunger").css("stroke",msg.colordata.hunger)
            }

            if (msg.colordata.thirst != "") {
                $("#thirst").css("stroke",msg.colordata.thirst)
            }

            if (msg.colordata.stamina != "") {
                $("#stamina").css("stroke",msg.colordata.stamina)
            }

            if (msg.colordata.oxygen != "") {
                $("#oxygen").css("stroke",msg.colordata.oxygen)
            }

            if (msg.colordata.stress != "") {
                $("#stress").css("stroke",msg.colordata.stress)
            }

            if (msg.colordata.voice != "") {
                $("#voice").css("stroke",msg.colordata.voice)
            }
            break;
        case "interactions":
            //Draw Text
            // if (msg.data.show == true) {
            //     $("#containerInteractions").show().removeClass("slide-out").addClass("slide-in")
            // }else if(msg.data.show == false) {
            //     $("#containerInteractions").removeClass("slide-in").addClass("slide-out")
            // }else{
            //     $("#containerInteractions").hide()
            // }

            // if (msg.data.type == "success") {
            //     $("#boxinteractions").css("background","#3ab63e");
            // }else if(msg.data.type == "error"){
            //     $("#boxinteractions").css("background","#fb3928");
            // }else if(msg.data.type == "classic"){
            //     $("#boxinteractions").css("background","#30475e");
            // }else if(msg.data.type == "info"){
            //     $("#boxinteractions").css("background","#147efb");
            // }else{
            //     $("#boxinteractions").css("background","#147efb");
            // }
            // document.getElementById("textinteractions").innerHTML = msg.data.message;



            if (msg.data.show == true) {
                var color = '#147efb'
                if(msg.data.type == 'error') {
                  color = '#fb3928'
                } else if(msg.data.type == 'info' || msg.data.type == null ) {
                  color = '#147efb'
                } else if(msg.data.type == 'success') {
                  color = '#3ab63e'
                }                    

                $("#containerInteractions").show().removeClass("slide-out").addClass("slide-in")
                $("#boxinteractions").css('background-color' , color)
                  $("#textinteractions").html(msg.data.message)

              } else if (msg.data.show == false) {

                var a = $("#containerInteractions").removeClass("slide-in").addClass("slide-out")

             
              } else {
                $("#containerInteractions").hide()

              }



            
            break;
        case "textbox":
            textboxactive = true
            OpenMenu(msg.data);
            break;
        default:
            return;
    }
})

// Click Event


//$("#submit").click(() => {
//    SubmitData();
//})

$(".header").click(() => {
    closesettings();
})

$(document).on('mousedown', (event) => {
    let element = event.target;
    if (element.id.split("-")[0] === 'target') {
        let eventData = $("#"+element.id).data('eventData');
        let parametersData = $("#"+element.id).data('parametersData');
        $.post('https://np-ui/np-ui:targetSelectOption', JSON.stringify({
            entity : entitydata,
            option :{
                event: eventData,
                parameters: parametersData
            },
            context: contextdata,
        }));

        $(".target-label").html("");
        $('.target-wrapper').hide();
    }
});

$(document).keydown(function(event) {
    var key = (event.keyCode ? event.keyCode : event.which);
    if (key == 27) {
        if (contextmenuactive) {
            contextmenuactive = false
            $(".context-right-inner-container").html("");
            $(".context-outer-container").hide();
            $.post('https://np-ui/closecontext', JSON.stringify({}));
        }
        if (textboxactive) {
            CancelMenu();
        }
        if (eyeintactive){
            eyeintactive = false
            $.post('https://np-ui/closeeyeint', JSON.stringify({}));
        }
    }
});

$(document).click(function(event){
    let $target = $(event.target);
    if ($target.closest('.button-context').length && $('.button-context').is(":visible")) {
        // $("#"+event.target.id).data('eventData', "context:cl:thisme");
        if (event.target.id == "backmenu") {
            //console.log("this for backmenu",menucontextdata.length)
            $(".buttoncontext").html("");
            $.each(menucontextdata, function (index1, item1) {
                if (item1.children) {
                    $(".buttoncontext").append('<div class="button-context" id="contextmenu-' + index1 + '"><div class="titlecontext" id="contextmenu-' + index1 + '">' + item1.title + '</div>' + '<i class="fas fa-' + item1.icon + '" style="color: white; cellpadding: 10px; position: absolute; top: 30%; margin-bottom: 3px;"></i>' + '<i class="fas fa-chevron-right" style="position: absolute; color: white; margin-left: 92.5%; margin-buttom: 3px; top: 35%; right: 7%; float: right;"></i>' + '<div class="descriptioncontext" id="contextmenu-' + index1 + '">' + item1.description + '</div></div>');
                    $("#contextmenu-" + index1).data("action", item1.action);
                    $("#contextmenu-" + index1).data("key", item1.key);
                    $("#contextmenu-" + index1).data("children", item1.children);
                } else {
                    $(".buttoncontext").append('<div class="button-context" id="contextmenu-' + index1 + '"><div class="titlecontext" id="contextmenu-' + index1 + '">' + item1.title + '</div><div class="descriptioncontext" id="contextmenu-' + index1 + '">' + item1.description + '</div></div>');
                    $("#contextmenu-" + index1).data("action", item1.action);
                    $("#contextmenu-" + index1).data("key", item1.key);
                    $("#contextmenu-" + index1).data("children", null);
                }
            })
        }else{
            // console.log("Not Back Button")
            if (event.target.id.split("-")[0] === 'contextmenu') {
                let action = $("#"+event.target.id).data('action');
                let key = $("#"+event.target.id).data('key');
                let children = $("#"+event.target.id).data('children');
                if (children) {
                    // Create new Menu for children
                    $(".buttoncontext").html("");
                    $(".buttoncontext").append('<div class="button-context" id="backmenu"><div class="titlecontext" id="backmenu">< Go Back</div><div class="descriptioncontext" id="backmenu"></div></div>');
                    $.each(children, function (index1, item1) {
                        if (item1.children) {
                            if (item1.description) {
                                $(".buttoncontext").append('<div class="button-context" id="subcontextmenu-' + index1 + '"><div class="titlecontext" id="subcontextmenu-' + index1 + '">' + item1.title + '</div><div class="descriptioncontext" id="subcontextmenu-' + index1 + '">' + item1.description + '</div></div>');
                            } else {
                                $(".buttoncontext").append('<div class="button-context" id="subcontextmenu-' + index1 + '"><div class="titlecontext" id="subcontextmenu-' + index1 + '">' + item1.title + '</div><div class="descriptioncontext" id="subcontextmenu-' + index1 + '"></div></div>');
                            }

                            $("#subcontextmenu-" + index1).data("action", item1.action);
                            $("#subcontextmenu-" + index1).data("key", item1.key);
                            $("#subcontextmenu-" + index1).data("children", item1.children);
                        }else{
                            if (item1.description) {
                                $(".buttoncontext").append('<div class="button-context" id="subcontextmenu-' + index1 + '"><div class="titlecontext" id="subcontextmenu-' + index1 + '">' + item1.title + '</div><div class="descriptioncontext" id="subcontextmenu-' + index1 + '">' + item1.description + '</div></div>');
                            } else {
                                $(".buttoncontext").append('<div class="button-context" id="subcontextmenu-' + index1 + '"><div class="titlecontext" id="subcontextmenu-' + index1 + '">' + item1.title + '</div><div class="descriptioncontext" id="subcontextmenu-' + index1 + '"></div></div>');
                            }
                            $("#subcontextmenu-" + index1).data("action", item1.action);
                            $("#subcontextmenu-" + index1).data("key", item1.key);
                            $("#subcontextmenu-" + index1).data("children", null);
                        }
                    })
                }else{
                    //Post data
                    //console.log("Dont have Chiclred and submit post data")
                    // contextmenuactive = false
                    $(".buttoncontext").html("");
                    $(".containercontext").hide();
                    $.post('https://np-ui/'+action, JSON.stringify({
                        key:key
                    }));
                    
                }
            }else if(event.target.id.split("-")[0] === 'subcontextmenu'){
                //console.log("Submit Post data")
                let subaction = $("#"+event.target.id).data('action');
                let subkey = $("#"+event.target.id).data('key');
                // console.log("This Sub Contextmenu",subaction,subkey)
                // contextmenuactive = false
                $(".buttoncontext").html("");
                $(".containercontext").hide();
                $.post('https://np-ui/'+subaction, JSON.stringify({
                    key:subkey
                }));
            }
        }
    }
})
// skillbarcode

document.addEventListener("keydown", function(ev) {
    if (skillbaractive) {
        let key_pressed = ev.key;
        let valid_keys = ['1','2','3','4'];

        if( valid_keys.includes(key_pressed) ){
            if( key_pressed === key_to_press ){
                let d_start = (180 / Math.PI) * g_start;
                let d_end = (180 / Math.PI) * g_end;
                if( degrees < d_start ){
                    console.log('Failed: Too soon!');
                    wrong();
                }else if( degrees > d_end ){
                    console.log('Failed: Too late!');
                    wrong();
                }else{
                    console.log('Success!');
                    correct();
                }
            }else{
                console.log('Failed: Pressed '+key_pressed+' instead of '+key_to_press);
                wrong();
            }
        }
    }
});

window.addEventListener("message", function(event){
    var data = event.data

    if (data.display) {
        let text = data.text

        text = text.replace(/[\[']+/g, `<span class="strokeme">[`);
        text = text.replace(/[\]']+/g, `]</span>`);

        $("#interaction-text").html(text);
        $("#interaction-text").css("background-color", data.color);

        LeftSlideRight("#interaction-text", 700, "0.5");
    } else {
        RightSlideLeft("#interaction-text", 700, "-20");
    }
})

function LeftSlideRight(Object, Timeout, Percentage) {
    $(Object).css("display", "inline-block").animate({
        left: Percentage + "%",
    }, Timeout);
}

function RightSlideLeft(Object, Timeout, Percentage) {
    $(Object).css("display", "inline-block").animate({
        left: Percentage + "%",
    }, Timeout, function(){
        $(Object).css("display", "none");
        $("#interaction-text").html("");
    });
}


$(document).keydown(function(event) {
    var key = (event.keyCode ? event.keyCode : event.which);
    if (key == 27) {
        if (contextmenuactive) {
            contextmenuactive = false
            $(".context-right-inner-container").html("");
            $(".context-outer-container").hide();
            $.post('https://np-ui/closecontext', JSON.stringify({}));
        }
        if (textboxactive) {
            CancelMenu();
        }
        if (eyeintactive){
            eyeintactive = false
            $.post('https://np-ui/closeeyeint', JSON.stringify({}));
        }
    }
});

$(document).click(function(event){
    let $target = $(event.target);
    if ($target.closest('.context-button').length && $('.context-button').is(":visible")) {
        //console.log("click context menu", $target)
        // $("#"+event.target.id).data('eventData', "context:cl:thisme");
        if (event.target.id == "backmenu") {
            //console.log("this for backmenu",menucontextdata.length)
            $(".context-right-inner-container").empty();
            $(".context-right-inner-container").html("");
            $.each(menucontextdata, function (index1, item1) {
                let disabled = item1.disabled !== undefined ? item1.disabled : false
                if (item1.children) {

                    if(item1.icon !== undefined) {
                        let title = item1.title !== undefined ? item1.title : ''
                        let description = item1.description !== undefined ? item1.description : ''
                        if(disabled) {
                            $(".context-right-inner-container").append('<div class="context-button context-button-disabled padding-right" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-children-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="contextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                        } else {
                            $(".context-right-inner-container").append('<div class="context-button padding-right" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-children-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="contextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                        }
                    } else {
                        let title = item1.title !== undefined ? item1.title : ''
                        let description = item1.description !== undefined ? item1.description : ''
                        if(disabled) {
                            $(".context-right-inner-container").append('<div class="context-button context-button-disabled padding-right" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-children-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="contextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                        } else {
                            $(".context-right-inner-container").append('<div class="context-button padding-right" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-children-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="contextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                        }
                    }
                    
                    if(!disabled) {
                        $("#contextmenu-"+index1).data("action",item1.action);
                        $("#contextmenu-"+index1).data("key",item1.key);
                        $("#contextmenu-"+index1).data("children",item1.children);
                    }
                }else{

                    if(item1.icon !== undefined) {
                        let title = item1.title !== undefined ? item1.title : ''
                        let description = item1.description !== undefined ? item1.description : ''
                        if(disabled) {
                            $(".context-right-inner-container").append('<div class="context-button-disabled" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="contextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-normal-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                        } else {
                            $(".context-right-inner-container").append('<div class="context-button" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="contextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-normal-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                        }
                    } else {
                        let title = item1.title !== undefined ? item1.title : ''
                        let description = item1.description !== undefined ? item1.description : ''
                        if(disabled) {
                            $(".context-right-inner-container").append('<div class="context-button context-button-disabled" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-normal-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                        } else {
                            $(".context-right-inner-container").append('<div class="context-button" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-normal-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                        }
                    }

                    if(!disabled) {
                        $("#contextmenu-"+index1).data("action",item1.action);
                        $("#contextmenu-"+index1).data("key",item1.key);
                        $("#contextmenu-"+index1).data("children",null);
                    }
                }
            })
        }else{
            //console.log("Not Back Button", event.target.id)
            if (event.target.id.split("-")[0] === 'contextmenu') {
                //console.log("context menu open")
                let action = $("#" + event.target.id).data('action');
                //console.log("action", action)
                let key = $("#" + event.target.id).data('key');
                //console.log("action", key)
                let children = $("#" + event.target.id).data('children');
                //console.log("action", children)
                //$(".context-right-inner-container").html("");

                if (children) {
                    //console.log("has children clear old menu :)")
                    // Create new Menu for children
                    if (action) {
                        $.post('https://np-ui/' + action, JSON.stringify({
                            key: key
                        }));
                    }
                    //console.log("ye ye clear")
                    $(".context-right-inner-container").html("");
                    $(".context-right-inner-container").append('<div id="backmenu" onclick="goBack()" class="context-button context-button-goback-margin" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"><div class="context-button-goback-flex"><div class="context-button-goback-chevron"><i class="fas fa-chevron-left fa-w-10 fa-fw"></i></div><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" style="word-break: break-word;">Go Back</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" style="word-break: break-word;"></p></div></div></div>')


                    $.each(children, function(index1, item1) {
                        let disabled = item1.disabled !== undefined ? item1.disabled : false
                        if (item1.children) {
                            if(item1.icon !== undefined) {
                                let title = item1.title !== undefined ? item1.title : ''
                                let description = item1.description !== undefined ? item1.description : ''
                                if(disabled) {
                                    $(".context-right-inner-container").append('<div class="context-button context-button-disabled padding-right" id="subcontextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="subcontextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-children-flex" id="subcontextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron id="subcontextmenu-' + index1 + '""><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                                } else {
                                    $(".context-right-inner-container").append('<div class="context-button padding-right" id="subcontextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="subcontextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-children-flex" id="subcontextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron id="subcontextmenu-' + index1 + '""><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                                }
                            } else {
                                let title = item1.title !== undefined ? item1.title : ''
                                let description = item1.description !== undefined ? item1.description : ''
                                if(disabled) {
                                    $(".context-right-inner-container").append('<div class="context-button context-button-disabled padding-right" id="subcontextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-children-flex" id="subcontextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="subcontextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                                } else {
                                    $(".context-right-inner-container").append('<div class="context-button padding-right" id="subcontextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-children-flex" id="subcontextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="subcontextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                                }
                            }

                            if(!disabled) {
                                $("#subcontextmenu-" + index1).data("action", item1.action);
                                $("#subcontextmenu-" + index1).data("key", item1.key);
                                $("#subcontextmenu-" + index1).data("children", item1.children);
                            }
                        } else {

                            if(item1.icon !== undefined) {
                                let title = item1.title !== undefined ? item1.title : ''
                                let description = item1.description !== undefined ? item1.description : ''
                                if(disabled) {
                                    $(".context-right-inner-container").append('<div class="context-button context-button-disabled" id="subcontextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="subcontextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-normal-flex" id="subcontextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                                } else {
                                    $(".context-right-inner-container").append('<div class="context-button" id="subcontextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="subcontextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-normal-flex" id="subcontextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                                }
                            } else {
                                let title = item1.title !== undefined ? item1.title : ''
                                let description = item1.description !== undefined ? item1.description : ''
                                if(disabled) {
                                    $(".context-right-inner-container").append('<div class="context-button context-button-disabled" id="subcontextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-normal-flex" id="subcontextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                                } else {
                                    $(".context-right-inner-container").append('<div class="context-button" id="subcontextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-normal-flex" id="subcontextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="subcontextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                                }
                            }

                            if(!disabled) {
                                $("#subcontextmenu-" + index1).data("action", item1.action);
                                $("#subcontextmenu-" + index1).data("key", item1.key);
                                $("#subcontextmenu-" + index1).data("children", null);
                            }
                        }
                    })

                    $.post('https://np-ui/'+action, JSON.stringify({
                        key:key
                    }));
                }else{
                    //Post data
                    //console.log("Dont have Chiclred and submit post data")
                    // contextmenuactive = false
                    $(".context-right-inner-container").html("");
                    $(".context-outer-container").hide();
                    $.post('https://np-ui/'+action, JSON.stringify({
                        key:key
                    }));
                    
                }
            }else if(event.target.id.split("-")[0] === 'subcontextmenu'){
                //console.log("Submit Post data")
                let subaction = $("#"+event.target.id).data('action');
                let subkey = $("#"+event.target.id).data('key');
                // console.log("This Sub Contextmenu",subaction,subkey)
                // contextmenuactive = false
                $(".context-right-inner-container").html("");
                $(".context-outer-container").hide();
                $.post('https://np-ui/'+subaction, JSON.stringify({
                    key:subkey
                }));
            }
        }
    }
})
// skillbarcode

document.addEventListener("keydown", function(ev) {
    if (skillbaractive) {
        let key_pressed = ev.key;
        let valid_keys = ['1','2','3','4'];

        if( valid_keys.includes(key_pressed) ){
            if( key_pressed === key_to_press ){
                let d_start = (180 / Math.PI) * g_start;
                let d_end = (180 / Math.PI) * g_end;
                if( degrees < d_start ){
                    console.log('Failed: Too soon!');
                    wrong();
                }else if( degrees > d_end ){
                    console.log('Failed: Too late!');
                    wrong();
                }else{
                    console.log('Success!');
                    correct();
                }
            }else{
                console.log('Failed: Pressed '+key_pressed+' instead of '+key_to_press);
                wrong();
            }
        }
    }
});

function goBack() {
    $(".context-right-inner-container").html("");
    $.each(menucontextdata, function(index1, item1) {
        let disabled = item1.disabled !== undefined ? item1.disabled : false
        if (item1.children) {
            //console.log("Have Chicldren")
            
            if(item1.icon !== undefined) {
                let title = item1.title !== undefined ? item1.title : ''
                let description = item1.description !== undefined ? item1.description : ''
                if(disabled) {
                    $(".context-right-inner-container").append('<div class="context-button context-button-disabled padding-right" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="contextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-children-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="contextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                } else {
                    $(".context-right-inner-container").append('<div class="context-button padding-right" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="contextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-children-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="contextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                }
            } else {
                let title = item1.title !== undefined ? item1.title : ''
                let description = item1.description !== undefined ? item1.description : ''
                if(disabled) {
                    $(".context-right-inner-container").append('<div class="context-button context-button-disabled padding-right" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-children-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="contextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                } else {
                    $(".context-right-inner-container").append('<div class="context-button padding-right" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-children-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> <div class="context-button-children-chevron" id="contextmenu-' + index1 + '"><i class="fas fa-chevron-right fa-w-10 fa-fw" style="color: #fff"></i></div></div>')
                }
            }
            
            if(!disabled) {
                $("#contextmenu-" + index1).data("action", item1.action);
                $("#contextmenu-" + index1).data("key", item1.key);
                $("#contextmenu-" + index1).data("children", item1.children);
            }
        } else {
            
            if(item1.icon !== undefined) {
                let title = item1.title !== undefined ? item1.title : ''
                let description = item1.description !== undefined ? item1.description : ''
                if(disabled) {
                    $(".context-right-inner-container").append('<div class="context-button context-button-disabled" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="contextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-normal-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                } else {
                    $(".context-right-inner-container").append('<div class="context-button" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div id="contextmenu-' + index1 + '" style="margin: auto 0px; width: 10%"><i class="fas fa-'+ item1.icon +' fa-w-14 fa-fw" style="color: #fff"></i></div> <div class="context-button-normal-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                }
            } else {
                let title = item1.title !== undefined ? item1.title : ''
                let description = item1.description !== undefined ? item1.description : ''
                if(disabled) {
                    $(".context-right-inner-container").append('<div class="context-button context-button-disabled" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-normal-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                } else {
                    $(".context-right-inner-container").append('<div class="context-button" id="contextmenu-' + index1 + '" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"> <div class="context-button-normal-flex" id="contextmenu-' + index1 + '"><div><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + title +'</p><p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" id="contextmenu-' + index1 + '" style="word-break: break-word;">' + description +'</p></div></div> </div>')
                }
            }
            
            if(!disabled) {
                $("#contextmenu-" + index1).data("action", item1.action);
                $("#contextmenu-" + index1).data("key", item1.key);
                $("#contextmenu-" + index1).data("children", null);
            }
            // console.log("Dont Have")
        }
    })
}