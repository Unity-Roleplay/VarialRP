function addAccountInformation(accountInfo) {
    if (accountInfo) {
        let number = accountInfo.phone.toString()
        let phoneNumber = `(${number.slice(0, 3)}) ${number.slice(3, 6)}-${number.slice(6, 10)}`

        $(".account-information-cid").text(accountInfo.cid);
        $(".account-information-accountid").text(accountInfo.accountid);
        $(".account-information-phone").text(phoneNumber);
        $(".account-information-cash").text(`$${accountInfo.cash.toLocaleString()}.00`);
        $(".account-information-bank").text(`$${accountInfo.bank.toLocaleString()}.00`);
        $(".account-information-casino").text(`$${accountInfo.casino.toLocaleString()}.00`);
        $(".account-information-primary-job").text(accountInfo.job);

        let licensesObject = accountInfo.licenses
        let licenseTable =
        `<table class="responsive-table license-table" style="margin-top: 5%;">
            <thead>
            </thead>
        <tbody>`

        for (const key of Object.keys(licensesObject)) {
            licenseTable +=
            `<tr style="border: none; margin-top: 0%;">
                <td>${key}</td>
                <td class="center-align" style="font-size: 1.2rem;"><i class="${licensesObject[key] > 0 ? "fas fa-check-circle green-text text-lighten-1" : "fas fa-times-circle red-text text-lighten-1"}"></i></td>
            </tr>`
        }


        licenseTable +=`</tbody>
        </table>
        `

        $(".account-information-licenses").html(licenseTable);
    }

    openContainer("account-information");
};