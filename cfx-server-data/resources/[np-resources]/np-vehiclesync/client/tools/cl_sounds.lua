TrackedSounds = {}

function CreateEntitySound(pEntity, pSoundName)
    if not TrackedSounds[pEntity] then TrackedSounds[pEntity] = {} end

    local sounds = TrackedSounds[pEntity]

    if sounds[pSoundName] then return end

    local soundId = GetSoundId()

    sounds[pSoundName] = soundId

    PlaySoundFromEntity(soundId, pSoundName, pEntity, 0, 0, 0)
end

function DeleteEntitySound(pEntity, pSoundName)
    local sounds = TrackedSounds[pEntity]

    if not sounds or not sounds[pSoundName] then return end

    local soundId = sounds[pSoundName]

    sounds[pSoundName] = nil

    StopSound(soundId)
    ReleaseSoundId(soundId)
end

function CleanUpEntitySounds(pEntity)
    if not TrackedSounds[pEntity] then return end

    local sounds = TrackedSounds[pEntity]

    for _, soundId in pairs(sounds) do
        if soundId then
            StopSound(soundId)
            ReleaseSoundId(soundId)
        end
    end

    TrackedSounds[pEntity] = nil
end

function FeedbackSound(pActive)
    local sound = pActive and "NAV_LEFT_RIGHT" or "NAV_UP_DOWN"
    PlaySoundFrontend(-1, sound, "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end