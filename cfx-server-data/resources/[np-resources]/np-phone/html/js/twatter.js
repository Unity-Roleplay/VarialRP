function addTweets(myHandle) {
    $(".twatter-handle").append(myHandle);
    setTimeout(() => {
        $.post('https://np-phone/np-phone:getTwatter', JSON.stringify({}), function (tweets) {
            $(".twatter-handle").empty();
            $(".twatter-entries").empty();
            if (tweets){
                for (let i = 0; i < Object.keys(tweets.data).length; i++) {
                    var obj = tweets.data[i]
                    var twat = obj.message;
                    var photoOf = obj.attachment;
                    var imageCheck;
                    var number;
                    var hide;
                    var date = (obj.time === undefined ? Date.now() : obj.time);
                    if (photoOf == '') {
                        imageCheck = 'none'
                        number = 0;
                        hide = '';
                    } else {
                        imageCheck = 'flex';
                        number = 1;
                        hide = 'Hide (click image to copy URL)';
                    }
                    if (twat !== "" || twat !== "undefined") {
                        var twatEntry = "";
                        if (imageCheck == "flex") {
                            twatEntry += `<div id="twat-box">
                            <div class="twat-user">
                               <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary twats-user" id="twats-user" style="word-break: break-word;">${obj.handle}</p>
                            </div>
                            <div id="twat-comment">
                               <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">
                                    ${twat}
                               </p>
                            </div>
                            <div class="component-image-container" style="min-height: 0;">
                               <div>
                                  <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">Images attached: ${number}</p>
                                  <div>
                                     <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" photourl="${photoOf}" style="text-decoration: underline;" id="hide-tweet">${hide}</p>
                                  </div>
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
                                  <div class="image twat-image-con" style="background-image: url(${photoOf}); display: none;">
                                  </div>
                                  <!-- <div class=""></div>
                                  <div class="spacer"></div> -->
                               </div>
                            </div>
                            <div class="twat-low" style="margin-top: 8px;">
                               <div class="twat-low-icons">
                                  <div title="Reply" aria-label="Reply" data-poster="${obj.handle}" class="t-reply-button twat-reply">
                                     <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="reply" class="svg-inline--fa fa-reply fa-w-16 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                        <path fill="currentColor" d="M8.309 189.836L184.313 37.851C199.719 24.546 224 35.347 224 56.015v80.053c160.629 1.839 288 34.032 288 186.258 0 61.441-39.581 122.309-83.333 154.132-13.653 9.931-33.111-2.533-28.077-18.631 45.344-145.012-21.507-183.51-176.59-185.742V360c0 20.7-24.3 31.453-39.687 18.164l-176.004-152c-11.071-9.562-11.086-26.753 0-36.328z">
                                        </path>
                                     </svg>
                                  </div>
                                  <div title="RT" aria-label="Retweet" data-rt="${twat}" data-poster="${obj.handle}" class="rt-btn twat-retweet">
                                     <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="retweet" class="svg-inline--fa fa-retweet fa-w-20 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                                        <path fill="currentColor" d="M629.657 343.598L528.971 444.284c-9.373 9.372-24.568 9.372-33.941 0L394.343 343.598c-9.373-9.373-9.373-24.569 0-33.941l10.823-10.823c9.562-9.562 25.133-9.34 34.419.492L480 342.118V160H292.451a24.005 24.005 0 0 1-16.971-7.029l-16-16C244.361 121.851 255.069 96 276.451 96H520c13.255 0 24 10.745 24 24v222.118l40.416-42.792c9.285-9.831 24.856-10.054 34.419-.492l10.823 10.823c9.372 9.372 9.372 24.569-.001 33.941zm-265.138 15.431A23.999 23.999 0 0 0 347.548 352H160V169.881l40.416 42.792c9.286 9.831 24.856 10.054 34.419.491l10.822-10.822c9.373-9.373 9.373-24.569 0-33.941L144.971 67.716c-9.373-9.373-24.569-9.373-33.941 0L10.343 168.402c-9.373 9.373-9.373 24.569 0 33.941l10.822 10.822c9.562 9.562 25.133 9.34 34.419-.491L96 169.881V392c0 13.255 10.745 24 24 24h243.549c21.382 0 32.09-25.851 16.971-40.971l-16.001-16z">
                                        </path>
                                     </svg>
                                  </div>
                                  <div title="Report" class="twat-report">
                                     <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="flag" class="svg-inline--fa fa-flag fa-w-16 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                        <path fill="currentColor" d="M349.565 98.783C295.978 98.783 251.721 64 184.348 64c-24.955 0-47.309 4.384-68.045 12.013a55.947 55.947 0 0 0 3.586-23.562C118.117 24.015 94.806 1.206 66.338.048 34.345-1.254 8 24.296 8 56c0 19.026 9.497 35.825 24 45.945V488c0 13.255 10.745 24 24 24h16c13.255 0 24-10.745 24-24v-94.4c28.311-12.064 63.582-22.122 114.435-22.122 53.588 0 97.844 34.783 165.217 34.783 48.169 0 86.667-16.294 122.505-40.858C506.84 359.452 512 349.571 512 339.045v-243.1c0-23.393-24.269-38.87-45.485-29.016-34.338 15.948-76.454 31.854-116.95 31.854z">
                                        </path>
                                     </svg>
                                  </div>
                               </div>
                               <div class="twat-low-time">
                                  <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${moment(date).local().fromNow()}</p>
                               </div>
                            </div>
                         </div>`
                        }else { //for no image
                            twatEntry += `<div id="twat-box">
                            <div class="twat-user">
                                <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary twats-user" id="twats-user" style="word-break: break-word;">${obj.handle}</p>
                            </div>
                            <div id="twat-comment">
                                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">
                                    ${twat}
                                </p>
                            </div>
                            <div class="component-image-container" style="min-height: 0;">
                                <div>
                                    <div>
                                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" photourl="${photoOf}" style="text-decoration: underline;" id="hide-tweet">${hide}</p>
                                    </div>
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
                                    <div class="image twat-image-con" style="background-image: url(${photoOf}); display: none;">
                                    </div>
                                    <!-- <div class=""></div>
                                    <div class="spacer"></div> -->
                                </div>
                            </div>
                            <div class="twat-low" style="margin-top: 8px;">
                                <div class="twat-low-icons">
                                    <div title="Reply" aria-label="Reply" data-poster="${obj.handle}" class="t-reply-button twat-reply">
                                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="reply" class="svg-inline--fa fa-reply fa-w-16 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                        <path fill="currentColor" d="M8.309 189.836L184.313 37.851C199.719 24.546 224 35.347 224 56.015v80.053c160.629 1.839 288 34.032 288 186.258 0 61.441-39.581 122.309-83.333 154.132-13.653 9.931-33.111-2.533-28.077-18.631 45.344-145.012-21.507-183.51-176.59-185.742V360c0 20.7-24.3 31.453-39.687 18.164l-176.004-152c-11.071-9.562-11.086-26.753 0-36.328z">
                                        </path>
                                        </svg>
                                    </div>
                                    <div title="RT" aria-label="Retweet" data-rt="${twat}" data-poster="${obj.handle}" class="rt-btn twat-retweet">
                                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="retweet" class="svg-inline--fa fa-retweet fa-w-20 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                                        <path fill="currentColor" d="M629.657 343.598L528.971 444.284c-9.373 9.372-24.568 9.372-33.941 0L394.343 343.598c-9.373-9.373-9.373-24.569 0-33.941l10.823-10.823c9.562-9.562 25.133-9.34 34.419.492L480 342.118V160H292.451a24.005 24.005 0 0 1-16.971-7.029l-16-16C244.361 121.851 255.069 96 276.451 96H520c13.255 0 24 10.745 24 24v222.118l40.416-42.792c9.285-9.831 24.856-10.054 34.419-.492l10.823 10.823c9.372 9.372 9.372 24.569-.001 33.941zm-265.138 15.431A23.999 23.999 0 0 0 347.548 352H160V169.881l40.416 42.792c9.286 9.831 24.856 10.054 34.419.491l10.822-10.822c9.373-9.373 9.373-24.569 0-33.941L144.971 67.716c-9.373-9.373-24.569-9.373-33.941 0L10.343 168.402c-9.373 9.373-9.373 24.569 0 33.941l10.822 10.822c9.562 9.562 25.133 9.34 34.419-.491L96 169.881V392c0 13.255 10.745 24 24 24h243.549c21.382 0 32.09-25.851 16.971-40.971l-16.001-16z">
                                        </path>
                                        </svg>
                                    </div>
                                    <div title="Report" class="twat-report">
                                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="flag" class="svg-inline--fa fa-flag fa-w-16 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                        <path fill="currentColor" d="M349.565 98.783C295.978 98.783 251.721 64 184.348 64c-24.955 0-47.309 4.384-68.045 12.013a55.947 55.947 0 0 0 3.586-23.562C118.117 24.015 94.806 1.206 66.338.048 34.345-1.254 8 24.296 8 56c0 19.026 9.497 35.825 24 45.945V488c0 13.255 10.745 24 24 24h16c13.255 0 24-10.745 24-24v-94.4c28.311-12.064 63.582-22.122 114.435-22.122 53.588 0 97.844 34.783 165.217 34.783 48.169 0 86.667-16.294 122.505-40.858C506.84 359.452 512 349.571 512 339.045v-243.1c0-23.393-24.269-38.87-45.485-29.016-34.338 15.948-76.454 31.854-116.95 31.854z">
                                        </path>
                                        </svg>
                                    </div>
                                </div>
                                <div class="twat-low-time">
                                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${moment(date).local().fromNow()}</p>
                                </div>
                            </div>
                            </div>`
                        }
                    }
    
                    $('.twatter-entries').on('click', '.blocker', function () {
                        $(this).css('display', 'none');
                        $(this).parent('.container-max-height').children('.twat-image-con').css('display', 'block')
                    });
                    $('.twatter-entries').on('click', '.twat-report', function () {
                        complateInputJustGreen();
                        $('#twat-modal').modal('close');
                    });
                    $('.twatter-entries').on('click', '.twat-image-con', function () {
                        var bg = $(this).css('background-image');
                        bg = /^url\((['"]?)(.*)\1\)$/.exec(bg);
                        bg = bg ? bg[2] : ""; // If matched, retrieve url, otherwise ""     
                        $(".viewImage").attr("src", bg);
                        $(".viewImage").show();         
                        copyToClipboard(bg);
                    });
    
                    $(".twatter-entries").mouseout('.twat-image-con',function () {
                        $(".viewImage").hide();
                        $("#viewImage").hide();
                    })
                    $(".twat-image-con").mouseout(function () {
                        $(".viewImage").hide();
                            $("#viewImage").hide();
                    })
                    function copyToClipboard(text) {
                        var sampleTextarea = document.createElement("textarea");
                        document.body.appendChild(sampleTextarea);
                        sampleTextarea.value = text; //save main text in it
                        sampleTextarea.select(); //select textarea contenrs
                        document.execCommand("copy");
                        document.body.removeChild(sampleTextarea);
                    }
                    $('.twatter-entries').prepend(twatEntry);
                }      
            }
        })
    }, 200);
}

$('.twat-message').keyup(debounce(function () {
    var i = $('.twat-message').val().length;
    $('#twat-lenght').text(`${i}` + '/255');
}, 1));

function cleareTwat() {
    $('.twat-message').val('');
    $('.twat-attach').val('');
    $('#twat-lenght').text('0/255');
}

$('.messages').on('click', '.msg-image', function () {
    var bg = $(this).css('background-image');
    let url = $(this).attr("img-url")
    bg = /^url\((['"]?)(.*)\1\)$/.exec(bg);
    // console.log("BG INBOX",url,bg)
    $(".viewImage").attr("src", url);
    $(".viewImage").show();         
    copyToClipboard(bg);
});

$(".messages").mouseout('.msg-image',function () {
    $(".viewImage").hide();
    $("#viewImage").hide();
});

function copyToClipboard(text) {
    var sampleTextarea = document.createElement("textarea");
    document.body.appendChild(sampleTextarea);
    sampleTextarea.value = text; //save main text in it
    sampleTextarea.select(); //select textarea contenrs
    document.execCommand("copy");
    document.body.removeChild(sampleTextarea);
}