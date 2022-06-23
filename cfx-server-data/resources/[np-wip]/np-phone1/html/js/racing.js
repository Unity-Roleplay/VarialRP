var races = {};
var maps = {};

function addRaces(pRaces, pCanMakeMap) {
    $(".racing-entries").empty();
    races = pRaces;

    $(".racing-footer").empty();

    let element = `
    <div class="col s12">
        <button class="btn phone-button racing-button" data-action="racing:event:setup" aria-label="Setup a new race" data-balloon-pos="up">
            <i class="fas fa-flag-checkered icon"></i>
        </button>
        <button class="btn phone-button racing-button" data-action="racing:events:highscore" aria-label="Leaderboard" data-balloon-pos="up">
            <i class="fas fa-trophy icon"></i>
        </button>`
    if (pCanMakeMap == true) {
        element +=
        `<button class="btn phone-button racing-button" data-action="racing-create" aria-label="Create a new track" data-balloon-pos="up">
            <i class="fas fa-plus icon"></i>
        </button>`
    }
    `</div>`

    $(".racing-footer").append(element);

    for (let race in races) {
        let curRace = races[race];
        addRace(curRace, race);
    }
}

function addRace(race, raceId) {
    let stateColor = "green-text"
    if (race.state == "active") {
        stateColor = "blue-text"
    } else if (race.state == "close") {
        stateColor = "red-text"
    }

    let raceElement = `
    <li data-event-id="${raceId}">
        <div class="collapsible-header racing-entries-header row" style="margin-top: 1.5%; margin-bottom: 0%;">
            <div class="col s12">
                <div class="row no-padding">
                    <i class="fas fa-flag-checkered ${stateColor}" style="position: absolute; top: 5%; left: 7.5%; font-size: 2.0rem;"></i>
                    <div class="col s12">
                        <i class=""></i>${race.eventName}
                        <span class="new badge" style="background-color: transparent;" data-badge-caption="${race.laps > 0 ? ("Laps" + "(" + race.laps + ")") : "Sprint"}"></span>
                    </div>
                </div>
                <div class="row no-padding">
                    <div class="col s12">
                        <i class=""></i>${"$" + race.prize}
                        <span class="new badge" style="background-color: transparent;" data-badge-caption="m">${race.mapDistance}</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="collapsible-body racing-entries-body center-align row">
            <div class="col s12">
                <div class="row no-padding">
                    <div class="col s12">
                        <div class="chip black-text">
                            Creator: ${race.eventCreator}
                        </div>
                        <div class="chip black-text">
                            Price: ${"$" + race.buyIn}
                        </div>
                    </div>
                </div>
                <div class="row no-padding">
                    <div class="col s12">
            `

        let isRaceOwner = race.owner == playerId

        if (isRaceOwner && race.state != "close") {
            raceElement += `<button class="btn phone-button racing-button" data-action="racing:event:start" aria-label="Start Race" data-balloon-pos="up"><i class="fas fa-play icon"></i></button> `
            raceElement += `<button class="btn phone-button racing-button" data-action="racing:event:end" aria-label="End Race" data-balloon-pos="up"><i class="fas fa-stop icon"></i></button> `
        }

            raceElement += `<button class="btn racing-entries-preview racing-button" data-id="${race.id}" aria-label="Preview Race" data-balloon-pos="up"><i class="fas fa-eye icon"></i></button> `
            raceElement += `<button class="btn racing-entries-locate racing-button" data-id="${race.id}" aria-label="Locate Race" data-balloon-pos="up"><i class="fas fa-map-marker-alt icon"></i></button> `
            raceElement += `<button class="btn racing-entries-entrants racing-button" data-id="${raceId}" aria-label="Racers" data-balloon-pos="up"><i class="fas fa-users icon"></i></button> `

        let isInRace = inRace(raceId);

        if (isInRace == false && race.state == "open") {
            raceElement += `<button class="btn racing-entries-join racing-button" data-id="${race.id}" aria-label="Join Race" data-balloon-pos="up"><i class="fas fa-flag-checkered icon"></i></button> `
        } else if (isInRace == true && isRaceOwner == false && race.state != "close") {
            raceElement += `<button class="btn phone-button racing-button" data-action="racing:event:leave" aria-label="Leave Race" data-balloon-pos="up"><i class="fas fa-sign-out-alt icon"></i></button> `
        }
        raceElement +=
        `           </div>
                </div>
            </div>
        </div>
    </li>
    `
    $(".racing-entries").prepend(raceElement);
}

function inRace(raceId) {
    let currentRace = races[raceId]

    if(currentRace.players !== undefined) {
        currentRace.players = Object.values(currentRace.players).sort((a,b) => a.total - b.total);
    }

    for (let id in currentRace.players) {
        let racer = currentRace.players[id];
        if (racer.characterId == playerId) {
            return true
        }
    }

    return false
}

function addRacingTracks(tracks) {
    $("#racing-start-tracks").append(`<option value="" disabled selected>Escolha sua opção</option>`);
    for (let track in tracks) {
        $("#racing-start-tracks").append(`<option value="${track}">${tracks[track].name}</option>`)
    }
    $("select").formSelect();
}

$("#racing-start-tracks").on("change", function (e) {
    let selectedMap = $(this).val();
    if(maps[selectedMap] !== undefined) {
        $.post("https://np-phone/racing:map:load", JSON.stringify({ id: selectedMap}));
        $("#racing-start-map-creator").text(maps[selectedMap].creator);
        $("#racing-start-map-distance").text(maps[selectedMap].distance);

        if (maps[selectedMap].type == "Lap") {
            $("#racing-start-laps").val("");
            $("#racing-laps #racing-start-laps").prop("disabled", false)
        } else {
            $("#racing-start-laps").val(0);
            $("#racing-laps #racing-start-laps").prop("disabled", true)
        }
    }
});

$("#racing-start").submit(function (e) {
    e.preventDefault();

    $.post("https://np-phone/racing:event:start", JSON.stringify({
        id: $("#racing-start-tracks").val(),
        eventName: $("#racing-start-name").val(),
        laps: $("#racing-start-laps").val(),
        buyIn: $("#racing-start-amount").val(),
        countdown: $("#racing-start-time").val(),
        startTime: moment.utc().add($("#racing-start-time").val(), "seconds"),
        dnfPosition: $("#racing-start-dnf-position").val(),
        dnfCountdown: $("#racing-start-dnf-countdown").val(),
    }));
});

function addRacingHighScores(highScores) {
    $(".racing-highscore-entries").empty();

    for (let highScore in highScores) {
        let score = highScores[highScore]
        let highScoreElement = `
            <li style="margin-top: 1.5%;">
                <div class="collapsible-header racing-highscore-header row " style="margin-bottom: 0px;">
                    <div class="col s12">
                        <i class="fas fa-trophy"></i> ${score.name}
                        <span class="new badge" data-badge-caption="events" style="background-color: transparent;">${score.races}</span>
                    </div>
                </div>
                <div class="collapsible-body racing-highscore-body row">
                    <div class="col s12">
                        <br>
                        <div class="row no-padding">
                            <div class="col s3 right-align">
                                <i class="fas fa-stopwatch fa-2x icon" style="margin-top: 15%"></i>
                            </div>
                            <div class="col s9">
                                <strong>Fastest Time</strong>
                                <span data-badge-caption="" class="new badge" style="background-color: transparent;">${score.fastest_time === 0 ? "N/A" : moment(score.fastest_time).format("mm:ss.SSS")}</span>
                                <br>${score.fastest_name}
                            </div>
                        </div>
                        <br>
                        <div class="row no-padding">
                            <div class="col s3 right-align">
                                <i class="fas fa-route fa-2x icon" style="margin-top: 15%"></i>
                            </div>
                            <div class="col s9">
                                <strong>Distance</strong>
                                <br>${score.distance}m
                            </div>
                        </div>
                        <br>
                        <div class="row no-padding">
                            <div class="col s3 right-align">
                                <i class="fas fa-user fa-2x icon" style="margin-top: 15%"></i>
                            </div>
                            <div class="col s9">
                                <strong>Creator</strong>
                                <br>${score.creator}
                            </div>
                        </div>
                        <br>
                        <div class="col s12 center-align">
                            <button class="btn racing-highscore-entries-preview racing-button" data-id="${score.id}" aria-label="Preview Race" data-balloon-pos="up">
                                <i class="fas fa-eye icon"></i>
                            </button>
                            <button class="btn racing-highscore-entries-locate racing-button" data-id="${score.id}" aria-label="Locate Race" data-balloon-pos="up">
                                <i class="fas fa-map-marker-alt icon"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </li>
        `
        $(".racing-highscore-entries").prepend(highScoreElement);
    }

    openContainer("racing-highscore");
}

$(".racing-highscore-entries").on("click", ".racing-highscore-entries-preview", function () {
    $.post("https://np-phone/racing:event:preview", JSON.stringify({
        id: $(this).data("id")
    }));
});

$(".racing-highscore-entries").on("click", ".racing-highscore-entries-locate", function () {
    $.post("https://np-phone/racing:event:locate", JSON.stringify({
        id: $(this).data("id")
    }));
});

$("#racing-create-form").submit(function (e) {
    e.preventDefault();

    $.post("https://np-phone/racing:map:save", JSON.stringify({
        name: escapeHtml($("#racing-create-name").val()),
        type: $("#racing-create-type").val(),
    }));
});

$("#racing-create-form").on("reset", function (e) {
    e.preventDefault();

    $.post("https://np-phone/racing:map:cancel");
});


$("#racing-aliases-form").submit(function (e) {
    e.preventDefault();

    $.post("https://np-phone/racing:aliases:save", JSON.stringify({
        aliases: escapeHtml($("#racing-aliases-form #new-aliases-text").val()),
    }));

    $("#racing-aliases-form").trigger("reset");
    $("#racing-aliases-modal").modal("close");
});

$(".racing-entries").on("click", ".racing-entries-entrants", function () {
    $("#racing-entrants-modal").modal("open");
    $(".racing-entrants").empty();

    let currentRace = races[$(this).data("id")]

    if(currentRace.players !== undefined) {
        currentRace.players = Object.values(currentRace.players).sort((a,b) => a.total - b.total);
    }

    for (let id in currentRace.players) {
        let racer = currentRace.players[id];
        let racerElement = `
            <li>
                <div class="collapsible-header">${racer.name}</div>
                <div class="collapsible-body">
                    <div class="row">
                        <div class="col s3 right-align">
                            <i class="fab fa-slack-hash fa-2x icon"></i>
                        </div>
                        <div class="col s9">
                            <strong>Position</strong>
                            <br>${racer.position + "/" + currentRace.players.length}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s3 right-align">
                            <i class="fas fa-shipping-fast fa-2x icon "></i>
                        </div>
                        <div class="col s9">
                            <strong>Fastest Lap</strong>
                            <br>${moment(racer.fastest).format("mm:ss.SSS")}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s3 right-align">
                            <i class="fas fa-stopwatch fa-2x icon"></i>
                        </div>
                        <div class="col s9">
                            <strong>Total</strong>
                            <br>${moment(racer.total).format("mm:ss.SSS")}
                        </div>
                    </div>
                </div>
            </li>
        `
        $(".racing-entrants").append(racerElement);
    }
});

$(".racing-entries").on("click", ".racing-entries-preview", function () {
    $.post("https://np-phone/racing:event:preview", JSON.stringify({
        id: $(this).data("id")
    }));
});

$(".racing-entries").on("click", ".racing-entries-locate", function () {
    $.post("https://np-phone/racing:event:locate", JSON.stringify({
        id: $(this).data("id")
    }));
});

$(".racing-entries").on("click", ".racing-entries-join", function () {
    $.post("https://np-phone/racing:event:join", JSON.stringify({
        id: $(this).data("id")
    }));
});