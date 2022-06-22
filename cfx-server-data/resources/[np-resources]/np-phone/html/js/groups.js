

function addIdleGroup(IdleGroup){
    let counts = 0
    $(".idle-g-entries").empty()
    for (let group of Object.keys(IdleGroup)) {
        const gGroup = IdleGroup[group].members
        console.log(gGroup,gGroup.length)
            let length =  gGroup.length;

        // 
    // console.log("??",length,gGroup)
        // console.log("WTF",IdleGroup[group].member)
        // console.log("COPINT",IdleGroup[group].member.length)
        let element = `
        <div class="sanitation-group" style=" margin-top: 15px;">
        <i class="fas fa-users-slash" style="margin-bottom: -15px; left: 15px;"></i>
        <span style="color: white; margin-left: 10px; margin-top: -3px; width: 169px; font-size: 15px;">${IdleGroup[group].name}</span>
        <span style="color: #f0eeec; margin-left: -152px; margin-top: 25px; width: 169px; font-size: 15px;"><i gId="${IdleGroup[group].id}" members="${gGroup}" class="fas fa-sign-in-alt g-join" aria-label="Join" style="font-size: 1rem;"></i></span>
        <span style="color: #f0eeec; right: -75px; margin-top: 25px; width: 169px; font-size: 15px; position: absolute;"><i class="fas fa-people-arrow-left" style="font-size: 1rem; margin-right: 0.5px;"> ${length}</i></span>
        <span style="color: #f0eeec; right: -115px; margin-top: 25px; width: 169px; font-size: 15px; position: absolute;"><i class="fas fa-user" style="font-size: 1rem; margin-right: 1.5px;"> ${length}</i></span>
    </div>
    `
    $('.idle-g-entries').append(element);
    
    }
    $('.g-join').click(function(){
        console.log("JOIN GROUP",)
        gid = $(this).attr("gId")
        members = $(this).attr("members")
        console.log("gid,members",gid,members)
        $.post("https://np-phone/j_group", JSON.stringify({
            gId: gid,
            members: members
        }))
        
    })
}

function addGroupLeader(leaders,stat){
    $(".groupLeader-entries").empty()
    console.log("LEADERS",leaders.name,JSON.stringify(leaders))
    if (stat === 0){
        console.log("LEADERS",leaders.name,JSON.stringify(leaders))
            $('#not-ready').attr("gId", leaders.id)
            $('#b-g-ready').attr("gId", leaders.id)
            $('#g-disband').attr("gId", leaders.id)
            let gleader = ` <ul class="row collapsible groupLeader-entries">
            <div class="groupLeader-group" style="font-size:10px; margin-top: 5px;">
                <span class="g-dot" style="left: 16vw; margin-top: -9px;"></span>
                <i class="fas fa-user-graduate" style="margin-top: -7px; margin-left: 5px;"></i>
                <span class="group-leader" gid="${leaders.id}" style="color: white; margin-top: -10px; width: 169px; font-size: 15px;">${leaders.name}</span>
            </div>
        </ul>`
        $('.groupLeader-entries').append(gleader);
    }else{
        $('#not-ready').attr("gId", leaders.id)
        $('#b-g-ready').attr("gId", leaders.id)
        let gleader = ` <ul class="row collapsible groupLeader-entries">
        <div class="groupLeader-group" style="font-size:10px; margin-top: 5px;">
            <span class="g-dot" style="left: 16vw; margin-top: -9px;"></span>
            <i class="fas fa-user-graduate" style="margin-top: -7px; margin-left: 5px;"></i>
            <span class="group-leader" gid="${leaders.id}" style="color: white; margin-top: -10px; width: 169px; font-size: 15px;">${leaders.name}</span>
        </div>
    </ul>`
        $('.groupLeader-entries').append(gleader);
    }
    
}


function addGroupMembers(group,src){
    console.log("MY SRC",src)
    $('#not-ready').attr("gId", group.gid)
    $('#b-g-ready').attr("gId", group.gid)
    $('#g-disband').attr("gId", group.gid)
    if (src == group.src){
        console.log("NEED TO DISALBE READY")
        $('.b-g-ready').css('display', 'none')
        $(".g-disband").text("Leave Group")
    }
    
        let members = ` <ul class="row collapsible groupMembers-entries">
                        <div class="groupLeader-group" style="font-size:10px; margin-top: 5px;">
                            <span class="g-dot" style="left: 16vw; margin-top: -9px;"></span>
                            <i class="fas fa-user" style="margin-top: -7px; margin-left: 5px;"></i>
                            <span style="color: white; margin-top: -10px; width: 169px; font-size: 15px;">${group.name}</span>
                        </div>
                    </ul>`
     $('.groupLeader-entries-wrapper').append(members);
}
let ready = 0
$('.b-g-ready').click(function(){
    let gId = $(this).attr("gid")
    console.log("GROUP ID", gId)
    if (ready == 0){
        ready = 1
        $(".sonar-wrapper").css('display', 'block')
        $(".b-g-ready").text("Not Ready for jobs")
        $.post("https://np-phone/group_status", JSON.stringify({
            status: true,
            gId: gId
        }))
    }else{
        ready = 0
        $(".sonar-wrapper").css('display', 'none')
        $(".b-g-ready").text("Ready for jobs")
        $.post("https://np-phone/group_status", JSON.stringify({
            status: false,
            gId: gId
        }))
    }
})

$('#create-Group').click(function(){
    console.log("CREATE GROUP")
    $.post("https://np-phone/c_group", JSON.stringify({}))
    complateInputJustGreen();
        setTimeout(() => {
            // $.post("https://np-phone/btnDebt", JSON.stringify({}))
            openContainer("groupLeader")
        }, 2000);
})

$('.g-disband').click(function(){
    let gId = $(this).attr("gid")
    console.log("LEAVE OR DISBAND GROUP",gId)
    $.post("https://np-phone/leave_group", JSON.stringify({
        gid: gId
    }))
    complateInputJustGreen();
        setTimeout(() => {
            // $.post("https://np-phone/btnDebt", JSON.stringify({}))
            openContainer("sanitation")
    }, 2000);
})


window.onload = function(){
	if(ready == 0){
        $(".not-ready").css('display', 'none')
    }
};
