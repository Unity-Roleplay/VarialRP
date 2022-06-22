$('.send-money').click(function(){
    $('.wenmoform').css('display', 'flex')
}) //wenmoform


$('.wenmoform').on('click', '#close-input', function(){
    $('.wenmoform').css('display', 'none')
})

$('.wenmoform').on('click', '#submit-input', function(){
    $('.wenmoform').css('display', 'none')
    let num = $('.bank-transfer-no').val()
    let amount = $('#bankammount').val()
    let comment = $('.bank-transfer-comment').val()
    complateInputJustGreen();
    setTimeout(() => {
        $.post('http://np-phone/wenmoSubmit', JSON.stringify({
            num: num,
            amount: amount,
            comment: comment
        }));
        $('.bank-transfer-no').val("")
        $('.bank-transfer-ammount').val("")
        $('.bank-transfer-comment').val("")
        setTimeout(() => {
            AddWenmo()
        }, 500);
    }, 1000);
})

function AddWenmo(){
    $.post('https://np-phone/np-phone:getWenmo', JSON.stringify({}), function (wenmo) {
        $(".wbank-container4").empty();
        $('.wbank-container4 .component-paper').children('.main-container').next().css("display", "none");
        if (wenmo){
            for (let i = 0; i < Object.keys(wenmo.data).length; i++) {
                var obj = wenmo.data[i]
                var amount = obj.amount.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
                var date = (obj.date === undefined ? Date.now() : obj.date);
                let name = "";
                let cpNumber = 0;
                var wenmoEntry = "";
                wenmoEntry += `<li id="${obj.id}" class="component-paper bank-count">
                <div class="main-container clicked-function-container">
                   <div style="width:100%;">
                     <div class="wbank-jss140">`
                     if(obj.status == "receive"){
                         cpNumber = obj.fromto
                        wenmoEntry +=`<p class="MuiTypography-root out MuiTypography-body2 MuiTypography-colorPrimary gidenpara" style="word-break: break-word;">${amount}</p>`
                     }else{
                        cpNumber = obj.numto
                        wenmoEntry +=`<p class="MuiTypography-root out MuiTypography-body2 MuiTypography-colorSecondary gidenpara" style="word-break: break-word;">-${amount}</p>`
                     }
                      
                       wenmoEntry+=`<p class="MuiTypography-root out MuiTypography-body2 MuiTypography-colorTextPrimary gidenpara" style="word-break: break-word;">${obj.name}</p>
                     </div>
                     <div style="display: flex; justify-content: space-between;">
                     <p class="MuiTypography-root MuiTypography-body2 out MuiTypography-colorTextPrimary" style="word-break: break-word; font-weight: 200;"></p>
                        <p class="MuiTypography-root MuiTypography-body2 out MuiTypography-colorTextPrimary" style="word-break: break-word; font-weight: 200;">${moment(date).local().fromNow()}</p>
                     </div>
                    </div>
                </div>
                <div class="drawer" style="display: none;">
                    <div class="item" style="height: 30px; border-radius: 0px;">
                        <div class="icon">
                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marker-alt"
                                class="svg-inline--fa fa-map-marker-alt fa-w-12 fa-fw " role="img"
                                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
                                <path fill="currentColor"
                                    d="M256 31.1c-141.4 0-255.1 93.12-255.1 208c0 49.62 21.35 94.98 56.97 130.7c-12.5 50.37-54.27 95.27-54.77 95.77c-2.25 2.25-2.875 5.734-1.5 8.734c1.249 3 4.021 4.766 7.271 4.766c66.25 0 115.1-31.76 140.6-51.39c32.63 12.25 69.02 19.39 107.4 19.39c141.4 0 255.1-93.13 255.1-207.1S397.4 31.1 256 31.1zM127.1 271.1c-17.75 0-32-14.25-32-31.1s14.25-32 32-32s32 14.25 32 32S145.7 271.1 127.1 271.1zM256 271.1c-17.75 0-31.1-14.25-31.1-31.1s14.25-32 31.1-32s31.1 14.25 31.1 32S273.8 271.1 256 271.1zM383.1 271.1c-17.75 0-32-14.25-32-31.1s14.25-32 32-32s32 14.25 32 32S401.7 271.1 383.1 271.1z">
                                </path>
                            </svg>
                        </div>
                        <div class="">
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                            style="word-break: break-word;">${obj.comment}</p>
                        </div>
                    </div>
                    <div class="item" style="height: 30px; border-radius: 0px;">
                        <div class="icon">
                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marker-alt"
                                class="svg-inline--fa fa-map-marker-alt fa-w-12 fa-fw " role="img"
                                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
                                <path fill="currentColor"
                                    d="M384 0H96C60.65 0 32 28.65 32 64v384c0 35.35 28.65 64 64 64h288c35.35 0 64-28.65 64-64V64C448 28.65 419.3 0 384 0zM240 128c35.35 0 64 28.65 64 64s-28.65 64-64 64c-35.34 0-64-28.65-64-64S204.7 128 240 128zM336 384h-192C135.2 384 128 376.8 128 368C128 323.8 163.8 288 208 288h64c44.18 0 80 35.82 80 80C352 376.8 344.8 384 336 384zM496 64H480v96h16C504.8 160 512 152.8 512 144v-64C512 71.16 504.8 64 496 64zM496 192H480v96h16C504.8 288 512 280.8 512 272v-64C512 199.2 504.8 192 496 192zM496 320H480v96h16c8.836 0 16-7.164 16-16v-64C512 327.2 504.8 320 496 320z">
                                </path>
                            </svg>
                        </div>
                        <div class="">
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                            style="word-break: break-word;">${cpNumber}</p>
                        </div>
                    </div>
                </div>
             </li>`
                $(".wbank-container4").prepend(wenmoEntry);
                $("#" + obj.id).click(function () {
                    if (drawer) {
                        $(this).children('.main-container').next().css("display", "none");
                        drawer = 0
                    } else {
                        $(this).children('.main-container').next().css("display", "flex");
                        drawer = 1
                    }
                });
            }
           
        }
    })
}