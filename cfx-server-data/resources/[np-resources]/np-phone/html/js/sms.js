function addMessage(item) {
    
    var date = (item.date === undefined ? Date.now() : item.date);
    if(item.unread === 0)
    var element = $(`<div id="${item.number}" receiver="" sender="" class="component-paper" style="
        width: 87%;
        left: 16px;
    ">
        <div class="main-container">
            <div class="image">
                <svg aria-hidden="true" focusable="false" data-prefix="fas"
                    data-icon="user-circle" class="svg-inline--fa fa-user-circle fa-w-16 fa-fw fa-3x " role="img"
                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 496 512">
                    <path fill="currentColor"
                    d="M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z">
                    </path>
                </svg>
            </div>
            <div class="details ">
                <div class="title ">
                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word;">` + item.msgDisplayName + `</p>
                </div>
                <div class="description ">
                    <div class="flex-row">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas"
                        data-icon="share" class="svg-inline--fa fa-share fa-w-16 fa-fw fa-sm " role="img"
                        xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" style="margin-right: 8px;">
                        <path fill="currentColor"
                            d="M503.691 189.836L327.687 37.851C312.281 24.546 288 35.347 288 56.015v80.053C127.371 137.907 0 170.1 0 322.326c0 61.441 39.581 122.309 83.333 154.132 13.653 9.931 33.111-2.533 28.077-18.631C66.066 312.814 132.917 274.316 288 272.085V360c0 20.7 24.3 31.453 39.687 18.164l176.004-152c11.071-9.562 11.086-26.753 0-36.328z">
                        </path>
                    </svg>
                    <p class="MuiTypography-root text-clip MuiTypography-body2 MuiTypography-colorTextPrimary"
                        style="word-break: break-word;">` + item.message + `</p>
                    </div>
                </div>
            </div>
        </div>
        </div>`)
    else{
        var element = $(`<div id="${item.number}" receiver="" sender="" class="component-paper" style="
        width: 87%;
        left: 16px;
    ">
        <div class="main-container">
            <div class="image">
                <svg aria-hidden="true" focusable="false" data-prefix="fas"
                    data-icon="user-circle" class="svg-inline--fa fa-user-circle fa-w-16 fa-fw fa-3x " role="img"
                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 496 512">
                    <path fill="currentColor"
                    d="M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z">
                    </path>
                </svg>
            </div>
            <div class="details ">
                <div class="title ">
                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word;">` + item.msgDisplayName + `</p>
                </div>
                <div class="description ">
                    <div class="flex-row">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas"
                        data-icon="share" class="svg-inline--fa fa-share fa-w-16 fa-fw fa-sm " role="img"
                        xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" style="margin-right: 8px;">
                        <path fill="currentColor"
                            d="M503.691 189.836L327.687 37.851C312.281 24.546 288 35.347 288 56.015v80.053C127.371 137.907 0 170.1 0 322.326c0 61.441 39.581 122.309 83.333 154.132 13.653 9.931 33.111-2.533 28.077-18.631C66.066 312.814 132.917 274.316 288 272.085V360c0 20.7 24.3 31.453 39.687 18.164l176.004-152c11.071-9.562 11.086-26.753 0-36.328z">
                        </path>
                    </svg>
                    <p class="MuiTypography-root text-clip MuiTypography-body2 MuiTypography-colorTextPrimary"
                        style="word-break: break-word;">` + item.message + `</p>
                    </div>
                </div>
            </div>
        </div>
        </div>`);
    }
//<span class="new-badge" style="margin-left: 10px;margin-top: 40px;" data-badge-caption="">${moment(date).local().fromNow()}</span>
    element.id = item.id;
    element.click(function () {
        if(item.unread === 0){
            console.log("CLICK READ")
            $.post('http://np-phone/readMessage', JSON.stringify({ id: item.id }));
        }
        setTimeout(() => {
            $("#messages-second-container").animate({ left: "0px" }, 100)
            $("#messages-container").animate({ left: "-280px" }, 750)
        }, 100);
        
        $.post('http://np-phone/messageRead', JSON.stringify({ sender: item.sender, receiver: item.receiver, displayName: item.msgDisplayName }));
    });
    $(".messages-entries").prepend(element);
}


function addMessageOther(item) {
    // Check if message is already added
    var receiver = item.name || item.receiver;
    var date = (item.date === undefined ? Date.now() : item.date);
    var element = $('<div class="row messages-entry"> <div class="col s2 black-text"> <i class="far fa-user-circle fa-2x"></i> </div> <div class="col s10 messages-entry-details"> <div class="row no-padding"> <div class="col s8 messages-entry-details-sender">' + item.msgDisplayName + '</div> <div class="col s4 messages-entry-details-date right-align">' + moment(date).local().fromNow() + '</div> </div> <div class="row "> <div class="col s12 messages-entry-body">' + item.message + '</div> </div> </div> </div>');
    element.id = item.id;
    element.click(function () {
        $.post('http://np-phone/messageRead', JSON.stringify({ sender: item.sender, receiver: item.receiver, displayName: receiver, clientPhone: item.clientNumber }));
    });
    $(".messages-entries").prepend(element);
}

function validURL(string) {
	let pattern = /(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g;
	let data = string.match(pattern);
	return (data)
};

function addMessageRead(item, clientNumber, displayName) {

    var date = (item.date === undefined ? Date.now() : item.date);
    // If its "us" sending it, place it on the right
    const msgImage = validURL(item.message); //picture message insert
    // console.log(Number(displayName),isNumber(Number(displayName)))
    $('.message-icon').css('display', 'block');
    $('#message-name').css('display', 'block');
    $('#message-number').css('display', 'block');
    $('.message-sender').css('display', 'none');
    if (isNumber(Number(displayName)) !== true){
        $('.messages-add-new-contact').css('display', 'none');
        $('#message-name').css('display', 'block');        
    }else{
        $('#addIcon').empty()
        $('#message-name').css('display', 'none');
        $('.messages-add-new-contact').css('display', 'block');
        $("#addIcon").append(`
        <i class="fas fa-user-plus white-text messages-add-new-contact" aria-label="Add Contact" style="right: 228px;top: 54px;display: block;display: absolute;"></i>`)
    }
   
    var imageCheck;
    var number;
    var hide;
    if (msgImage == null) {
        imageCheck = 'none'
        number = 0;
        hide = '';
    } else {
        imageCheck = 'flex';
        number = 1;
        hide = 'Hide (click image to copy URL)';
    }
    // console.log("IMAGES",msgImage,JSON.stringify(msgImage))
    // console.log(imageCheck,number,hide)
    if (msgImage) {
        if (item.sender === clientNumber) {
            var msg = item.message.replace(msgImage, "")
            var element = `<li class="message message-out">
            <div class="inner inner-out"> `
            element += `<div id="twat-comment">
            <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">
                 ${msg}
            </p>
         </div><div class="component-image-container" style="min-height: 0;">
            
               <div>
                  <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" photourl="${msgImage}" style="text-decoration: underline;" id="hide-tweet">${hide}</p>

            </div>
            <div class="container container-max-height" style="display: ${imageCheck}">
               <div class="blocker">
                  <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye" class="svg-inline--fa fa-eye fa-w-18 fa-fw fa-3x " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                     <path fill="currentColor" d="M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z">
                     </path>
                  </svg>
                  <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" style="word-break: break-word;">Click to View</p>
                  <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="text-align: center; margin-top: 8px;">Only reveal images from those you know are not
                     total pricks
                  </p>
               </div>
               <div class="image msg-image" img-url="${msgImage}" style="background-image: url(${msgImage}); display: none;">
               </div>
               <!-- <div class=""></div>
               <div class="spacer"></div> -->
            </div>
         </div>`
            // element +=`<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${msg}<img src="${msgImage}" id="txt-img" class="msg-image" onerror="this.onerror=null; this.src="https://cdn-icons-png.flaticon.com/512/624/624815.png""></p></div>`
            element +=`</div><div class="timestamp timestamp-in"><span aria-label="${moment(date).local().calendar(null, calendarFormatDate)}" data-balloon-pos="left"><p class="MuiTypography-root timestamp MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${moment(date).local().fromNow()}</p></div></li>`
            // var element = $('<div class="row message-entry"><div class="Messageright">' + msg + '<img src="'+msgImage+'" id="txt-img" class="msg-image" onerror="this.onerror=null; this.src="https://media.istockphoto.com/vectors/window-operating-system-error-warning-illustration-on-white-isolated-vector-id943008240?k=6&m=943008240&s=612x612&w=0&h=4LxxYIytSex0wQjHDJ8uBlzXWMsJ2Tw1Y9fhb_aqBmE""></div></div></div><div class="message-details">' + '<span aria-label="' + moment(date).local().calendar(null, calendarFormatDate) + '" data-balloon-pos="left">' + moment(date).local().fromNow() + '</span></div>');
            element.id = item.id;
            $(".messages").append(element);
            $('.messages').data("sender", item.receiver);
            $('.messages').attr("sender", item.receiver);
            console.log(item.receiver,item.sender)
            $('#msg-sender').val(item.receiver)
            $('#msg-receiver').val(item.receiver)
            $('#message-number').empty()
            var phoneNumber =  '(' + item.receiver.slice(0, 3) + ') ' + item.receiver.slice(3, 6) + '-' + item.receiver.slice(6, 10);
            $("#message-number").append(phoneNumber);
            $('.messages').on('click', '.blocker', function () {
                $(this).css('display', 'none');
                $(this).parent('.container-max-height').children('.msg-image').css('display', 'block')
            });
        } else {
            var msg = item.message.replace(msgImage, "")
            var element = `<li class="message message-in">
            <div class="inner inner-in"> `
            element += `<div id="twat-comment">
            <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">
                 ${msg}
            </p>
         </div><div class="component-image-container" style="min-height: 0;">
            
               <div>
                  <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" photourl="${msgImage}" style="text-decoration: underline;" id="hide-tweet">${hide}</p>

            </div>
            <div class="container container-max-height" style="display: ${imageCheck}">
               <div class="blocker">
                  <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye" class="svg-inline--fa fa-eye fa-w-18 fa-fw fa-3x " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                     <path fill="currentColor" d="M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z">
                     </path>
                  </svg>
                  <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" style="word-break: break-word;">Click to View</p>
                  <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="text-align: center; margin-top: 8px;">Only reveal images from those you know are not
                     total pricks
                  </p>
               </div>
               <div class="image msg-image" style="background-image: url(${msgImage}); display: none;">
               </div>
               <!-- <div class=""></div>
               <div class="spacer"></div> -->
            </div>
         </div>`
            // element +=`<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${msg}<img src="${msgImage}" id="txt-img" class="msg-image" onerror="this.onerror=null; this.src="https://cdn-icons-png.flaticon.com/512/624/624815.png""></p></div>`
            element +=`</div><div class="timestamp timestamp-in"><span aria-label="${moment(date).local().calendar(null, calendarFormatDate)}" data-balloon-pos="left"><p class="MuiTypography-root timestamp MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${moment(date).local().fromNow()}</p></div></li>`
            // var element = $('<div class="row message-entry"><div class="Messageleft">' + msg + '</div></div></div><div class="message-details-in">' + '<span aria-label="' + moment(date).local().calendar(null, calendarFormatDate) + '" data-balloon-pos="left">' + moment(date).local().fromNow() + '</span></div>');
            element.id = item.id;
            $(".messages").append(element);
            $('.messages').data("sender", item.sender);
            $('.messages').data("receiver", item.sender);
            $('.messages').attr("sender", item.receiver);
            $('#msg-sender').val(item.receiver)
            $('#msg-receiver').val(item.sender)
            $('#message-number').empty()
            var phoneSNumber =  '(' + item.sender.slice(0, 3) + ') ' + item.sender.slice(3, 6) + '-' + item.sender.slice(6, 10);
            $("#message-number").append(phoneSNumber);
            $('.messages').on('click', '.blocker', function () {
                $(this).css('display', 'none');
                $(this).parent('.container-max-height').children('.msg-image').css('display', 'block')
            });
        }
    }else{
        if (item.sender === clientNumber) {
            var element = $('<li class="message message-out"><div class="inner inner-out"> <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">' + item.message + '</p></div><div class="timestamp timestamp-in"><p class="MuiTypography-root timestamp MuiTypography-body2 MuiTypography-colorTextPrimary" aria-label="' + moment(date).local().calendar(null, calendarFormatDate) + '" style="word-break: break-word;">' + moment(date).local().fromNow() + '</p></div></li>');
            // var element = $('<div class="row message-entry"><div class="Messageright">' + item.message + '</div></div><div class="message-details">' + '<span aria-label="' + moment(date).local().calendar(null, calendarFormatDate) + '" data-balloon-pos="left">' + moment(date).local().fromNow() + '</span></div>');
            element.id = item.id;
            $(".messages").append(element);
            $('.messages').data("sender", item.receiver);
            $('.messages').data("receiver", item.receiver);
            $('#msg-sender').val(item.receiver)
            $('#msg-receiver').val(item.sender)
            $('#message-number').empty()
            var phoneNumber =  '(' + item.receiver.slice(0, 3) + ') ' + item.receiver.slice(3, 6) + '-' + item.receiver.slice(6, 10);
            $("#message-number").append(phoneNumber);
        } else {
            var element = $('<li class="message message-in"><div class="inner inner-in"><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">' + item.message + '</p></div><div class="timestamp timestamp-out"><span aria-label="' + moment(date).local().calendar(null, calendarFormatDate) + '" data-balloon-pos="left"><p class="MuiTypography-root timestamp MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">' + moment(date).local().fromNow() + '</p></div></li>');
            // var element = $('<div class="row message-entry"><div class="Messageleft">' + item.message + '</div></div><div class="message-details-in">' + '<span aria-label="' + moment(date).local().calendar(null, calendarFormatDate) + '" data-balloon-pos="left">' + moment(date).local().fromNow() + '</span></div>');
            element.id = item.id;
            $(".messages").append(element);
            $('.messages').data("sender", item.sender);
            $('.messages').data("receiver", item.sender);
            
            $('#msg-sender').val(item.sender)
            $('#msg-receiver').val(item.sender)
            $('#message-number').empty()
            var phoneSNumber =  '(' + item.sender.slice(0, 3) + ') ' + item.sender.slice(3, 6) + '-' + item.sender.slice(6, 10);
            $("#message-number").append(phoneSNumber);
        }
    }
    $('.messages').data("displayName", displayName);
    $('.messages').data("clientNumber", clientNumber);
}