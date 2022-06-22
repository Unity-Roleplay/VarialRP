var NotificationOpen = false;
var NotificationsTimeout = null;

function BottomSlideUp(Object, Timeout, Percentage) {
    $(Object).css("display", "block").animate({
        bottom: Percentage + "%",
    }, Timeout);
}

function BottomSlideDown(Object, Timeout, Percentage) {
    $(Object).css("display", "block").animate({
        bottom: Percentage + "%",
    }, Timeout, function(){
        $(Object).css("display", "none");
    });
}

function TopSlideDown(Object, Timeout, Percentage) {
    $(Object).css("display", "block").animate({
        top: Percentage + "%",
    }, Timeout);
};

function TopSlideUp(Object, Timeout, Percentage, cb) {
    $(Object).css("display", "block").animate({
        top: Percentage + "%",
    }, Timeout, function(){
        $(Object).css("display", "none");
    });
};

function notification(icon, title, text, timeout) {
    if (timeout == null && timeout == undefined) {
        timeout = 3000;
    }

    if (NotificationsTimeout == undefined || NotificationsTimeout == null) {
        if (phoneOpen == false) {
            openContainer("home");
            BottomSlideUp(".phone-shell", 350, -55);
        }

        TopSlideDown(".phone-notification-container", 200, 5);
        NotificationOpen = true;

        $(".notification-icon").html(`<i class="${icon}"></i>`);
        $(".notification-title").html(title);
        $(".notification-text").html(text);

        if (NotificationsTimeout !== undefined || NotificationsTimeout !== null) {
            clearTimeout(NotificationsTimeout);
        }

        NotificationsTimeout = setTimeout(function(){
            TopSlideUp(".phone-notification-container", 200, -8);
            NotificationOpen = false;
            NotificationsTimeout = null;

            setTimeout(() => {
                if (phoneOpen == false){
                    BottomSlideDown(".phone-shell", 350, -70);
                    closeContainer("home");
                }
            }, 500);
        }, timeout);
    } else {
        $(".notification-icon").html(`<i class="${icon}"></i>`);
        $(".notification-title").html(title);
        $(".notification-text").html(text);

        if (NotificationsTimeout !== undefined || NotificationsTimeout !== null) {
            clearTimeout(NotificationsTimeout);
        }

        NotificationsTimeout = setTimeout(function(){
            TopSlideUp(".phone-notification-container", 200, -8);
            NotificationOpen = false;
            NotificationsTimeout = null;

            setTimeout(() => {
                if (phoneOpen == false){
                    BottomSlideDown(".phone-shell", 350, -70);
                    closeContainer("home");
                }
            }, 500);
        }, timeout);
    }
};

// notification("fab fa-twitter", "pinto", "dfusafhsufhsf", 5000)