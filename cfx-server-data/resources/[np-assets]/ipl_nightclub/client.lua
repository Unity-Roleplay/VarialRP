--===============================
-- by JUST INTERIOR STUDIO
-- Discord UncleJust#0001
--===============================

local int_id = GetInteriorAtCoords(345.4899597168,294.95315551758,98.191421508789)

--==============================================================
--НАСТРОЙКИ НАХОДЯТ В САМОМ НИЗУ СКРИПТА / SETTINGS ARE LOWEST SCRIPT
--==============================================================

--============================ НЕ ТРОГАТЬ / DO NOT TOUCH ==================================
-- upgrade
EnableInteriorProp(int_id , "Int01_ba_security_upgrade")
EnableInteriorProp(int_id , "Int01_ba_equipment_setup")
DisableInteriorProp(int_id , "Int01_ba_Style01") -- дешовый
DisableInteriorProp(int_id , "Int01_ba_Style02") -- средний
EnableInteriorProp(int_id , "Int01_ba_Style03") -- дорогой
DisableInteriorProp(int_id , "Int01_ba_style01_podium") -- дешовый
DisableInteriorProp(int_id , "Int01_ba_style02_podium") -- средний
EnableInteriorProp(int_id , "Int01_ba_style03_podium") -- дорогой
EnableInteriorProp(int_id , "int01_ba_lights_screen")
EnableInteriorProp(int_id , "Int01_ba_Screen")
EnableInteriorProp(int_id , "Int01_ba_bar_content")
DisableInteriorProp(int_id , "Int01_ba_booze_01") --мусор после вечеринки
DisableInteriorProp(int_id , "Int01_ba_booze_02") --мусор после вечеринки
DisableInteriorProp(int_id , "Int01_ba_booze_03") --мусор после вечеринки
DisableInteriorProp(int_id , "Int01_ba_dj01")
DisableInteriorProp(int_id , "Int01_ba_dj02")
EnableInteriorProp(int_id , "Int01_ba_dj03")
DisableInteriorProp(int_id , "Int01_ba_dj04")

EnableInteriorProp(int_id , "DJ_01_Lights_01")
DisableInteriorProp(int_id , "DJ_01_Lights_02")
DisableInteriorProp(int_id , "DJ_01_Lights_03")
DisableInteriorProp(int_id , "DJ_01_Lights_04")

DisableInteriorProp(int_id , "DJ_02_Lights_01")
EnableInteriorProp(int_id , "DJ_02_Lights_02")
DisableInteriorProp(int_id , "DJ_02_Lights_03")
DisableInteriorProp(int_id , "DJ_02_Lights_04")

DisableInteriorProp(int_id , "DJ_03_Lights_01")
DisableInteriorProp(int_id , "DJ_03_Lights_02")
EnableInteriorProp(int_id , "DJ_03_Lights_03")
DisableInteriorProp(int_id , "DJ_03_Lights_04")

DisableInteriorProp(int_id , "DJ_04_Lights_01")
DisableInteriorProp(int_id , "DJ_04_Lights_02")
DisableInteriorProp(int_id , "DJ_04_Lights_03")
EnableInteriorProp(int_id , "DJ_04_Lights_04")

DisableInteriorProp(int_id , "light_rigs_off")
EnableInteriorProp(int_id , "Int01_ba_lightgrid_01")
DisableInteriorProp(int_id , "Int01_ba_Clutter")
EnableInteriorProp(int_id , "Int01_ba_equipment_upgrade")
EnableInteriorProp(int_id , "Int01_ba_clubname_01") -- galaxy
DisableInteriorProp(int_id , "Int01_ba_clubname_02") --studio
DisableInteriorProp(int_id , "Int01_ba_clubname_03") --omega
DisableInteriorProp(int_id , "Int01_ba_clubname_04") --tehnology
DisableInteriorProp(int_id , "Int01_ba_clubname_05") --gefangnis
DisableInteriorProp(int_id , "Int01_ba_clubname_06") --maisonnette
DisableInteriorProp(int_id , "Int01_ba_clubname_07") -- tony 
DisableInteriorProp(int_id , "Int01_ba_clubname_08") -- the palace
DisableInteriorProp(int_id , "Int01_ba_clubname_09") -- paradise

EnableInteriorProp(int_id , "Int01_ba_dry_ice")
DisableInteriorProp(int_id , "Int01_ba_deliverytruck")
DisableInteriorProp(int_id , "Int01_ba_trophy04")
DisableInteriorProp(int_id , "Int01_ba_trophy05")
DisableInteriorProp(int_id , "Int01_ba_trophy07")
DisableInteriorProp(int_id , "Int01_ba_trophy09")
DisableInteriorProp(int_id , "Int01_ba_trophy08")
DisableInteriorProp(int_id , "Int01_ba_trophy11")
DisableInteriorProp(int_id , "Int01_ba_trophy10")
DisableInteriorProp(int_id , "Int01_ba_trophy03")
DisableInteriorProp(int_id , "Int01_ba_trophy01")
DisableInteriorProp(int_id , "Int01_ba_trophy02")
DisableInteriorProp(int_id , "Int01_ba_trad_lights")
DisableInteriorProp(int_id , "Int01_ba_Worklamps") -- работа
RefreshInterior(int_id )
