function addEmails(emails) {
    $('.emails-entries').empty();

    for (let email of Object.keys(emails)) {
        let emailElement = `
        <div class="row">
            <div class="col s12 center-align">
                <div class="card-panel emails-card">
                    <span>${emails[email].message}</span>
                </div>
            </div>
        </div>
        `
        $('.emails-entries').prepend(emailElement);
    }

    openContainer("emails");
}