var currentSettings = [];
var currentSettingWindow = "voip";

var checkedFunctions = ["stereoAudio","localClickOn","localClickOff","remoteClickOn","remoteClickOff"];
var sliderFunctions = ["clickVolume","radioVolume", "phoneVolume"];

function addSettings(settings) {
    $('#controlSettings').empty();

    if (settings.currentSettings !== undefined) {
        currentSettings = settings.currentSettings;
    }

    $('.tabs').tabs();
    openContainer("settings");

    setSettings();
}

function delay() {
    return new Promise(resolve => setTimeout(resolve, 30));
}

async function delayedLog() {
    await delay();
}

function updateOnID(settingID,varData) {
    for (i in currentSettings) {
        if(i == settingID) {
            currentSettings[i] = varData
        }
    }
}

async function updateVoipSettings() {
    for (j in checkedFunctions) {
        var name = checkedFunctions[j]
        var varData = $('#'+name).prop('checked');
        updateOnID(name,varData);
        await delayedLog(name);
    }

    for (j in sliderFunctions) {
        var name = sliderFunctions[j]
        var varData = $('#'+name).val();

        updateOnID(name, varData / 10);
        await delayedLog(name);
    }

    await delayedLog();

    $.post('https://np-phone/settingsUpdate', JSON.stringify({
        type: "voip",
        settings: currentSettings,
    }));

}

function findTypeOf(settingID) {
    var type = 0

    for (j in checkedFunctions) {
        if(settingID == checkedFunctions[j]) {
            type = 1
        }
    }

    if(type == 0) {
        for (j in sliderFunctions) {
            if(settingID == sliderFunctions[j]) {
                type = 2
            }
        }
    }

    return type
}

function setSettings() {
    for (i in currentSettings) {
        var name = i
        var outcome = currentSettings[i]

        if (findTypeOf(name) == 1) {
            $('#'+name).prop('checked', outcome);
        } else if(findTypeOf(name) == 2) {
            $('#' + name).val(outcome * 10);
        }
    }
}

function updateSettings() {
    switch (currentSettingWindow) {
        case "voip":
            updateVoipSettings();
            break;
        default:
            console.log("Error: incorrect active tab found")
            break;
    }

}

function ResetSettings() {
    switch (currentSettingWindow) {
        case "voip":
            $.post('https://np-phone/settingsResetVoip', JSON.stringify());
            break;
        default:
            console.log("Error: incorrect active tab found : reset")
            break;
    }
    openContainer(oldContainerHistory.pop(), null, currentContainer);
}

$('.settings-submit').click(function (e) {
    updateSettings();
});

$('.settings-reset').click(function (e) {
    ResetSettings();
});