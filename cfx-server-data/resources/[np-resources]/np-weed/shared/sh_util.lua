function getStrainQuality(pStrain)
    local nFactor = pStrain.n * PlantConfig.NWeight
    local pFactor = pStrain.p * PlantConfig.PWeight
    local kFactor = pStrain.k * PlantConfig.KWeight
    local strainQuality = (nFactor + pFactor + kFactor) / (PlantConfig.NWeight + PlantConfig.PWeight + PlantConfig.KWeight)
    local waterFactor = 1.0 - math.abs((pStrain.water - PlantConfig.WaterOptimal))
    return tonumber(string.format("%.2f", 100.0 * strainQuality * waterFactor))
end

function getStrainNameFromQuality(pQuality)
    return StrainNames[math.floor((pQuality / 10) + 0.5) * 10]
end
