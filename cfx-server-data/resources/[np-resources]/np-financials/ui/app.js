var currentAction;
var currentAccount;
var userData;

$(document).ready(function () {

    window.addEventListener("message", function (event) {
        switch (event.data.type) {
            case "open":
                userData = event.data;
                loadAccounts();
                break;
            default:
                break;
        }
    });

    function loadAccounts() {
        $.post("https://np-financials/np-ui:getAccounts", JSON.stringify({
            id: userData.account_id,
            name: userData.account_name,
            cid: userData.character_id
        }),
        function(pData) {
            openMainScreen({
                is_atm: pData.data.is_atm,
                accounts: pData.data.accounts
            })
        })
    }

    function openMainScreen(pData) {
        getCash();

        $("#accounts").empty();

        for (var i = 0; i < pData.accounts.length; i++) {
            let element = `
            <div id="${pData.accounts[i].id}" class="jss1465 jss1475 jss1466">
                <p id="account_info_${pData.accounts[i].id}" class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" title="Account Name / Account ID" style="display: inline-block;">${pData.accounts[i].name} / ${pData.accounts[i].id}</p>
                <div class="jss1467 jss1477">
                    <div>
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" title="Account Type" style="word-break: break-word; width: 150%;">${pData.accounts[i].type}</p>
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word; margin-right: -75%;">${pData.accounts[i].owner_first_name} ${pData.accounts[i].owner_last_name}</p>
                    </div>
                    <div id="account_balance_${pData.accounts[i].id}" style="margin: 8px 0px;margin-left: 52%;word-break: break-word;">
                        <h5 class="MuiTypography-root MuiTypography-h5 MuiTypography-colorTextPrimary" style="text-align: right; position: relative; margin-left: -60%;">$${pData.accounts[i].balance.toLocaleString()}.00</h5>
                        <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" style="text-align: right; margin-left: -50%; word-break: break-all;">Available Balance</p>
                    </div>
                </div>
                <div class="flex-row flex-space-between flex-vertical-center" style="width: 100%;">`
                    if (pData.is_atm === true) {
                        element += `
                        <div>
                            <button id="withdraw_button_${pData.accounts[i].id}" class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-containedSizeSmall MuiButton-sizeSmall" tabindex="0" type="button">
                                <span class="MuiButton-label">Withdraw</span>
                                <span class="MuiTouchRipple-root"></span>
                            </button>
                        </div>
                        `
                    } else {
                        element += `
                        <div>
                            <button id="deposit_button_${pData.accounts[i].id}" class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-containedSizeSmall MuiButton-sizeSmall" tabindex="0" type="button">
                                <span class="MuiButton-label">Deposit</span>
                                <span class="MuiTouchRipple-root"></span>
                            </button>
                        </div>
                        <div>
                            <button id="withdraw_button_${pData.accounts[i].id}" class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedSecondary MuiButton-containedSizeSmall MuiButton-sizeSmall" tabindex="0" type="button">
                                <span class="MuiButton-label">Withdraw</span>
                                <span class="MuiTouchRipple-root"></span>
                            </button>
                        </div>
                        `
                    }
                    element += `
                    <div>
                        <button id="transfer_button_${pData.accounts[i].id}" class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedSizeSmall MuiButton-sizeSmall" tabindex="0" type="button">
                            <span class="MuiButton-label">Transfer</span>
                            <span class="MuiTouchRipple-root"></span>
                        </button>
                    </div>
                </div>
            </div>`

            $("#accounts").append(element);

            // look for the smallest id in all accounts and set it as the current account
            if ((pData.accounts[i].id < currentAccount) || (currentAccount === undefined)) {
                // before setting the currenAccount remove jss1746 class from any other div
                // code is like $("#" + id).removeClass("jss1746");
                currentAccount = pData.accounts[i].id;
                setTimeout(() => {
                    getAccountTransactions(currentAccount);
                    console.log(currentAccount)
                }, 100);
            }

            $(`#deposit_button_${pData.accounts[i].id}`).click(function () {
                currentAction = "deposit";
                openSecondScreen("Deposit");
            });

            $(`#withdraw_button_${pData.accounts[i].id}`).click(function () {
                currentAction = "withdraw";
                openSecondScreen("Withdraw");
            });

            $(`#transfer_button_${pData.accounts[i].id}`).click(function () {
                currentAction = "transfer";
                openSecondScreen("Transfer");
            });

            if (pData.accounts[i].is_frozen) {
                $("#account_info_" + pData.accounts[i].id).html(`${pData.accounts[i].name} / ${pData.accounts[i].id} (FROZEN)`);
            };

            if (pData.accounts[i].access.includes("deposit") === false) {
                $(`#deposit_button_${pData.accounts[i].id}`).hide();
            }

            if (pData.accounts[i].access.includes("withdraw") === false) {
                $(`#withdraw_button_${pData.accounts[i].id}`).hide();
            }

            if (pData.accounts[i].access.includes("transfer") === false) {
                $(`#transfer_button_${pData.accounts[i].id}`).hide();
            }

            if (pData.accounts[i].access.includes("balance") === false) {
                $(`#account_balance_${pData.accounts[i].id}`).hide();
            }

            $(`#${pData.accounts[i].id}`).data("id", pData.accounts[i].id);
            $(`#${pData.accounts[i].id}`).data("name", pData.accounts[i].name);
            $(`#${pData.accounts[i].id}`).data("type", pData.accounts[i].type);

            $(`#${pData.accounts[i].id}`).click(function () {
                let id = $(this).data("id");
                let name = $(this).data("name");

                $("#account_number").html(`${name} / ${id}`);

                $("#" + currentAccount).removeClass("jss1476");
                currentAccount = id;
                $("#" + currentAccount).addClass("jss1476");

                getAccountTransactions(id);
            });
        }

        currentAccount = pData.accounts[0].id;
        $("#" + currentAccount).addClass("jss1476");

        $(".main_container_financials").css("display", "flex");
    }

    function openSecondScreen(pAction) {
        if (pAction == "Transfer") {
            $(".stateID_input").css("display", "block");
            $(".accountID_input").css("display", "block");
        }

        $("#action_text").html(pAction);
        $(".secondScreen").css("display", "flex");
    }

    function closeSecondScreen() {
        currentAction = null;
        $(".secondScreen").css("display", "none");
        $(".stateID_input").css("display", "none");
        $(".accountID_input").css("display", "none");
        $(".errorMessage").css("display", "none")
        $("#input_amount").val("");
        $("#input_comment").val("");
        $("#input_state_id").val("");
        $("#input_account_id").val("");
    }

    function getAccountTransactions(pAccountId, pAccountType) {
        $.post("https://np-financials/np-ui:getAccountTransactions", JSON.stringify({
            account_id: pAccountId,
            type: pAccountType,
        }),
        function(pData) {
            if (pData.meta.ok === false) return;

            $("#transactions").empty();

            for (var i = 0; i < pData.data.length; i++) {
                let direction = ""
                let color = "rgb(149, 239, 119)"

                if (pData.data[i].direction === "out") {
                    direction = "-"
                    color = "rgb(242, 163, 101)"
                }

                let element = `
                <div class="jss1479 jss1501">
                    <div class="flex-row flex-space-between">
                        <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" style="word-break: break-word;">${pData.data[i].from_account_name} / ${pData.data[i].from_account_id} [${pData.data[i].type.toUpperCase()}]</p>
                        <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" title="Transaction ID" style="word-break: break-word;">${pData.data[i].id}</p>
                    </div>
                    <hr>
                    <div style="display: flex; flex-direction: row; width: 100%; justify-content: space-between;">
                        <h5 class="MuiTypography-root MuiTypography-h5 MuiTypography-colorTextPrimary" style="width: 240px; color: ${color};">${direction}$${pData.data[i].amount.toLocaleString()}.00</h5>
                        <h6 class="MuiTypography-root MuiTypography-h6 MuiTypography-colorTextPrimary" style="flex: 1 1 0%;">${pData.data[i].from_civ_name}</h6>
                        <div style="max-width: 280px; text-align: right;">
                            <div title="" class="">
                                <h6 class="MuiTypography-root MuiTypography-h6 MuiTypography-colorTextPrimary">${moment.unix(pData.data[i].date).fromNow()}</h6>
                            </div>
                        </div>
                    </div>
                    <div style="display: flex; flex-direction: row; width: 100%; justify-content: space-between;">
                        <h6 class="MuiTypography-root MuiTypography-h6 MuiTypography-colorTextPrimary" style="flex: 1 1 0%; text-align: right;">${pData.data[i].to_civ_name}</h6>
                    </div>
                    <div style="margin-top: 16px;">
                        <div class="MuiFormControl-root MuiTextField-root" style="width: 100%;">
                            <label class="MuiFormLabel-root MuiInputLabel-root MuiInputLabel-formControl MuiInputLabel-animated MuiInputLabel-shrink Mui-disabled Mui-disabled MuiFormLabel-filled" data-shrink="true">Message</label>
                            <div class="MuiInputBase-root MuiInput-root MuiInput-underline Mui-disabled Mui-disabled MuiInputBase-formControl MuiInput-formControl">
                                <input aria-invalid="false" disabled="" type="text" class="MuiInputBase-input MuiInput-input Mui-disabled Mui-disabled" value="${pData.data[i].comment}">
                            </div>
                        </div>
                    </div>
                </div>`

                $("#transactions").append(element);
            };
        });
    }

    function getCash() {
        $.post(`https://np-financials/np-ui:getCash`, JSON.stringify({}), function(pCash) {
            $("#cash_amount").html(`Cash: $${pCash.toLocaleString()}.00`);
        })
    }

    $("#action_button").click(function () {
        let event = "";
        let data = {};

        switch (currentAction) {
            case "deposit":
                event = "np-ui:accountDeposit";
                data.account_id = currentAccount;
                data.amount = $("#input_amount").val();
                data.comment = $("#input_comment").val();
                break;
            case "withdraw":
                event = "np-ui:accountWithdraw";
                data.account_id = currentAccount;
                data.amount = $("#input_amount").val();
                data.comment = $("#input_comment").val();
                break;
            case "transfer":
                event = "np-ui:accountTransfer";
                data.account_id = currentAccount;
                data.target_account_id = parseInt($("#input_account_id").val());
                data.target_state_id = parseInt($("#input_state_id").val());
                data.amount = $("#input_amount").val();
                data.comment = $("#input_comment").val();
                break;
            default:
                break;
        }

        $.post(`https://np-financials/${event}`, JSON.stringify(data), function(pData) {
            if (pData.meta.ok === true) {
                getAccountTransactions(currentAccount);
                closeSecondScreen();
                loadAccounts();
            } else {
                showErrorMessage(pData.meta.message);
            }
        })
    });

    $("#cancel_button").click(closeSecondScreen);

    function showErrorMessage(pMessage) {
        $(".errorMessage").css("display", "block")
        $("#error_message").html(pMessage)
    }

    function humanized_time_span(date, ref_date, date_formats, time_units) {
        //Date Formats must be be ordered smallest -> largest and must end in a format with ceiling of null
        date_formats = date_formats || {
            past: [
                { ceiling: 60, text: "$seconds seconds ago" },
                { ceiling: 3600, text: "$minutes minutes ago" },
                { ceiling: 86400, text: "$hours hours ago" },
                { ceiling: 2629744, text: "$days days ago" },
                { ceiling: 31556926, text: "$months months ago" },
                { ceiling: null, text: "$years years ago" }
            ],
            future: [
                { ceiling: 60, text: "in $seconds seconds" },
                { ceiling: 3600, text: "in $minutes minutes" },
                { ceiling: 86400, text: "in $hours hours" },
                { ceiling: 2629744, text: "in $days days" },
                { ceiling: 31556926, text: "in $months months" },
                { ceiling: null, text: "in $years years" }
            ]
        };
        //Time units must be be ordered largest -> smallest
        time_units = time_units || [
            [31556926, "years"],
            [2629744, "months"],
            [86400, "days"],
            [3600, "hours"],
            [60, "minutes"],
            [1, "seconds"]
        ];

        date = new Date(date);
        ref_date = ref_date ? new Date(ref_date) : new Date();
        var seconds_difference = (ref_date - date) / 1000;

        var tense = "past";
        if (seconds_difference < 0) {
            tense = "future";
            seconds_difference = 0 - seconds_difference;
        }

        function get_format() {
            for (var i = 0; i < date_formats[tense].length; i++) {
                if (date_formats[tense][i].ceiling == null || seconds_difference <= date_formats[tense][i].ceiling) {
                    return date_formats[tense][i];
                }
            }
            return null;
        }

        function get_time_breakdown() {
            var seconds = seconds_difference;
            var breakdown = {};
            for (var i = 0; i < time_units.length; i++) {
                var occurences_of_unit = Math.floor(seconds / time_units[i][0]);
                seconds = seconds - (time_units[i][0] * occurences_of_unit);
                breakdown[time_units[i][1]] = occurences_of_unit;
            }
            return breakdown;
        }

        function render_date(date_format) {
            var breakdown = get_time_breakdown();
            var time_ago_text = date_format.text.replace(/\$(\w+)/g, function () {
                return breakdown[arguments[1]];
            });
            return depluralize_time_ago_text(time_ago_text, breakdown);
        }

        function depluralize_time_ago_text(time_ago_text, breakdown) {
            for (var i in breakdown) {
                if (breaaakdown[i] == 1) {
                    var regexp = new RegExp("\\b" + i + "\\b");
                    time_ago_text = time_ago_text.replace(regexp, function () {
                        return arguments[0].replace(/s\b/g, "");
                    });
                }
            }
            return time_ago_text;
        }

        return render_date(get_format());
    }

    openMainScreen({
        cash: 231,
        is_atm: false,
        accounts: [
            {
                id: 61942540,
                name: "Personal Account",
                type: "Default",
                owner_first_name: "James",
                owner_last_name: "Tylor",
                account_balance: 5000,
                access: ["deposit","withdraw","transfer","transactions","balance"],
            },
            {
                id: 619425401,
                name: "Personal Account1",
                type: "Default",
                owner_first_name: "James",
                owner_last_name: "Tylor",
                account_balance: 5000,
                access: [],
            }
        ],
    })

});

$(document).keydown(function (event) {
    if (event.which == "27") {
        $(".main_container_financials").css("display", "none");
        $("#transactions").empty();
        $.post('https://np-ui/np-ui:applicationClosed', JSON.stringify({
            name: "atm",
            fromEscape: true
        }));
    }
});