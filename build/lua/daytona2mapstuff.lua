//This code is for all the map related stuff in Daytona Racers

local DTRBASETIME = 180
local DTRBASEBONUS = 60

rawset(_G, "setmaps", {}) //Used to check if a map has times for them set

rawset(_G, "DTRTimes", setmetatable({
	["RR_TESTRUN"] = {300, 0},
	["RR_PODIUM"] = {-1, 0},
	["RR_TITLE"] = {-1, 0},
	["RR_SUNBEAMPARADISECONTROLS"] = {-1, 0},
	["RR_SUNBEAMPARADISERINGS"] = {-1, 0},
	["RR_SUNBEAMPARADISEBRAKES"] = {-1, 0},
	["RR_SUNBEAMPARADISEDRIFTING"] = {-1, 0},
	["RR_SUNBEAMPARADISESPRINGS"] = {-1, 0},
	["RR_LASVEGAS"] = {95, 35},
	["RR_DAYTONASPEEDWAY"] = {80, 35}, 
	["RR_PICOPARK"] = {70, 10},
	//...
}, {__index = function() return {DTRBASETIME, DTRBASEBONUS} end}))

rawset(_G, "DTRMedals", setmetatable({
	["RR_TESTRUN"] = {1, 2, 3, 4},
["RR_TESTTRACK"] = {3578, 4025, 4445, 4900},
["RR_STORMRIG"] = {3717, 4095, 4515, 4970},
["RR_MEGABRIDGE"] = {3194, 3570, 3955, 4375},
["RR_MEGALAVAREEF"] = {3596, 3990, 4410, 4865},
["RR_MEGAICECAP"] = {4167, 4585, 5075, 5600},
["RR_MEGASCRAPBRAIN"] = {3944, 4340, 4795, 5285},
["RR_CLOUDTOPDIMENSION"] = {3509, 3885, 4305, 4760},
["RR_NIGHTFALLDIMENSION"] = {4225, 4655, 5145, 5670},
["RR_WAVECRASHDIMENSION"] = {4198, 4900, 5390, 5950},
["RR_VOIDDANCEDIMENSION"] = {3380, 3745, 4130, 4550},
["RR_GRAVTECHDIMENSION"] = {4175, 4620, 5110, 5635},
["RR_ESPRESSOLANE"] = {3878, 4305, 4760, 5250},
["RR_LUCIDPASS"] = {2558, 3185, 3535, 3920},
["RR_MELTYMANOR"] = {3409, 3920, 4340, 4795},
["RR_LEAFSTORM"] = {3719, 4095, 4515, 4970},
["RR_LAKEMARGORITE"] = {3968, 4375, 4830, 5320},
["RR_ENDLESSMINE2"] = {4042, 4550, 5005, 5530},
["RR_CYANBELLTOWER"] = {3325, 3675, 4060, 4480},
["RR_QUARTZQUADRANT"] = {3997, 4410, 4865, 5355},
["RR_AQUATUNNEL"] = {3976, 4970, 5495, 6055},
["RR_WATERPALACE"] = {4577, 5040, 5565, 6125},
["RR_FINALFALL"] = {3719, 4095, 4515, 4970},
["RR_HAUNTEDSHIP"] = {4447, 4900, 5390, 5950},
["RR_AUTUMNRING"] = {4769, 5250, 5775, 6370},
["RR_ROBOTNIKWINTER"] = {4596, 5075, 5600, 6160},
["RR_DRAGONSPIRESEWER1"] = {3184, 3535, 3920, 4340},
["RR_ABYSSGARDEN"] = {3789, 4375, 4830, 5320},
["RR_BLIZZARDPEAKS"] = {4693, 5180, 5705, 6300},
["RR_VERMILIONVESSEL"] = {4414, 4865, 5355, 5915},
["RR_DRAGONSPIRESEWER2"] = {3457, 3815, 4200, 4620},
["RR_CHEMICALFACILITY"] = {4416, 4865, 5355, 5915},
["RR_COASTALTEMPLE"] = {3264, 3605, 3990, 4410},
["RR_MONKEYMALL"] = {2805, 3115, 3430, 3780},
["RR_RAMPPARK"] = {4688, 5180, 5705, 6300},
["RR_WITHERINGCHATEAU"] = {3710, 4165, 4585, 5075},
["RR_ADVENTANGEL"] = {3426, 4655, 5145, 5670},
["RR_PESTILENCE"] = {4206, 4795, 5285, 5845},
["RR_CRIMSONCORE"] = {4992, 5495, 6055, 6685},
["RR_LASVEGAS"] = {3666, 4060, 4480, 4935},
["RR_MEGACOLLISIONCHAOS"] = {3664, 4060, 4480, 4935},
["RR_MEGASTARLIGHT"] = {3057, 3395, 3745, 4130},
["RR_MEGASANDOPOLIS"] = {1958, 2940, 3255, 3605},
["RR_MEGAAQUALAKE"] = {3060, 3780, 4165, 4585},
["RR_MEGAFLYINGBATTERY"] = {3723, 4130, 4550, 5005},
["RR_SKYBABYLON"] = {4137, 4585, 5075, 5600},
["RR_POPCORNWORKSHOP"] = {3756, 4375, 4830, 5320},
["RR_KODACHROMEVOID"] = {3978, 4410, 4865, 5355},
["RR_LAVENDERSHRINE"] = {4194, 5215, 5740, 6335},
["RR_THUNDERPISTON"] = {4110, 5285, 5845, 6440},
["RR_DEADLINE"] = {3591, 4165, 4585, 5075},
["RR_SRB2FROZENNIGHT"] = {3684, 4410, 4865, 5355},
["RR_BARRENBADLANDS"] = {3396, 3780, 4165, 4585},
["RR_SHUFFLESQUARE"] = {4070, 4830, 5320, 5880},
["RR_BLUEMOUNTAINCLASSIC"] = {3399, 3780, 4165, 4585},
["RR_ANGELARROWCLASSIC"] = {3603, 4270, 4725, 5215},
["RR_CADILLACCANYONCLASSIC"] = {3096, 3570, 3955, 4375},
["RR_SUNDAEDRIVE"] = {3009, 3360, 3710, 4095},
["RR_DIAMONDDUSTCLASSIC"] = {3205, 4060, 4480, 4935},
["RR_BLIZZARDPEAKSCLASSIC"] = {3817, 4200, 4620, 5110},
["RR_LAUNCHBASECLASSIC"] = {3418, 3780, 4165, 4585},
["RR_LAVENDERSHRINECLASSIC"] = {3411, 3780, 4165, 4585},
["RR_MUNICIPALMEADOW"] = {492, 560, 630, 700},
["RR_CDSPECIALSTAGE1"] = {355, 490, 560, 630},
["RR_TINKERERSARENA"] = {855, 1155, 1295, 1435},
["RR_TRICIRCLEMARINA"] = {474, 595, 665, 735},
["RR_MYSTERYGATE"] = {502, 875, 980, 1085},
["RR_RUSTYRIG"] = {870, 980, 1085, 1225},
["RR_CADILLACCASCADE"] = {4337, 4795, 5285, 5845},
["RR_MARBLEFOYER"] = {698, 805, 910, 1015},
["RR_ROCKWORLD"] = {704, 840, 945, 1050},
["RR_WORLD1MAP"] = {363, 840, 945, 1050},
["RR_CDSPECIALSTAGE8"] = {945, 1785, 1995, 2205},
["RR_SEGASATURN"] = {367, 665, 735, 840},
["RR_ELECTRACLACKER"] = {673, 805, 910, 1015},
["RR_THUNDERTOP"] = {580, 910, 1015, 1120},
["RR_TREERING"] = {841, 1540, 1715, 1890},
["RR_FRIGIDCOVE"] = {2824, 3115, 3430, 3780},
["RR_GIZMOBASTION"] = {815, 1015, 1120, 1260},
["RR_OPULENCE"] = {4337, 4795, 5285, 5845},
["RR_CARBONCRUCIBLE"] = {551, 700, 770, 875},
["RR_SECURITYHALL"] = {1229, 1680, 1855, 2065},
["RR_GEMSMUSEUM"] = {528, 910, 1015, 1120},
["RR_MEDIASTUDIO"] = {1429, 2135, 2380, 2625},
["RR_HONEYCOMBHOLLOW"] = {984, 1155, 1295, 1435},
["RR_WOOD"] = {1199, 2030, 2240, 2485},
["RR_BRAWLFORT"] = {633, 980, 1085, 1225},
["RR_CRYSTALISLAND"] = {729, 1120, 1260, 1400},
["RR_CYBERARENA"] = {800, 1260, 1400, 1540},
["RR_NEONRESORT"] = {1406, 2450, 2695, 2975},
["RR_RUMBLERIDGE"] = {3775, 4235, 4690, 5180},
["RR_METEORHERD"] = {1323, 1890, 2100, 2310},
["RR_DEATHEGGSEYE"] = {974, 2100, 2310, 2555},
["RR_TAILSLAB"] = {334, 455, 525, 595},
["RR_POWERPLANT"] = {1425, 2100, 2310, 2555},
["RR_CITYSKYLINE"] = {1684, 1855, 2065, 2275},
["RR_VANTABLACKATRIUM"] = {441, 910, 1015, 1120},
["RR_DEADSIMPLE"] = {420, 1015, 1120, 1260},
["RR_MARTIANMATRIX"] = {409, 1120, 1260, 1400},
["RR_DARKCHAOGARDEN"] = {760, 1050, 1155, 1295},
["RR_HEROCHAOGARDEN"] = {1133, 1750, 1925, 2135},
["RR_ANGELISLAND"] = {4328, 5005, 5530, 6090},
["RR_WHIRLWATERS"] = {958, 1190, 1330, 1470},
["RR_DELUGEDMETROPLEX"] = {1010, 1505, 1680, 1855},
["RR_MEGAEMERALDBEACH"] = {552, 770, 875, 980},
["RR_MEGALABYRINTH"] = {773, 1330, 1470, 1645},
["RR_FUNGALDIMENSION"] = {1714, 2275, 2520, 2800},
["RR_ASTRALDIMENSION"] = {1864, 3010, 3325, 3675},
["RR_CHAOSSERAPH"] = {1452, 1925, 2135, 2380},
["RR_TOYKINGDOM"] = {1133, 2275, 2520, 2800},
["RR_AQUATICCATHEDRAL1"] = {677, 2030, 2240, 2485},
["RR_AQUATICCATHEDRAL2"] = {884, 1680, 1855, 2065},
["RR_PODIUM"] = {1, 2, 3, 4},
["RR_ROASTEDRUINS"] = {3340, 3675, 4060, 4480},
["RR_FROSTYCOURTYARD"] = {1330, 1610, 1785, 1995},
["RR_ABYSSGATE"] = {2070, 2695, 2975, 3290},
["RR_SONICSSCHOOLHOUSE"] = {1182, 1785, 1995, 2205},
["RR_RECORDATTACK"] = {875, 1540, 1715, 1890},
["RR_PEANUTPALACE"] = {630, 805, 910, 1015},
["RR_HYDROPLANT"] = {2773, 3255, 3605, 3990},
["RR_MEGAMETROPOLIS"] = {534, 630, 700, 770},
["RR_MEGAMARBLE"] = {437, 980, 1085, 1225},
["RR_THUNDERLAB"] = {841, 945, 1050, 1155},
["RR_MALIGNEGGSHRINE"] = {664, 1540, 1715, 1890},
["RR_OBSIDIANOASIS"] = {3507, 3885, 4305, 4760},
["RR_SRB2MEADOWMATCH"] = {762, 980, 1085, 1225},
["RR_ARMOREDARMADILLO"] = {1277, 1505, 1680, 1855},
["RR_CLUCKYFARMS"] = {690, 770, 875, 980},
["RR_DRIEDBATTLEDUNE"] = {1353, 1855, 2065, 2275},
["RR_SEALEDSTARBALCONIES"] = {1, 2, 3, 4},
["RR_SEALEDSTARCHURCH"] = {1, 2, 3, 4},
["RR_SEALEDSTARCOURTYARD"] = {1, 2, 3, 4},
["RR_SEALEDSTARVILLA"] = {1, 2, 3, 4},
["RR_SEALEDSTARVENICE"] = {1, 2, 3, 4},
["RR_SEALEDSTARSPIKES"] = {1, 2, 3, 4},
["RR_MIRAGESALOON"] = {4114, 4550, 5005, 5530},
["RR_SEALEDSTARFOUNTAIN"] = {1, 2, 3, 4},
["RR_SEALEDSTARGALLERY"] = {1, 2, 3, 4},
["RR_SEALEDSTARALLEY"] = {1, 2, 3, 4},
["RR_SEALEDSTARSTEEPLE"] = {1, 2, 3, 4},
["RR_SEALEDSTARROOFTOPS"] = {1, 2, 3, 4},
["RR_SEALEDSTARROULETTE"] = {1, 2, 3, 4},
["RR_SEALEDSTARTOWERS"] = {1, 2, 3, 4},
["RR_SEALEDSTARATLANTIS"] = {1, 2, 3, 4},
["RR_ADVENTUREEXAMPLE"] = {1, 2, 3, 4},
["RR_SUNBEAMPARADISECONTROLS"] = {1, 2, 3, 4},
["RR_REGALRUIN"] = {3012, 3570, 3955, 4375},
["RR_SUNBEAMPARADISERINGS"] = {1, 2, 3, 4},
["RR_SUNBEAMPARADISEBRAKES"] = {1, 2, 3, 4},
["RR_SUNBEAMPARADISEDRIFTING"] = {1, 2, 3, 4},
["RR_SUNBEAMPARADISESPRINGS"] = {1, 2, 3, 4},
["RR_ISOLATEDISLAND"] = {3923, 4480, 4935, 5460},
["RR_GIGAPOLIS"] = {3108, 3465, 3815, 4200},
["RR_DARKVILECASTLE1"] = {3385, 3745, 4130, 4550},
["RR_BRONZELAKE"] = {4487, 4970, 5495, 6055},
["RR_COLLISIONCHAOS"] = {5112, 5635, 6230, 6860},
["RR_EMERALDHILL"] = {3944, 4340, 4795, 5285},
["RR_TITLE"] = {1, 2, 3, 4},
["RR_AZURECITY"] = {2164, 3640, 4025, 4445},
["RR_GUSTPLANET"] = {3809, 4655, 5145, 5670},
["RR_MYSTICCAVE"] = {3307, 3640, 4025, 4445},
["RR_JOYPOLIS"] = {2762, 3150, 3465, 3815},
["RR_HIDDENPALACE"] = {5400, 5950, 6545, 7210},
["RR_HILLTOP"] = {4114, 4760, 5250, 5775},
["RR_MARBLEGARDEN"] = {5464, 6405, 7070, 7805},
["RR_SILVERCLOUDISLAND"] = {3704, 4130, 4550, 5005},
["RR_SUBZEROPEAK"] = {4353, 4935, 5460, 6020},
["RR_LAUNCHBASE"] = {5676, 6265, 6895, 7595},
["RR_ROBOTNIKCOASTER"] = {2529, 2940, 3255, 3605},
["RR_AZURELAKE"] = {2925, 3255, 3605, 3990},
["RR_BALLOONPARK"] = {3769, 4165, 4585, 5075},
["RR_CHROMEGADGET"] = {2633, 2905, 3220, 3570},
["RR_DESERTPALACE"] = {3360, 3710, 4095, 4515},
["RR_ENDLESSMINE"] = {4952, 5460, 6020, 6650},
["RR_HARDBOILEDSTADIUM"] = {3881, 4585, 5075, 5600},
["RR_HARDHATHAVOC"] = {3507, 4095, 4515, 4970},
["RR_PRESSGARDEN"] = {3696, 4410, 4865, 5355},
["RR_PICOPARK"] = {2057, 2660, 2940, 3255},
["RR_CITYESCAPE"] = {4419, 5180, 5705, 6300},
["RR_NORTHERNDISTRICT"] = {3436, 3780, 4165, 4585},
["RR_PALMTREEPANIC"] = {3100, 3430, 3780, 4165},
["RR_DARKVILECASTLE2"] = {3020, 3570, 3955, 4375},
["RR_SCARLETGARDENS"] = {2927, 3220, 3570, 3955},
["RR_MOTOBUGMOTORWAY"] = {4340, 4795, 5285, 5845},
["RR_STARLIGHT"] = {4040, 4445, 4900, 5390},
["RR_METROPOLIS"] = {3772, 4165, 4585, 5075},
["RR_FROZENPRODUCTION"] = {5117, 5635, 6230, 6860},
["RR_AQUEDUCTCRYSTAL"] = {3675, 4270, 4725, 5215},
["RR_NOVASHORE"] = {3854, 4270, 4725, 5215},
["RR_HYDROCITY"] = {4980, 5495, 6055, 6685},
["RR_PANICCITY"] = {2986, 3325, 3675, 4060},
["RR_TRAPTOWER"] = {2826, 3535, 3920, 4340},
["RR_DIAMONDDUST"] = {3903, 5810, 6405, 7070},
["RR_BLUEMOUNTAIN1"] = {4031, 4725, 5215, 5740},
["RR_BLUEMOUNTAIN2"] = {3855, 4270, 4725, 5215},
["RR_SPEEDHIGHWAY"] = {3747, 4305, 4760, 5250},
["RR_CARNIVALNIGHT"] = {3634, 4655, 5145, 5670},
["RR_VIRTUALHIGHWAY"] = {3604, 4445, 4900, 5390},
["RR_DARKFORTRESS"] = {3800, 4445, 4900, 5390},
["RR_SPRINGYARD"] = {4173, 4795, 5285, 5845},
["RR_LABYRINTH"] = {3995, 4410, 4865, 5355},
["RR_SONICSPEEDWAY"] = {3247, 3605, 3990, 4410},
["RR_HOTSHELTER"] = {4291, 4830, 5320, 5880},
["RR_SKYSANCTUARY"] = {4566, 5215, 5740, 6335},
["RR_LOSTCOLONY"] = {5066, 6125, 6755, 7455},
["RR_DEATHEGG"] = {10256, 12040, 13265, 14595},
["RR_765STADIUM"] = {3467, 3815, 4200, 4620},
["RR_SKYSCRAPERLEAPS"] = {3365, 3780, 4165, 4585},
["RR_GREENTRIANGLE"] = {2622, 2905, 3220, 3570},
["RR_ZONEDCITY"] = {3144, 3535, 3920, 4340},
["RR_SUNSETHILL"] = {4381, 4830, 5320, 5880},
["RR_SAVANNAHCITADEL"] = {4269, 4725, 5215, 5740},
["RR_GREENHILLS"] = {4939, 5460, 6020, 6650},
["RR_UMBRELLARUSHWINDS"] = {3961, 4480, 4935, 5460},
["RR_AVANTGARDEN"] = {2902, 3255, 3605, 3990},
["RR_BIGTIMEBREAKDOWN"] = {3449, 3815, 4200, 4620},
["RR_VANTABLACKVIOLET"] = {4090, 4515, 4970, 5495},
["RR_CHAOSTUBE"] = {3591, 4165, 4585, 5075},
["RR_DIMENSIONDISASTER"] = {3061, 3500, 3850, 4235},
["RR_AURORAATOLL"] = {3190, 3780, 4165, 4585},
["RR_DAYTONASPEEDWAY"] = {3097, 3430, 3780, 4165},
["RR_TURQUOISEHILL"] = {4359, 5320, 5880, 6475},
["RR_WEISSWATERWAY"] = {4288, 4725, 5215, 5740},
["RR_EMERALDCOAST"] = {2926, 3220, 3570, 3955},
["RR_ICEPARADISE"] = {4909, 5425, 5985, 6615},
["RR_SUNSPLASHEDGETAWAY"] = {3558, 3920, 4340, 4795},
["RR_FAEFALLS"] = {3643, 4445, 4900, 5390},
["RR_AZUREAXIOM"] = {3864, 4340, 4795, 5285},
["RR_HANAGUMIHALL"] = {3471, 3850, 4235, 4690},
["RR_CRISPYCANYON"] = {2658, 3045, 3360, 3710},
["RR_AERIALHIGHLANDS"] = {4697, 5180, 5705, 6300},
["RR_TECHNOLOGYTUNDRA"] = {4399, 4865, 5355, 5915},
["RR_OPERATORSOVERSPACE"] = {4382, 4830, 5320, 5880},
["RR_MEGAGREENHILL"] = {2526, 3115, 3430, 3780}
	//[""] = {}, //
	//...
}, {__index = function() return {1, 2, 3, 4} end}))

rawset(_G, "firstloadmap", function(map, force)
	if not map then
		CONS_Printf(p,"Missing map number!")
		return
	end
	if not mapheaderinfo[map] then
		CONS_Printf(p,"Map "..map.." doesn't currently exist!")
		return
	end
	if setmaps[string.upper(G_BuildMapName(map))] and (not force) then return false end //This map has been loaded in before.
	
	local basetime = tonumber(mapheaderinfo[map].arcadetime)
	if basetime == nil then
		basetime = DTRBASETIME
	elseif basetime < 30 then
		basetime = 30
	elseif (basetime > 180) and (string.upper(G_BuildMapName(map)) != "RR_TESTRUN") and (not mapheaderinfo[map].arcadeboss) then //Test Run can have a lot of time
		basetime = 180
	elseif (basetime%5) ~= 0 then
		basetime = $ + 5 - ($%5)
	end
	
	local bonustime = tonumber(mapheaderinfo[map].arcadebonus)
	if bonustime == nil then
		bonustime = BASEBONUS
	elseif (mapheaderinfo[map].arcadeboss) or (bonustime == 0) then
		bonustime = 0
	elseif bonustime < 10 then
		bonustime = 10
	elseif bonustime > 90 then
		bonustime = 90
	elseif (bonustime%5) ~= 0 then
		bonustime = $ + 5 - ($%5)
	end
	if bonustime > basetime then bonustime = basetime end
	
	DTRTimes[string.upper(G_BuildMapName(map))] = {basetime, bonustime}
	setmaps[string.upper(G_BuildMapName(map))] = true
	if not force then print("Map "..G_BuildMapName(map).." is now loaded!") end
	return true //This is the first time loading in the map!
end)
	
rawset(_G, "GetDTRTimes", function(map)
	if not map then
		CONS_Printf(p,"Missing map number!")
		return
	end
	if not mapheaderinfo[map] then
		CONS_Printf(p,"Map "..map.." doesn't currently exist!")
		return
	end
	firstloadmap(map, false)
	local soc
	soc = DTRTimes[string.upper(G_BuildMapName(map))]
	if not soc then soc = {DTRBASETIME, DTRBASEBONUS} end
	return soc[1] * TICRATE, soc[2] * TICRATE
end)

rawset(_G, "GetDTRMedals", function(map)
	if not map then
		CONS_Printf(p,"Missing map number or name!")
		return
	end
	if not mapheaderinfo[map] or setmaps[string.upper(map)] then
		CONS_Printf(p,"Map "..map.." doesn't currently exist!")
		return
	end
	local soc
	if setmaps[string.upper(map)] then
		soc = DTRMedals[string.upper(map)]
	else
		soc = DTRMedals[string.upper(G_BuildMapName(map))]
	end
	if not soc then soc = {1,2,3,4} end
	if not soc[2] then 
		soc[2] = ((soc[1] * 11) / 10)
		if not (soc[2] % TICRATE) == 0 then soc[2] = $ - (soc[2] % TICRATE) + TICRATE end
	end
	if not soc[3] then 
		soc[3] = ((soc[2] * 11) / 10)
		if not (soc[3] % TICRATE) == 0 then soc[3] = $ - (soc[3] % TICRATE) + TICRATE end
	end
	if not soc[4] then 
		soc[4] = ((soc[3] * 11) / 10)
		if not (soc[4] % TICRATE) == 0 then soc[4] = $ - (soc[4] % TICRATE) + TICRATE end
	end
	return soc
end)

for i = 1, 234 do
	setmaps[string.upper(G_BuildMapName(tonumber(i)))] = true
end

rawset(_G, "setnewmaptime", function(p, map, base, bonus, override)
	local newbase = tonumber(base)
	local newbonus = tonumber(bonus)
	if not (tonumber(map) and newbase) then
		CONS_Printf(p,"Missing map number and/or base time!")
		return
	end
	if not mapheaderinfo[tonumber(map)] then
		CONS_Printf(p,"Map "..map.." doesn't currently exist!")
		return
	end
	if (not newbonus) and (not mapheaderinfo[map].arcadeboss) then
		CONS_Printf(p,"Missing time bonus!")
		return
	end
	newbase = max(30,$)
	if newbase%5 > 0 then
		newbase = $ + 5 - ($%5)
	end
	if mapheaderinfo[map].arcadeboss then
		newbonus = 0
	else
		newbase = min(180,$)
		newbonus =  min(90,max(10,$))
	end
	if newbonus%5 > 0 then
		newbonus = $ + 5 - ($%5)
	end
	if setmaps[string.upper(G_BuildMapName(tonumber(map)))] and not override then
		CONS_Printf(p,"This map already has a time limit set!")
		return
	else
		if override and setmaps[string.upper(G_BuildMapName(tonumber(map)))] then CONS_Printf(p,"Overriding times for Map "..G_BuildMapName(tonumber(map)).."...") end
		DTRTimes[string.upper(G_BuildMapName(tonumber(map)))] = {newbase, newbonus}
		setmaps[string.upper(G_BuildMapName(tonumber(map)))] = true
		CONS_Printf(p,"Map times for Map "..string.upper(G_BuildMapName(tonumber(map))).." are set! "..DTRTimes[string.upper(G_BuildMapName(tonumber(map)))][1].."s start, "..DTRTimes[string.upper(G_BuildMapName(tonumber(map)))][2].."s bonus per lap")
	end
end)

COM_AddCommand("setmaptime", function(p, map, base, bonus, override)
	setnewmaptime(p, map, base, bonus, override)
end, 1)

COM_AddCommand("checkmaptime", function(p, map)
	if setmaps[string.upper(map)] then
		CONS_Printf(p, DTRTimes[string.upper(map)][1].."s start, "..DTRTimes[string.upper(map)][2].."s bonus for map "..string.upper(map))
	elseif not tonumber(map) then
		CONS_Printf(p, "Missing map number!")
	elseif not mapheaderinfo[tonumber(map)] then
		CONS_Printf(p,"Map "..map.." doesn't currently exist!")
	elseif setmaps[string.upper(G_BuildMapName(tonumber(map)))] then
		CONS_Printf(p, DTRTimes[string.upper(G_BuildMapName(tonumber(map)))][1].."s start, "..DTRTimes[string.upper(G_BuildMapName(tonumber(map)))][2].."s bonus for map "..map)
	else
		CONS_Printf(p, "This map doesn't have a time set yet!")
	end
end)