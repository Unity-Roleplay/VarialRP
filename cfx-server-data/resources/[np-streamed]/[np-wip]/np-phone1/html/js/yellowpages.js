function addYellowPages(list) {
    $(".yellow-pages-entries").empty();

    if (list && Object.keys(list).length > 0) {
        for (let message of list) {
            if (message) {
                let yellowPage

            yellowPage = `
                <div class="row no-padding">
                    <div class="col s12">
                        <div class="card yellow darken-1 yellow-page-entry">
                            <div class="card-content black-text yellow-page-body center-align">
                                <strong>${message.message}</strong>`
                            if (message.image) {
                                yellowPage += `<img src="${message.message}"/>`
                            }
            yellowPage += `</div>
                            <div class="card-action" style="padding-top: 8px;padding-right: 16px;padding-bottom: 8px;padding-left: 16px;font-size:14px">
                                <div class="row no-padding">
                                    <div class="col s6">
                                        <span aria-label="Call" data-balloon-pos="down-left" data-number="${message.phone}" class="yellow-pages-call">
                                            <i class="fas fa-phone-alt fa-1x"></i> ${message.phone}
                                        </span>
                                    </div>
                                    <div class="col s6" data-balloon-length="medium" aria-label="${message.name}" data-balloon-pos="down-right">
                                        <span class="truncate">
                                            <i class="fas fa-user-circle fa-1x"></i> ${message.name}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>`

                $('.yellow-pages-entries').prepend(yellowPage);
            }
        }
    }

    openContainer("yellow-pages");
}