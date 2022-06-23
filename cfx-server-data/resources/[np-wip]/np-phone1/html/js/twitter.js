function addTweets(tweets, myHandle) {
    $(".twatter-entries").empty();

    $(".twatter-handle").empty();
    $(".twatter-handle").append(myHandle);

    if (tweets && Object.keys(tweets).length > 0) {
        for (let message of tweets) {
            if (message && message.name && message.message) {
                if (message.message !== "") {
                    let twatEntry
                    twatEntry = `<div class="row no-padding">
                                <div class="col s12">
                                    <div class="card blue darken-3 twat-card">
                                        <div class="card-content white-text twatter-content">
                                            <span class="card-title twatter-title">${message.name}</span>
                                            <p>${message.message}</p>`
                                        if (message.image) {
                                            twatEntry += `<br><img src="${message.image}" width="100%" height="100%"></img>`
                                        }
                                        twatEntry += `</div>
                                        <div class="card-action" style="padding-top: 8px;padding-right: 16px;padding-bottom: 8px;padding-left: 16px;">
                                            <span data-poster="${message.name}" class="twat-reply white-text"><i class="fas fa-reply fa-1x"></i></span>
                                            <span class="right white-text" aria-label="${moment.utc(message.time).local().calendar(null, calendarFormatDate)}" data-balloon-pos="down">${moment.utc(message.time).local().fromNow()}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>`

                    $(".twatter-entries").prepend($(twatEntry));
                }
            }
        }
    }

    openContainer("twatter");
    $('.notification-twatter').fadeOut(150);
}

$(".twatter-send").click(function (e) {
    e.preventDefault();
    $("#twat-modal").modal("open");
});

$("#twat-form").submit(function (event) {
    event.preventDefault();

    let image = decodeHTML(escapeHtml($("#twat-form #twat-image").val()))
    if (image.startsWith("https://") == false) {
        image = false
    }

    $.post("https://np-phone/newTwatSubmit", JSON.stringify({
        twat: escapeHtml($("#twat-form #twat-body").val()),
        image: image,
        time: moment.utc(),
    }));

    $("#twat-form").trigger("reset");
    $("#twat-modal").modal("close");
});

$('.twatter-entries').on('click', '.twat-reply', function () {
    $('#twat-modal').modal('open');
    $('#twat-form #twat-body').text($(this).data('poster') + " ");
    M.updateTextFields();
});