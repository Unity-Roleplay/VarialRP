function addGroups(groups) {
    $(".groups-entries").empty();

    for (let group in groups) {
        let groupElement = `
            <li class="collection-item" style="margin-top: 1.5%;">
                <span style="font-weight:bold">${groups[group].namesent}</span>
                <a href="#!" class="secondary-content">
                    <span class="phone-button groups-button" style="position: absolute; margin-top: 2.5%; right: 5%;" data-action="group-manage" data-action-data="${groups[group].idsent}" aria-label="Manage" data-balloon-pos="left">
                        <i class="fas fa-briefcase fa-2x"></i>
                    </span>
                </a>
                <br>
                <span style="font-weight:300">${groups[group].ranksent}</span>
            </li>
        `

        $(".groups-entries").append(groupElement);
    }

    openContainer("groups");
}

function addGroupManage(group) {
    $(".group-manage-entries").empty();
    $(".group-manage-footer").empty();

    $(".group-manage-company-name").text(group.groupName).data("group-id", group.groupId);

    for (let i = 0; i < group.employees.length; i++) {
        let employee = group.employees[i];

        let employeeEntry = `
        <li>
            <div class="row no-padding">
                <div class="col s12">
                    <div class="card group-manage-card">
                        <div class="card-content group-manage-entry-content">
                            <div class="row no-padding">
                                <div class="col s12">
                                    <span class="card-title group-manage-entry-title">${employee.name} [${employee.cid}]</span>
                                    <span class="group-manage-entry-body">Promovido para ${employee.rankname} por ${employee.giver}</span>
                                </div>
                            </div>
                            <div class="row no-padding" style="padding-top:10px !important">
                                <div class="col s12 center-align">`
                                if (group.rank.hire) {
                                    employeeEntry += `
                                    <button class="groups-button btn-small group-manage-rank" data-id="${employee.cid}" data-group="${group.groupId}" aria-label="Promover" data-balloon-pos="up">
                                        <i class="fas fa-handshake" style="font-size: 1.5rem"></i>
                                    </button>`

                                    if (group.isEmergency) {
                                        employeeEntry += `
                                        <button class="groups-button btn-small group-manage-callsign" data-id="${employee.cid}" data-group="${group.groupId}" aria-label="Mudar Callsign" data-balloon-pos="up">
                                            <i class="fas fa-tag" style="font-size: 1.5rem"></i>
                                        </button>`
                                    }
                                }
                                employeeEntry += `</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </li>
        `
        $(".group-manage-entries").append(employeeEntry);
    }

    let buttonsEntry = `
    <div class="col s12">
    `
        if (group.rank.hire) {
            buttonsEntry += `
            <button class="btn groups-button group-manage-rank" aria-label="Promover" data-balloon-pos="up">
                <i class="fas fa-handshake" style="font-size: 1.5rem"></i>
            </button>`
        }
        if (group.rank.logs) {
            buttonsEntry += `
            <button class="btn groups-button group-manage-logs" aria-label="Logs" data-balloon-pos="up">
                <i class="fas fa-clipboard-list" style="font-size: 1.5rem"></i>
            </button>`
        }
        if (["pdm"].includes(group.groupId)) {
            buttonsEntry += `
            <button class="btn groups-button group-manage-carshopoutstanding" aria-label="Outstanding Payments" data-balloon-pos="up">
                <i class="fas fa-file-invoice-dollar" style="font-size: 1.5rem"></i>
            </button>`
        }
    buttonsEntry += `
    </div>
    `
    $(".group-manage-footer").append(buttonsEntry);

    openContainer("group-manage");
}

$(".group-manage-entries, .group-manage-footer").on("click", ".group-manage-rank", async function () {
    let ranks;

    await fetch(`https://${GetParentResourceName()}/groupRanks`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify({
            group: escapeHtml($(".group-manage-company-name").data("group-id")),
        })
    }).then(resp => resp.json()).then(resp => ranks = resp);

    $("#group-manage-rank-modal").modal("open");
    $("#group-manage-rank-form").trigger("reset");
    $("#group-manage-rank-modal #group-manage-rank-id").prop("disabled", false);

    if ($(this).data("id")) {
        $("#group-manage-rank-modal #group-manage-rank-id").val($(this).data("id")).prop("disabled", true);
    }

    $("#group-manage-rank-modal #group-manage-rank").empty();
    $("#group-manage-rank-modal #group-manage-rank").append(`<option value="" disabled selected>Select the rank</option>`);
    $("#group-manage-rank-modal #group-manage-rank").append(`<option value="${0}">Remove</option>`);

    for (let i = 0; i < ranks.length; i++) {
        let rank = ranks[i];

        $("#group-manage-rank-modal #group-manage-rank").append(`<option value="${rank.rank}">${rank.name}</option>`);
    }

    $("select").formSelect();

    M.updateTextFields();
});

$("#group-manage-rank-form").submit(function (e) {
    e.preventDefault();
    $.post("https://np-phone/promoteGroup", JSON.stringify({
        gangid: escapeHtml($(".group-manage-company-name").data("group-id")),
        cid: escapeHtml($("#group-manage-rank-form #group-manage-rank-id").val()),
        newrank: escapeHtml($("#group-manage-rank-form #group-manage-rank").val())
    }));
    $("#group-manage-rank-form").trigger("reset");
    $("#group-manage-rank-modal").modal("close");
});

$(".group-manage-footer").on("click", ".group-manage-logs", function () {
    $.post("https://np-phone/groupLogs", JSON.stringify({
        group: escapeHtml($(".group-manage-company-name").data("group-id")),
    }));
});

$(".group-manage-footer").on("click", ".group-manage-carshopoutstanding", function () {
    $.post("https://np-phone/carshopOutstandings", JSON.stringify({
        group: escapeHtml($(".group-manage-company-name").data("group-id")),
    }));
});

function ManageFilter() {
    var filter = $("#group-manage-search").val();
    $("ul.group-manage-entries li").each(function () {
        if ($(this).find(".group-manage-entry-title").text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            $(this).show()
        }
    });
}

$("#group-manage-search").keyup(debounce(function () {
    ManageFilter();
}, 500));

$(".group-manage-entries").on("click", ".group-manage-callsign", function () {
    $("#group-manage-callsign-modal").modal("open");
    $("#group-manage-callsign-form").trigger("reset");
    $("#group-manage-callsign-modal #group-manage-callsign-id").val($(this).data("id")).prop("disabled", true);
    $("#group-manage-callsign-modal #group-manage-callsign").empty();

    M.updateTextFields();
});

$("#group-manage-callsign-form").submit(function (e) {
    e.preventDefault();
    $.post("https://np-phone/changeCallsign", JSON.stringify({
        gangid: escapeHtml($(".group-manage-company-name").data("group-id")),
        cid: escapeHtml($("#group-manage-callsign-form #group-manage-callsign-id").val()),
        callsign: escapeHtml($("#group-manage-callsign-form #group-manage-callsign").val())
    }));
    $("#group-manage-callsign-form").trigger("reset");
    $("#group-manage-callsign-modal").modal("close");
});