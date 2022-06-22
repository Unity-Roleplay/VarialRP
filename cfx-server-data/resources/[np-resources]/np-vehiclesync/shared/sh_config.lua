Flags = {
    SyncFlags = {
        ['neonLights'] = 1,
        ['engineSound'] = 2,
        ['leftIndicator'] = 4,
        ['rightIndicator'] = 8,
        ['hazardIndicator'] = 16
    },
    SirenFlags = {
        ['sirenActive'] = 1,
        ['sirenMuted'] = 2,
        ['sirenAirhorn'] = 4,
        ['sirenNormal'] = 8,
        ['sirenAltern'] = 16,
        ['sirenWarning'] = 32,
    }
}

SirenPresets = {
    [1] = { -- STANDARD
        sirenAirhorn = "SIRENS_AIRHORN",
        sirenNormal = "VEHICLES_HORNS_SIREN_1",
        sirenAltern = "VEHICLES_HORNS_SIREN_2",
        sirenWarning = "VEHICLES_HORNS_POLICE_WARNING"
    },
    [2] = { -- EMERGENCY
        sirenAirhorn = "SIRENS_AIRHORN",
        sirenNormal = "VEHICLES_HORNS_SIREN_1",
        sirenAltern = "VEHICLES_HORNS_SIREN_2",
        sirenWarning = "VEHICLES_HORNS_AMBULANCE_WARNING"
    },
    [3] = { -- FIRETRUCK
        sirenAirhorn = "VEHICLES_HORNS_FIRETRUCK_WARNING",
        sirenNormal = "VEHICLES_HORNS_SIREN_1",
        sirenAltern = "VEHICLES_HORNS_SIREN_2",
        sirenWarning = "VEHICLES_HORNS_AMBULANCE_WARNING"
    }
}

ModelPreset = {
    [`FIRETRUK`] = 3,
    [`AMBULANCE`] = 2,
    [`LGUARD`] = 2,
    [`policebul`] = 2,
}