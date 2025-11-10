//This code is for all the map related stuff in Daytona Racers

local DTRBASETIME = 180
local DTRBASEBONUS = 60
local DTRBASECHECKBONUS = 10
local DTRBASELAPBONUS = 30

rawset(_G, "setmaps", {}) //Used to check if a map has times for them set

//New time listing:
//{Base Time, Lap Bonus, Checkpoint Bonus, Total Time Extensions}

rawset (_G, "DTRNewTimes", setmetatable({
["RR_TESTRUN"] = {300, 0, 0, 0},
["RR_TESTTRACK"] = {75, 10, 15, 8},
["RR_PODIUM"] = {-1, 0, 0, 0},
["RR_TITLE"] = {-1, 0, 0, 0},
["RR_ROBOTNIKCOASTER"] = {75, 10, 15, 9},
["RR_NORTHERNDISTRICT"] = {65, 15, 10, 7},
["RR_PANICCITY"] = {80, 10, 10, 11},
["RR_SONICSPEEDWAY"] = {65, 15, 10, 5},
["RR_GREENHILLS"] = {80, 15, 10, 8},
["RR_EMERALDCOAST"] = {65, 10, 5, 8},
["RR_STORMRIG"] = {70, 15, 15, 5},
["RR_LUCIDPASS"] = {65, 10, 15, 7},
["RR_AUTUMNRING"] = {80, 15, 10, 8},
["RR_WITHERINGCHATEAU"] = {75, 10, 10, 8},
["RR_POPCORNWORKSHOP"] = {70, 10, 10, 9},
["RR_SUNDAEDRIVE"] = {70, 0, 20, 4},
["RR_CADILLACCASCADE"] = {75, 15, 10, 8},
["RR_OPULENCE"] = {80, 10, 20, 8},
["RR_RUMBLERIDGE"] = {85, 10, 15, 8},
["RR_ANGELISLAND"] = {85, 10, 20, 8},
["RR_ROASTEDRUINS"] = {-10, 15, 20, 11},
["RR_OBSIDIANOASIS"] = {75, 10, 10, 8},
["RR_MIRAGESALOON"] = {75, 10, 15, 8},
["RR_REGALRUIN"] = {60, 15, 10, 5},
["RR_ISOLATEDISLAND"] = {80, 10, 15, 8},
["RR_GIGAPOLIS"] = {65, 15, 10, 7},
["RR_DARKVILECASTLE1"] = {75, 10, 10, 8},
["RR_BRONZELAKE"] = {75, 15, 5, 8},
["RR_COLLISIONCHAOS"] = {90, 15, 15, 9},
["RR_EMERALDHILL"] = {65, 15, 5, 8},
["RR_AZURECITY"] = {60, 15, 5, 7},
["RR_GUSTPLANET"] = {70, 15, 5, 8},
["RR_MYSTICCAVE"] = {85, 10, 10, 11},
["RR_JOYPOLIS"] = {80, 10, 5, 9},
["RR_HIDDENPALACE"] = {85, 15, 15, 8},
["RR_HILLTOP"] = {75, 15, 5, 8},
["RR_MARBLEGARDEN"] = {75, 20, 5, 8},
["RR_SILVERCLOUDISLAND"] = {75, 10, 15, 8},
["RR_SUBZEROPEAK"] = {80, 15, 10, 8},
["RR_LAUNCHBASE"] = {80, 20, 5, 8},
["RR_AZURELAKE"] = {75, 0, 20, 4},
["RR_BALLOONPARK"] = {75, 0, 30, 4},
["RR_CHROMEGADGET"] = {70, 0, 20, 4},
["RR_DESERTPALACE"] = {65, 5, 15, 9},
["RR_ENDLESSMINE"] = {65, 15, 5, 9},
["RR_HARDBOILEDSTADIUM"] = {75, 15, 10, 8},
["RR_HARDHATHAVOC"] = {90, 15, 10, 9},
["RR_PRESSGARDEN"] = {70, 10, 15, 8},
["RR_PICOPARK"] = {95, 0, 10, 11},
["RR_CITYESCAPE"] = {95, 15, 0, 7},
["RR_PALMTREEPANIC"] = {75, 15, 10, 8},
["RR_DARKVILECASTLE2"] = {90, 10, 10, 11},
["RR_SCARLETGARDENS"] = {80, 0, 20, 5},
["RR_MOTOBUGMOTORWAY"] = {75, 15, 5, 8},
["RR_STARLIGHT"] = {75, 15, 5, 8},
["RR_METROPOLIS"] = {75, 10, 15, 8},
["RR_FROZENPRODUCTION"] = {80, 20, 10, 7},
["RR_AQUEDUCTCRYSTAL"] = {55, 20, 5, 5},
["RR_NOVASHORE"] = {75, 15, 5, 8},
["RR_HYDROCITY"] = {75, 15, 15, 8},
["RR_TRAPTOWER"] = {85, 10, 10, 14},
["RR_DIAMONDDUST"] = {85, 15, 15, 8},
["RR_BLUEMOUNTAIN1"] = {65, 20, 15, 5},
["RR_BLUEMOUNTAIN2"] = {85, 15, 0, 6},
["RR_SPEEDHIGHWAY"] = {95, 15, 0, 5},
["RR_CARNIVALNIGHT"] = {75, 15, 10, 8},
["RR_VIRTUALHIGHWAY"] = {65, 20, 5, 5},
["RR_ROUTE1980"] = {90, 15, 0, 5},
["RR_DARKFORTRESS"] = {70, 20, 15, 5},
["RR_SPRINGYARD"] = {80, 15, 15, 8},
["RR_LABYRINTH"] = {70, 15, 5, 7},
["RR_HOTSHELTER"] = {75, 15, 15, 8},
["RR_SKYSANCTUARY"] = {75, 20, 5, 7},
["RR_LOSTCOLONY"] = {95, 15, 20, 9},
["RR_DEATHEGG"] = {100, 25, 5, 14},
["RR_765STADIUM"] = {65, 10, 5, 9},
["RR_SKYSCRAPERLEAPS"] = {65, 15, 15, 7},
["RR_GREENTRIANGLE"] = {60, 0, 20, 6},
["RR_ZONEDCITY"] = {80, 10, 15, 11},
["RR_SUNSETHILL"] = {75, 15, 5, 8},
["RR_SAVANNAHCITADEL"] = {70, 15, 5, 8},
["RR_UMBRELLARUSHWINDS"] = {70, 15, 5, 8},
["RR_AVANTGARDEN"] = {80, 15, 5, 11},
["RR_BIGTIMEBREAKDOWN"] = {80, 15, 5, 11},
["RR_VANTABLACKVIOLET"] = {70, 15, 5, 8},
["RR_CHAOSTUBE"] = {90, 20, 5, 8},
["RR_DIMENSIONDISASTER"] = {70, 15, 10, 9},
["RR_AURORAATOLL"] = {70, 10, 15, 8},
["RR_DAYTONASPEEDWAY"] = {85, 10, 15, 7},
["RR_TURQUOISEHILL"] = {70, 20, 5, 8},
["RR_WEISSWATERWAY"] = {70, 0, 30, 4},
["RR_ICEPARADISE"] = {80, 15, 15, 8},
["RR_SUNSPLASHEDGETAWAY"] = {75, 0, 20, 5},
["RR_FAEFALLS"] = {60, 20, 5, 5},
["RR_AZUREAXIOM"] = {90, 15, 0, 7},
["RR_HANAGUMIHALL"] = {80, 10, 10, 9},
["RR_CRISPYCANYON"] = {65, 15, 15, 7},
["RR_AERIALHIGHLANDS"] = {80, 15, 15, 8},
["RR_TECHNOLOGYTUNDRA"] = {75, 20, 5, 7},
["RR_OPERATORSOVERSPACE"] = {100, 15, 15, 11},
["RR_MEGAGREENHILL"] = {85, 0, 25, 13},
["RR_MEGABRIDGE"] = {85, 0, 25, 11},
["RR_MEGALAVAREEF"] = {80, 0, 25, 4},
["RR_MEGAICECAP"] = {105, 0, 25, 9},
["RR_MEGASCRAPBRAIN"] = {80, 0, 25, 9},
["RR_CLOUDTOPDIMENSION"] = {70, 15, 5, 7},
["RR_NIGHTFALLDIMENSION"] = {65, 15, 5, 8},
["RR_WAVECRASHDIMENSION"] = {65, 10, 15, 9},
["RR_VOIDDANCEDIMENSION"] = {75, 10, 10, 8},
["RR_GRAVTECHDIMENSION"] = {80, 15, 15, 8},
["RR_ESPRESSOLANE"] = {70, 10, 10, 8},
["RR_MELTYMANOR"] = {75, 10, 10, 8},
["RR_LEAFSTORM"] = {65, 20, 5, 7},
["RR_LAKEMARGORITE"] = {80, 15, 5, 8},
["RR_ENDLESSMINE2"] = {75, 15, 10, 8},
["RR_CYANBELLTOWER"] = {75, 20, 5, 8},
["RR_QUARTZQUADRANT"] = {65, 15, 5, 8},
["RR_AQUATUNNEL"] = {65, 25, 5, 5},
["RR_WATERPALACE"] = {80, 15, 15, 7},
["RR_FINALFALL"] = {65, 15, 5, 8},
["RR_HAUNTEDSHIP"] = {75, 15, 5, 8},
["RR_ROBOTNIKWINTER"] = {70, 15, 10, 8},
["RR_DRAGONSPIRESEWER1"] = {70, 15, 5, 7},
["RR_ABYSSGARDEN"] = {75, 20, 0, 5},
["RR_BLIZZARDPEAKS"] = {85, 15, 25, 7},
["RR_VERMILLIONVESSEL"] = {75, 15, 5, 8},
["RR_DRAGONSPIRESEWER2"] = {65, 20, 5, 7},
["RR_CHEMICALFACILITY"] = {90, 20, 20, 7},
["RR_COASTALTEMPLE"] = {75, 20, 5, 8},
["RR_MONKEYMALL"] = {70, 15, 5, 9},
["RR_RAMPPARK"] = {80, 15, 30, 5},
["RR_ADVENTANGEL"] = {65, 0, 30, 4},
["RR_PESTILENCE"] = {70, 15, 10, 8},
["RR_CRIMSONCORE"] = {75, 20, 5, 8},
["RR_LASVEGAS"] = {85, 15, 0, 6},
["RR_MEGACOLLISIONCHAOS"] = {75, 0, 25, 4},
["RR_MEGASTARLIGHT"] = {65, 0, 20, 4},
["RR_MEGASANDOPOLIS"] = {65, 0, 20, 5},
["RR_MEGAAQUALAKE"] = {75, 10, 15, 9},
["RR_MEGAFLYINGBATTERY"] = {70, 10, 5, 9},
["RR_SKYBABYLON"] = {90, 10, 10, 11},
["RR_KODACHROMEVOID"] = {70, 15, 10, 7},
["RR_LAVENDERSHRINE"] = {65, 20, 5, 5},
["RR_HOTCRATER"] = {80, 15, 20, 7},
["RR_THUNDERPISTON"] = {100, 15, 30, 7},
["RR_SRB2FROZENNIGHT"] = {75, 0, 25, 4},
["RR_BARRENBADLANDS"] = {70, 15, 5, 8},
["RR_SHUFFLESQUARE"] = {80, 10, 5, 9},
["RR_BLUEMOUNTAINCLASSIC"] = {60, 20, 5, 5},
["RR_ANGELARROWCLASSIC"] = {75, 0, 25, 4},
["RR_CADILLACCANYONCLASSIC"] = {70, 15, 10, 7},
["RR_DIAMONDDUSTCLASSIC"] = {65, 15, 15, 5},
["RR_BLIZZARDPEAKSCLASSIC"] = {75, 15, 10, 8},
["RR_LAUNCHBASECLASSIC"] = {65, 15, 10, 5},
["RR_LAVENDERSHRINECLASSIC"] = {75, 15, 10, 7},
["RR_DUELBUSTER"] = {-1, 0, 0, 0},
["RR_MUNICIPALMEADOW"] = {-1, 0, 0, 0},
["RR_CDSPECIALSTAGE1"] = {-1, 0, 0, 0},
["RR_TINKERERSARENA"] = {-1, 0, 0, 0},
["RR_TRICIRCLEMARINA"] = {-1, 0, 0, 0},
["RR_MYSTERYGATE"] = {-1, 0, 0, 0},
["RR_RUSTYRIG"] = {-1, 0, 0, 0},
["RR_MARBLEFOYER"] = {-1, 0, 0, 0},
["RR_ROCKWORLD"] = {-1, 0, 0, 0},
["RR_WORLD1MAP"] = {-1, 0, 0, 0},
["RR_CDSPECIALSTAGE8"] = {-1, 0, 0, 0},
["RR_SEGASATURN"] = {-1, 0, 0, 0},
["RR_ELECTRACLACKER"] = {-1, 0, 0, 0},
["RR_THUNDERTOP"] = {-1, 0, 0, 0},
["RR_TREERING"] = {-1, 0, 0, 0},
["RR_FRIGIDCOVE"] = {-1, 0, 0, 0},
["RR_GIZMOBASTION"] = {-1, 0, 0, 0},
["RR_CARBONCRUCIBLE"] = {-1, 0, 0, 0},
["RR_SECURITYHALL"] = {-1, 0, 0, 0},
["RR_GEMSMUSEUM"] = {-1, 0, 0, 0},
["RR_MEDIASTUDIO"] = {-1, 0, 0, 0},
["RR_HONEYCOMBHOLLOW"] = {-1, 0, 0, 0},
["RR_WOOD"] = {-1, 0, 0, 0},
["RR_BRAWLFORT"] = {-1, 0, 0, 0},
["RR_CRYSTALISLAND"] = {-1, 0, 0, 0},
["RR_CYBERARENA"] = {-1, 0, 0, 0},
["RR_NEONRESORT"] = {-1, 0, 0, 0},
["RR_METEORHERD"] = {-1, 0, 0, 0},
["RR_DEATHEGGSEYE"] = {-1, 0, 0, 0},
["RR_TAILSLAB"] = {-1, 0, 0, 0},
["RR_POWERPLANT"] = {-1, 0, 0, 0},
["RR_CITYSKYLINE"] = {-1, 0, 0, 0},
["RR_VANTABLACKATRIUM"] = {-1, 0, 0, 0},
["RR_DEADSIMPLE"] = {-1, 0, 0, 0},
["RR_MARTIANMATRIX"] = {-1, 0, 0, 0},
["RR_DARKCHAOGARDEN"] = {-1, 0, 0, 0},
["RR_HEROCHAOGARDEN"] = {-1, 0, 0, 0},
["RR_WHIRLWATERS"] = {-1, 0, 0, 0},
["RR_DELUGEDMETROPLEX"] = {-1, 0, 0, 0},
["RR_MEGAEMERALDBEACH"] = {-1, 0, 0, 0},
["RR_MEGALABYRINTH"] = {-1, 0, 0, 0},
["RR_FUNGALDIMENSION"] = {-1, 0, 0, 0},
["RR_ASTRALDIMENSION"] = {-1, 0, 0, 0},
["RR_CHAOSSERAPH"] = {-1, 0, 0, 0},
["RR_TOYKINGDOM"] = {-1, 0, 0, 0},
["RR_AQUATICCATHEDRAL1"] = {-1, 0, 0, 0},
["RR_AQUATICCATHEDRAL2"] = {-1, 0, 0, 0},
["RR_FROSTYCOURTYARD"] = {-1, 0, 0, 0},
["RR_ABYSSGATE"] = {-1, 0, 0, 0},
["RR_SONICSSCHOOLHOUSE"] = {-1, 0, 0, 0},
["RR_RECORDATTACK"] = {-1, 0, 0, 0},
["RR_PEANUTPALACE"] = {-1, 0, 0, 0},
["RR_HYDROPLANT"] = {-1, 0, 0, 0},
["RR_MEGAMETROPOLIS"] = {-1, 0, 0, 0},
["RR_MEGAMARBLE"] = {-1, 0, 0, 0},
["RR_THUNDERLAB"] = {-1, 0, 0, 0},
["RR_MALIGNEGGSHRINE"] = {-1, 0, 0, 0},
["RR_SRB2MEADOWMATCH"] = {-1, 0, 0, 0},
["RR_ARMOREDARMADILLO"] = {-1, 0, 0, 0},
["RR_CLUCKYFARMS"] = {-1, 0, 0, 0},
["RR_DRIEDBATTLEDUNE"] = {-1, 0, 0, 0},
["RR_SEALEDSTARBALCONIES"] = {-1, 0, 0, 0},
["RR_SEALEDSTARCHURCH"] = {-1, 0, 0, 0},
["RR_SEALEDSTARCOURTYARD"] = {-1, 0, 0, 0},
["RR_SEALEDSTARVILLA"] = {-1, 0, 0, 0},
["RR_SEALEDSTARVENICE"] = {-1, 0, 0, 0},
["RR_SEALEDSTARSPIKES"] = {-1, 0, 0, 0},
["RR_SEALEDSTARFOUNTAIN"] = {-1, 0, 0, 0},
["RR_SEALEDSTARGALLERY"] = {-1, 0, 0, 0},
["RR_SEALEDSTARALLEY"] = {-1, 0, 0, 0},
["RR_SEALEDSTARSTEEPLE"] = {-1, 0, 0, 0},
["RR_SEALEDSTARROOFTOPS"] = {-1, 0, 0, 0},
["RR_SEALEDSTARROULETTE"] = {-1, 0, 0, 0},
["RR_SEALEDSTARTOWERS"] = {-1, 0, 0, 0},
["RR_SEALEDSTARATLANTIS"] = {-1, 0, 0, 0},
["RR_ADVENTUREEXAMPLE"] = {-1, 0, 0, 0},
["RR_SUNBEAMPARADISEPLAYGROUND"] = {900, 0, 0, 0},
["RR_SUNBEAMPARADISECONTROLS"] = {-1, 0, 0, 0},
["RR_SUNBEAMPARADISERINGS"] = {-1, 0, 0, 0},
["RR_SUNBEAMPARADISEBRAKES"] = {-1, 0, 0, 0},
["RR_SUNBEAMPARADISEDRIFTING"] = {-1, 0, 0, 0},
["RR_SUNBEAMPARADISEITEMS"] = {-1, 0, 0, 0},
["RR_SUNBEAMPARADISESPRINGS"] = {-1, 0, 0, 0},
	//...
}, {__index = function() return {DTRBASETIME, DTRBASECHECKBONUS, DTRBASELAPBONUS, 0} end}))

rawset(_G, "DTRTimes", setmetatable({
	["RR_TESTRUN"] = {300, 0},
	["RR_TESTTRACK"] = {100, 35},
	["RR_STORMRIG"] = {105, 35},
	["RR_MEGABRIDGE"] = {95, 20},
	["RR_MEGALAVAREEF"] = {90, 25},
	["RR_MEGAICECAP"] = {110, 25},
	["RR_MEGASCRAPBRAIN"] = {105, 25},
	["RR_CLOUDTOPDIMENSION"] = {70, 50},
	["RR_NIGHTFALLDIMENSION"] = {115, 40},
	["RR_WAVECRASHDIMENSION"] = {120, 25},
	["RR_VOIDDANCEDIMENSION"] = {90, 35},
	["RR_GRAVTECHDIMENSION"] = {115, 40},
	["RR_ESPRESSOLANE"] = {100, 40},
	["RR_LUCIDPASS"] = {95, 25},
	["RR_MELTYMANOR"] = {100, 35},
	["RR_LEAFSTORM"] = {105, 34},
	["RR_LAKEMARGORITE"] = {105, 40},
	["RR_ENDLESSMINE2"] = {110, 40},
	["RR_CYANBELLTOWER"] = {110, 50},
	["RR_QUARTZQUADRANT"] = {105, 40},
	["RR_AQUATUNNEL"] = {125, 40},
	["RR_WATERPALACE"] = {140, 65},
	["RR_FINALFALL"] = {105, 35},
	["RR_HAUNTEDSHIP"] = {110, 45},
	["RR_AUTUMNRING"] = {125, 45},
	["RR_ROBOTNIKWINTER"] = {120, 45},
	["RR_DRAGONSPIRESEWER1"] = {85, 35},
	["RR_ABYSSGARDEN"] = {115, 35},
	["RR_BLIZZARDPEAKS"] = {140, 70},
	["RR_VERMILIONVESSEL"] = {110, 45},
	["RR_DRAGONSPIRESEWER2"] = {95, 35},
	["RR_CHEMICALFACILITY"] = {135, 65},
	["RR_COASTALTEMPLE"] = {110, 50},
	["RR_MONKEYMALL"] = {70, 30},
	["RR_RAMPPARK"] = {140, 70},
	["RR_WITHERINGCHATEAU"] = {105, 35},
	["RR_ADVENTANGEL"] = {135, 20},
	["RR_PESTILENCE"] = {120, 40},
	["RR_CRIMSONCORE"] = {125, 50},
	["RR_LASVEGAS"] = {105, 35},
	["RR_MEGACOLLISIONCHAOS"] = {95, 25},
	["RR_MEGASTARLIGHT"] = {90, 20},
	["RR_MEGASANDOPOLIS"] = {95, 15},
	["RR_MEGAAQUALAKE"] = {105, 20},
	["RR_MEGAFLYINGBATTERY"] = {95, 25},
	["RR_SKYBABYLON"] = {110, 40},
	["RR_POPCORNWORKSHOP"] = {105, 25},
	["RR_KODACHROMEVOID"] = {105, 30},
	["RR_LAVENDERSHRINE"] = {135, 40},
	["RR_THUNDERPISTON"] = {155, 60},
	["RR_DEADLINE"] = {120, 55},
	["RR_SRB2FROZENNIGHT"] = {105, 25},
	["RR_BARRENBADLANDS"] = {95, 35},
	["RR_SHUFFLESQUARE"] = {120, 25},
	["RR_BLUEMOUNTAINCLASSIC"] = {95, 35},
	["RR_ANGELARROWCLASSIC"] = {100, 25},
	["RR_CADILLACCANYONCLASSIC"] = {95, 30},
	["RR_SUNDAEDRIVE"] = {90, 20},
	["RR_DIAMONDDUSTCLASSIC"] = {105, 35},
	["RR_BLIZZARDPEAKSCLASSIC"] = {100, 40},
	["RR_LAUNCHBASECLASSIC"] = {95, 35},
	["RR_LAVENDERSHRINECLASSIC"] = {105, 50},
	["RR_CADILLACCASCADE"] = {110, 45},
	["RR_OPULENCE"] = {110, 45},
	["RR_RUMBLERIDGE"] = {100, 40},
	["RR_ANGELISLAND"] = {115, 45},
	["RR_PODIUM"] = {-1, 0},
	["RR_ROASTEDRUINS"] = {90, 35},
	["RR_OBSIDIANOASIS"] = {100, 35},
	["RR_SEALEDSTARBALCONIES"] = {-1, 0},
	["RR_SEALEDSTARCHURCH"] = {-1, 0},
	["RR_SEALEDSTARCOURTYARD"] = {-1, 0},
	["RR_SEALEDSTARVILLA"] = {-1, 0},
	["RR_SEALEDSTARVENICE"] = {-1, 0},
	["RR_SEALEDSTARSPIKES"] = {-1, 0},
	["RR_MIRAGESALOON"] = {110, 40},
	["RR_SEALEDSTARFOUNTAIN"] = {-1, 0},
	["RR_SEALEDSTARGALLERY"] = {-1, 0},
	["RR_SEALEDSTARALLEY"] = {-1, 0},
	["RR_SEALEDSTARSTEEPLE"] = {-1, 0},
	["RR_SEALEDSTARROOFTOPS"] = {-1, 0},
	["RR_SEALEDSTARROULETTE"] = {-1, 0},
	["RR_SEALEDSTARTOWERS"] = {-1, 0},
	["RR_SEALEDSTARATLANTIS"] = {-1, 0},
	["RR_ADVENTUREEXAMPLE"] = {-1, 0},
	["RR_SUNBEAMPARADISECONTROLS"] = {-1, 0},
	["RR_REGALRUIN"] = {95, 30},
	["RR_SUNBEAMPARADISERINGS"] = {-1, 0},
	["RR_SUNBEAMPARADISEBRAKES"] = {-1, 0},
	["RR_SUNBEAMPARADISEDRIFTING"] = {-1, 0},
	["RR_SUNBEAMPARADISESPRINGS"] = {-1, 0},
	["RR_ISOLATEDISLAND"] = {110, 40},
	["RR_GIGAPOLIS"] = {90, 30},
	["RR_DARKVILECASTLE1"] = {90, 35},
	["RR_BRONZELAKE"] = {115, 45},
	["RR_COLLISIONCHAOS"] = {155, 75},
	["RR_EMERALDHILL"] = {105, 40},
	["RR_TITLE"] = {-1, 0},
	["RR_AZURECITY"] = {110, 25},
	["RR_GUSTPLANET"] = {115, 40},
	["RR_MYSTICCAVE"] = {90, 35},
	["RR_JOYPOLIS"] = {90, 20},
	["RR_HIDDENPALACE"] = {130, 55},
	["RR_HILLTOP"] = {115, 40},
	["RR_MARBLEGARDEN"] = {145, 55},
	["RR_SILVERCLOUDISLAND"] = {105, 35},
	["RR_SUBZEROPEAK"] = {115, 45},
	["RR_LAUNCHBASE"] = {140, 55},
	["RR_ROBOTNIKCOASTER"] = {85, 25},
	["RR_AZURELAKE"] = {85, 20},
	["RR_BALLOONPARK"] = {105, 25},
	["RR_CHROMEGADGET"] = {75, 20},
	["RR_DESERTPALACE"] = {100, 20},
	["RR_ENDLESSMINE"] = {120, 30},
	["RR_HARDBOILEDSTADIUM"] = {110, 40},
	["RR_HARDHATHAVOC"] = {105, 35},
	["RR_PRESSGARDEN"] = {115, 30},
	["RR_PICOPARK"] = {55, 10},
	["RR_CITYESCAPE"] = {120, 45},
	["RR_NORTHERNDISTRICT"] = {95, 35},
	["RR_PALMTREEPANIC"] = {105, 45},
	["RR_DARKVILECASTLE2"] = {95, 30},
	["RR_SCARLETGARDENS"] = {85, 20},
	["RR_MOTOBUGMOTORWAY"] = {110, 45},
	["RR_STARLIGHT"] = {105, 40},
	["RR_METROPOLIS"] = {105, 35},
	["RR_FROZENPRODUCTION"] = {155, 75},
	["RR_AQUEDUCTCRYSTAL"] = {100, 40},
	["RR_NOVASHORE"] = {100, 40},
	["RR_HYDROCITY"] = {125, 50},
	["RR_PANICCITY"] = {90, 30},
	["RR_TRAPTOWER"] = {95, 30},
	["RR_DIAMONDDUST"] = {145, 45},
	["RR_BLUEMOUNTAIN1"] = {105, 45},
	["RR_BLUEMOUNTAIN2"] = {80, 50},
	["RR_SPEEDHIGHWAY"] = {65, 45},
	["RR_CARNIVALNIGHT"] = {125, 35},
	["RR_VIRTUALHIGHWAY"] = {115, 35},
	["RR_DARKFORTRESS"] = {125, 60},
	["RR_SPRINGYARD"] = {120, 40},
	["RR_LABYRINTH"] = {125, 60},
	["RR_SONICSPEEDWAY"] = {90, 35},
	["RR_HOTSHELTER"] = {110, 45},
	["RR_SKYSANCTUARY"] = {150, 65},
	["RR_LOSTCOLONY"] = {170, 75},
	["RR_DEATHEGG"] = {155, 35},
	["RR_765STADIUM"] = {105, 20},
	["RR_SKYSCRAPERLEAPS"] = {95, 35},
	["RR_GREENTRIANGLE"] = {75, 20},
	["RR_ZONEDCITY"] = {85, 35},
	["RR_SUNSETHILL"] = {110, 45},
	["RR_SAVANNAHCITADEL"] = {105, 45},
	["RR_GREENHILLS"] = {120, 50},
	["RR_UMBRELLARUSHWINDS"] = {110, 40},
	["RR_AVANTGARDEN"] = {100, 45},
	["RR_BIGTIMEBREAKDOWN"] = {95, 35},
	["RR_VANTABLACKVIOLET"] = {110, 40},
	["RR_CHAOSTUBE"] = {95, 40},
	["RR_DIMENSIONDISASTER"] = {85, 35},
	["RR_AURORAATOLL"] = {95, 35},
	["RR_DAYTONASPEEDWAY"] = {80, 35},
	["RR_TURQUOISEHILL"] = {125, 45},
	["RR_WEISSWATERWAY"] = {95, 30},
	["RR_EMERALDCOAST"] = {85, 30},
	["RR_ICEPARADISE"] = {220, 50},
	["RR_SUNSPLASHEDGETAWAY"] = {90, 25},
	["RR_FAEFALLS"] = {130, 55},
	["RR_AZUREAXIOM"] = {75, 55},
	["RR_HANAGUMIHALL"] = {85, 25},
	["RR_CRISPYCANYON"] = {80, 30},
	["RR_AERIALHIGHLANDS"] = {120, 45},
	["RR_TECHNOLOGYTUNDRA"] = {135, 65},
	["RR_OPERATORSOVERSPACE"] = {135, 65},
	["RR_MEGAGREENHILL"] = {80, 20},
	//...
}, {__index = function() return {DTRBASETIME, DTRBASEBONUS} end}))

rawset(_G, "DTRMedals", setmetatable({
["RR_TESTRUN"] = {1, 2, 3, 4},
["RR_TESTTRACK"] = {3299, 3640, 4025, 4445},
["RR_PODIUM"] = {1, 2, 3, 4},
["RR_TITLE"] = {1, 2, 3, 4},
["RR_ROBOTNIKCOASTER"] = {3830, 4655, 5145, 5670},
["RR_NORTHERNDISTRICT"] = {3856, 4270, 4725, 5215},
["RR_PANICCITY"] = {3225, 4200, 4620, 5110},
["RR_SONICSPEEDWAY"] = {3080, 3395, 3745, 4130},
["RR_GREENHILLS"] = {4324, 4760, 5250, 5775},
["RR_EMERALDCOAST"] = {2535, 2835, 3150, 3465},
["RR_STORMRIG"] = {3395, 3850, 4235, 4690},
["RR_LUCIDPASS"] = {2843, 3605, 3990, 4410},
["RR_AUTUMNRING"] = {4168, 4760, 5250, 5775},
["RR_WITHERINGCHATEAU"] = {3108, 3465, 3815, 4200},
["RR_POPCORNWORKSHOP"] = {3396, 3955, 4375, 4830},
["RR_SUNDAEDRIVE"] = {2673, 3220, 3570, 3955},
["RR_CADILLACCASCADE"] = {4125, 4550, 5005, 5530},
["RR_OPULENCE"] = {3679, 4130, 4550, 5005},
["RR_RUMBLERIDGE"] = {3402, 3885, 4305, 4760},
["RR_ANGELISLAND"] = {3791, 4200, 4620, 5110},
["RR_ROASTEDRUINS"] = {3715, 4095, 4515, 4970},
["RR_OBSIDIANOASIS"] = {3050, 3360, 3710, 4095},
["RR_MIRAGESALOON"] = {3400, 3745, 4130, 4550},
["RR_REGALRUIN"] = {2483, 3290, 3640, 4025},
["RR_ISOLATEDISLAND"] = {3437, 3815, 4200, 4620},
["RR_GIGAPOLIS"] = {3807, 4200, 4620, 5110},
["RR_DARKVILECASTLE1"] = {3080, 3395, 3745, 4130},
["RR_BRONZELAKE"] = {3816, 4235, 4690, 5180},
["RR_COLLISIONCHAOS"] = {4300, 5110, 5635, 6230},
["RR_EMERALDHILL"] = {3553, 3920, 4340, 4795},
["RR_AZURECITY"] = {3218, 3605, 3990, 4410},
["RR_GUSTPLANET"] = {3560, 4060, 4480, 4935},
["RR_MYSTICCAVE"] = {3981, 4410, 4865, 5355},
["RR_JOYPOLIS"] = {2967, 3640, 4025, 4445},
["RR_HIDDENPALACE"] = {4610, 5180, 5705, 6300},
["RR_HILLTOP"] = {3475, 4270, 4725, 5215},
["RR_MARBLEGARDEN"] = {4274, 5355, 5915, 6510},
["RR_SILVERCLOUDISLAND"] = {3190, 3745, 4130, 4550},
["RR_SUBZEROPEAK"] = {3623, 4620, 5110, 5635},
["RR_LAUNCHBASE"] = {4999, 5530, 6090, 6720},
["RR_AZURELAKE"] = {3060, 3395, 3745, 4130},
["RR_BALLOONPARK"] = {3509, 4550, 5005, 5530},
["RR_CHROMEGADGET"] = {2568, 3255, 3605, 3990},
["RR_DESERTPALACE"] = {2826, 3115, 3430, 3780},
["RR_ENDLESSMINE"] = {4134, 4550, 5005, 5530},
["RR_HARDBOILEDSTADIUM"] = {3211, 4480, 4935, 5460},
["RR_HARDHATHAVOC"] = {5253, 5810, 6405, 7070},
["RR_PRESSGARDEN"] = {3124, 3570, 3955, 4375},
["RR_PICOPARK"] = {3671, 4060, 4480, 4935},
["RR_CITYESCAPE"] = {3882, 4305, 4760, 5250},
["RR_PALMTREEPANIC"] = {3776, 4550, 5005, 5530},
["RR_DARKVILECASTLE2"] = {3771, 4515, 4970, 5495},
["RR_SCARLETGARDENS"] = {3507, 3885, 4305, 4760},
["RR_MOTOBUGMOTORWAY"] = {3387, 4200, 4620, 5110},
["RR_STARLIGHT"] = {3680, 4270, 4725, 5215},
["RR_METROPOLIS"] = {3352, 3710, 4095, 4515},
["RR_FROZENPRODUCTION"] = {4317, 5110, 5635, 6230},
["RR_AQUEDUCTCRYSTAL"] = {2986, 3570, 3955, 4375},
["RR_NOVASHORE"] = {3229, 4305, 4760, 5250},
["RR_HYDROCITY"] = {4241, 4865, 5355, 5915},
["RR_TRAPTOWER"] = {4567, 5145, 5670, 6265},
["RR_DIAMONDDUST"] = {4014, 5145, 5670, 6265},
["RR_BLUEMOUNTAIN1"] = {3442, 4410, 4865, 5355},
["RR_BLUEMOUNTAIN2"] = {3380, 3745, 4130, 4550},
["RR_SPEEDHIGHWAY"] = {3228, 3640, 4025, 4445},
["RR_CARNIVALNIGHT"] = {3403, 4585, 5075, 5600},
["RR_VIRTUALHIGHWAY"] = {3148, 3850, 4235, 4690},
["RR_ROUTE1980"] = {3099, 3570, 3955, 4375},
["RR_DARKFORTRESS"] = {3184, 4095, 4515, 4970},
["RR_SPRINGYARD"] = {3814, 5040, 5565, 6125},
["RR_LABYRINTH"] = {3350, 3710, 4095, 4515},
["RR_HOTSHELTER"] = {3901, 4795, 5285, 5845},
["RR_SKYSANCTUARY"] = {4012, 4865, 5355, 5915},
["RR_LOSTCOLONY"] = {4498, 5390, 5950, 6545},
["RR_DEATHEGG"] = {9726, 10710, 11795, 12985},
["RR_765STADIUM"] = {2971, 3290, 3640, 4025},
["RR_SKYSCRAPERLEAPS"] = {3718, 4760, 5250, 5775},
["RR_GREENTRIANGLE"] = {3418, 3815, 4200, 4620},
["RR_ZONEDCITY"] = {3888, 4655, 5145, 5670},
["RR_SUNSETHILL"] = {3832, 4235, 4690, 5180},
["RR_SAVANNAHCITADEL"] = {3620, 4130, 4550, 5005},
["RR_UMBRELLARUSHWINDS"] = {3270, 4165, 4585, 5075},
["RR_AVANTGARDEN"] = {4823, 5320, 5880, 6475},
["RR_BIGTIMEBREAKDOWN"] = {4880, 5390, 5950, 6545},
["RR_VANTABLACKVIOLET"] = {3352, 4130, 4550, 5005},
["RR_CHAOSTUBE"] = {4371, 5775, 6370, 7035},
["RR_DIMENSIONDISASTER"] = {4764, 5250, 5775, 6370},
["RR_AURORAATOLL"] = {3185, 3535, 3920, 4340},
["RR_DAYTONASPEEDWAY"] = {3683, 4235, 4690, 5180},
["RR_TURQUOISEHILL"] = {4181, 5320, 5880, 6475},
["RR_WEISSWATERWAY"] = {3265, 4375, 4830, 5320},
["RR_ICEPARADISE"] = {3990, 4970, 5495, 6055},
["RR_SUNSPLASHEDGETAWAY"] = {3419, 3780, 4165, 4585},
["RR_FAEFALLS"] = {3227, 3570, 3955, 4375},
["RR_AZUREAXIOM"] = {3576, 4060, 4480, 4935},
["RR_HANAGUMIHALL"] = {3108, 4270, 4725, 5215},
["RR_CRISPYCANYON"] = {4159, 4725, 5215, 5740},
["RR_AERIALHIGHLANDS"] = {4290, 4970, 5495, 6055},
["RR_TECHNOLOGYTUNDRA"] = {3839, 4795, 5285, 5845},
["RR_OPERATORSOVERSPACE"] = {5527, 6405, 7070, 7805},
["RR_MEGAGREENHILL"] = {3918, 4340, 4795, 5285},
["RR_MEGABRIDGE"] = {2879, 3955, 4375, 4830},
["RR_MEGALAVAREEF"] = {3257, 4060, 4480, 4935},
["RR_MEGAICECAP"] = {3160, 4130, 4550, 5005},
["RR_MEGASCRAPBRAIN"] = {3049, 3360, 3710, 4095},
["RR_CLOUDTOPDIMENSION"] = {3008, 3745, 4130, 4550},
["RR_NIGHTFALLDIMENSION"] = {3374, 3990, 4410, 4865},
["RR_WAVECRASHDIMENSION"] = {3628, 4410, 4865, 5355},
["RR_VOIDDANCEDIMENSION"] = {2963, 3430, 3780, 4165},
["RR_GRAVTECHDIMENSION"] = {4551, 5040, 5565, 6125},
["RR_ESPRESSOLANE"] = {2912, 3220, 3570, 3955},
["RR_MELTYMANOR"] = {2941, 3395, 3745, 4130},
["RR_LEAFSTORM"] = {4371, 4830, 5320, 5880},
["RR_LAKEMARGORITE"] = {3336, 4340, 4795, 5285},
["RR_ENDLESSMINE2"] = {3866, 4480, 4935, 5460},
["RR_CYANBELLTOWER"] = {4156, 5355, 5915, 6510},
["RR_QUARTZQUADRANT"] = {3534, 4025, 4445, 4900},
["RR_AQUATUNNEL"] = {3870, 4585, 5075, 5600},
["RR_WATERPALACE"] = {3827, 4235, 4690, 5180},
["RR_FINALFALL"] = {3061, 3955, 4375, 4830},
["RR_HAUNTEDSHIP"] = {3896, 4305, 4760, 5250},
["RR_ROBOTNIKWINTER"] = {3997, 4410, 4865, 5355},
["RR_DRAGONSPIRESEWER1"] = {3597, 3990, 4410, 4865},
["RR_ABYSSGARDEN"] = {3355, 3850, 4235, 4690},
["RR_BLIZZARDPEAKS"] = {4113, 4725, 5215, 5740},
["RR_VERMILLIONVESSEL"] = {3724, 4305, 4760, 5250},
["RR_DRAGONSPIRESEWER2"] = {4267, 4830, 5320, 5880},
["RR_CHEMICALFACILITY"] = {4477, 5705, 6300, 6930},
["RR_COASTALTEMPLE"] = {3902, 5390, 5950, 6545},
["RR_MONKEYMALL"] = {4192, 4655, 5145, 5670},
["RR_RAMPPARK"] = {3374, 4095, 4515, 4970},
["RR_ADVENTANGEL"] = {3454, 4235, 4690, 5180},
["RR_PESTILENCE"] = {3923, 4410, 4865, 5355},
["RR_CRIMSONCORE"] = {4286, 5355, 5915, 6510},
["RR_LASVEGAS"] = {3310, 3745, 4130, 4550},
["RR_MEGACOLLISIONCHAOS"] = {2983, 4025, 4445, 4900},
["RR_MEGASTARLIGHT"] = {2747, 3080, 3395, 3745},
["RR_MEGASANDOPOLIS"] = {2924, 3535, 3920, 4340},
["RR_MEGAAQUALAKE"] = {3630, 4655, 5145, 5670},
["RR_MEGAFLYINGBATTERY"] = {2966, 3395, 3745, 4130},
["RR_SKYBABYLON"] = {4089, 4515, 4970, 5495},
["RR_KODACHROMEVOID"] = {3474, 4445, 4900, 5390},
["RR_LAVENDERSHRINE"] = {3442, 3815, 4200, 4620},
["RR_HOTCRATER"] = {3895, 4340, 4795, 5285},
["RR_THUNDERPISTON"] = {3780, 5250, 5775, 6370},
["RR_SRB2FROZENNIGHT"] = {3148, 3955, 4375, 4830},
["RR_BARRENBADLANDS"] = {3322, 4095, 4515, 4970},
["RR_SHUFFLESQUARE"] = {3261, 3605, 3990, 4410},
["RR_BLUEMOUNTAINCLASSIC"] = {3079, 3605, 3990, 4410},
["RR_ANGELARROWCLASSIC"] = {3259, 3885, 4305, 4760},
["RR_CADILLACCANYONCLASSIC"] = {3601, 4375, 4830, 5320},
["RR_DIAMONDDUSTCLASSIC"] = {2828, 3605, 3990, 4410},
["RR_BLIZZARDPEAKSCLASSIC"] = {3815, 4480, 4935, 5460},
["RR_LAUNCHBASECLASSIC"] = {2835, 3430, 3780, 4165},
["RR_LAVENDERSHRINECLASSIC"] = {2967, 3920, 4340, 4795},
["RR_DUELBUSTER"] = {604, 665, 735, 840},
["RR_MUNICIPALMEADOW"] = {446, 595, 665, 735},
["RR_CDSPECIALSTAGE1"] = {287, 455, 525, 595},
["RR_TINKERERSARENA"] = {1127, 1365, 1505, 1680},
["RR_TRICIRCLEMARINA"] = {264, 770, 875, 980},
["RR_MYSTERYGATE"] = {257, 630, 700, 770},
["RR_RUSTYRIG"] = {460, 980, 1085, 1225},
["RR_MARBLEFOYER"] = {321, 1435, 1610, 1785},
["RR_ROCKWORLD"] = {585, 1015, 1120, 1260},
["RR_WORLD1MAP"] = {327, 1050, 1155, 1295},
["RR_CDSPECIALSTAGE8"] = {1178, 1330, 1470, 1645},
["RR_SEGASATURN"] = {417, 910, 1015, 1120},
["RR_ELECTRACLACKER"] = {505, 840, 945, 1050},
["RR_THUNDERTOP"] = {329, 770, 875, 980},
["RR_TREERING"] = {902, 1855, 2065, 2275},
["RR_FRIGIDCOVE"] = {2338, 4025, 4445, 4900},
["RR_GIZMOBASTION"] = {821, 1610, 1785, 1995},
["RR_CARBONCRUCIBLE"] = {384, 1645, 1820, 2030},
["RR_SECURITYHALL"] = {1138, 1925, 2135, 2380},
["RR_GEMSMUSEUM"] = {603, 1050, 1155, 1295},
["RR_MEDIASTUDIO"] = {1190, 3010, 3325, 3675},
["RR_HONEYCOMBHOLLOW"] = {1313, 1960, 2170, 2415},
["RR_WOOD"] = {1788, 2520, 2800, 3080},
["RR_BRAWLFORT"] = {700, 1260, 1400, 1540},
["RR_CRYSTALISLAND"] = {630, 1295, 1435, 1610},
["RR_CYBERARENA"] = {539, 1225, 1365, 1505},
["RR_NEONRESORT"] = {663, 2380, 2625, 2905},
["RR_METEORHERD"] = {1125, 2520, 2800, 3080},
["RR_DEATHEGGSEYE"] = {754, 1925, 2135, 2380},
["RR_TAILSLAB"] = {273, 560, 630, 700},
["RR_POWERPLANT"] = {767, 1190, 1330, 1470},
["RR_CITYSKYLINE"] = {1244, 1855, 2065, 2275},
["RR_VANTABLACKATRIUM"] = {511, 595, 665, 735},
["RR_DEADSIMPLE"] = {287, 665, 735, 840},
["RR_MARTIANMATRIX"] = {390, 770, 875, 980},
["RR_DARKCHAOGARDEN"] = {670, 980, 1085, 1225},
["RR_HEROCHAOGARDEN"] = {782, 1820, 2030, 2240},
["RR_WHIRLWATERS"] = {368, 1260, 1400, 1540},
["RR_DELUGEDMETROPLEX"] = {679, 1120, 1260, 1400},
["RR_MEGAEMERALDBEACH"] = {497, 560, 630, 700},
["RR_MEGALABYRINTH"] = {778, 875, 980, 1085},
["RR_FUNGALDIMENSION"] = {2289, 2730, 3010, 3325},
["RR_ASTRALDIMENSION"] = {2146, 2415, 2660, 2940},
["RR_CHAOSSERAPH"] = {801, 1960, 2170, 2415},
["RR_TOYKINGDOM"] = {1243, 1890, 2100, 2310},
["RR_AQUATICCATHEDRAL1"] = {708, 945, 1050, 1155},
["RR_AQUATICCATHEDRAL2"] = {869, 1155, 1295, 1435},
["RR_FROSTYCOURTYARD"] = {776, 2135, 2380, 2625},
["RR_ABYSSGATE"] = {1337, 2765, 3045, 3360},
["RR_SONICSSCHOOLHOUSE"] = {885, 1190, 1330, 1470},
["RR_RECORDATTACK"] = {810, 910, 1015, 1120},
["RR_PEANUTPALACE"] = {376, 560, 630, 700},
["RR_HYDROPLANT"] = {3458, 5285, 5845, 6440},
["RR_MEGAMETROPOLIS"] = {474, 875, 980, 1085},
["RR_MEGAMARBLE"] = {308, 805, 910, 1015},
["RR_THUNDERLAB"] = {872, 1400, 1540, 1715},
["RR_MALIGNEGGSHRINE"] = {703, 910, 1015, 1120},
["RR_SRB2MEADOWMATCH"] = {781, 1120, 1260, 1400},
["RR_ARMOREDARMADILLO"] = {1681, 2135, 2380, 2625},
["RR_CLUCKYFARMS"] = {571, 700, 770, 875},
["RR_DRIEDBATTLEDUNE"] = {920, 1015, 1120, 1260},
["RR_SEALEDSTARBALCONIES"] = {1, 2, 3, 4},
["RR_SEALEDSTARCHURCH"] = {1, 2, 3, 4},
["RR_SEALEDSTARCOURTYARD"] = {1, 2, 3, 4},
["RR_SEALEDSTARVILLA"] = {1, 2, 3, 4},
["RR_SEALEDSTARVENICE"] = {1, 2, 3, 4},
["RR_SEALEDSTARSPIKES"] = {1, 2, 3, 4},
["RR_SEALEDSTARFOUNTAIN"] = {1, 2, 3, 4},
["RR_SEALEDSTARGALLERY"] = {1, 2, 3, 4},
["RR_SEALEDSTARALLEY"] = {1, 2, 3, 4},
["RR_SEALEDSTARSTEEPLE"] = {1, 2, 3, 4},
["RR_SEALEDSTARROOFTOPS"] = {1, 2, 3, 4},
["RR_SEALEDSTARROULETTE"] = {1, 2, 3, 4},
["RR_SEALEDSTARTOWERS"] = {1, 2, 3, 4},
["RR_SEALEDSTARATLANTIS"] = {1, 2, 3, 4},
["RR_ADVENTUREEXAMPLE"] = {1, 2, 3, 4},
["RR_SUNBEAMPARADISEPLAYGROUND"] = {1, 2, 3, 4},
["RR_SUNBEAMPARADISECONTROLS"] = {1, 2, 3, 4},
["RR_SUNBEAMPARADISERINGS"] = {1, 2, 3, 4},
["RR_SUNBEAMPARADISEBRAKES"] = {1, 2, 3, 4},
["RR_SUNBEAMPARADISEDRIFTING"] = {1, 2, 3, 4},
["RR_SUNBEAMPARADISEITEMS"] = {1, 2, 3, 4},
["RR_SUNBEAMPARADISESPRINGS"] = {1, 2, 3, 4},
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
	elseif (basetime > 180) and (string.upper(G_BuildMapName(map)) != "RR_TESTRUN") and (string.upper(G_BuildMapName(map)) != "RR_SUNBEAMPARADISEPLAYGROUND") and (not mapheaderinfo[map].arcadeboss) then //Test Run and Egg Carrier, as well as boss maps, can have a lot of time
		basetime = 180
	elseif (basetime%5) ~= 0 then
		basetime = $ + 5 - ($%5)
	end
	
	local bonustime = tonumber(mapheaderinfo[map].arcadebonus)
	if bonustime == nil then
		bonustime = DTRBASELAPBONUS
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
	
	local checkpointtime = tonumber(mapheaderinfo[map].arcadecheckbonus)
	if checkpointtime == nil then
		checkpointtime = DTRBASECHECKBONUS
	elseif (mapheaderinfo[map].arcadeboss) or (checkpointtime == 0) then
		checkpointtime = 0
	elseif checkpointtime < 5 then
		checkpointtime = 5
	elseif checkpointtime > 30 then
		checkpointtime = 30
	elseif (checkpointtime%5) ~= 0 then
		checkpointtime = $ + 5 - ($%5)
	end
	if checkpointtime > basetime then checkpointtime = basetime end
	
	local numcheckpoints = tonumber(mapheaderinfo[map].arcadecheckpoints)
	if (numcheckpoints == nil) or (numcheckpoints == 0) then
		numcheckpoints = mapheaderinfo[map].numlaps - 1
		checkpointtime = 0
	end
	
	DTRNewTimes[string.upper(G_BuildMapName(map))] = {basetime, bonustime, checkpointtime, numcheckpoints}
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
	return soc[1], soc[2]
end)

rawset(_G, "GetDTRNewTimes", function(map)
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
	soc = DTRNewTimes[string.upper(G_BuildMapName(map))]
	if not soc then soc = {300, 0, 0, 0} end
	return soc[1], soc[2], soc[3], soc[4]
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

rawset(_G, "setnewmaptime", function(p, map, base, lapbonus, checkbonus, checkpoints, override)
	local newbase = tonumber(base)
	local newbonus = tonumber(lapbonus)
	local newcheckbonus = tonumber(checkbonus)
	local checks = tonumber(checkpoints)
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
		if newbonus > 0 then
			newbonus = min(90,max(10,$))
		end
		if newcheckbonus > 0 then
			newcheckbonus = min(30,max(5,$))
		end
	end
	if newbonus%5 > 0 then
		newbonus = $ + 5 - ($%5)
	end
	if (not checks) or (checks == 0) then
		checks = mapheaderinfo[tonumber(map)].numlaps - 1
		newcheckbonus = 0
	end
	
	if setmaps[string.upper(G_BuildMapName(tonumber(map)))] and not override then
		CONS_Printf(p,"This map already has a time limit set!")
		return
	else
		if override and setmaps[string.upper(G_BuildMapName(tonumber(map)))] then CONS_Printf(p,"Overriding times for Map "..G_BuildMapName(tonumber(map)).."...") end
		DTRNewTimes[string.upper(G_BuildMapName(map))] = {basetime, bonustime, checkpointtime, checks}
		setmaps[string.upper(G_BuildMapName(tonumber(map)))] = true
		CONS_Printf(p,"Map times for Map "..string.upper(G_BuildMapName(tonumber(map))).." are set!")
		CONS_Printf(p, DTRNewTimes[string.upper(G_BuildMapName(tonumber(map)))][1].."s start, "..DTRNewTimes[string.upper(G_BuildMapName(tonumber(map)))][2].."s bonus per lap, "..DTRNewTimes[string.upper(G_BuildMapName(tonumber(map)))][3].."s bonus per CP")
	end
end)

COM_AddCommand("setmaptime", function(p, map, base, lapbonus, checkbonus, checkpoints, override)
	setnewmaptime(p, map, base, lapbonus, checkbonus, checkpoints, override)
end, 1)

COM_AddCommand("checkmaptime", function(p, map)
	if setmaps[string.upper(map)] then
		CONS_Printf(p, DTRNewTimes[string.upper(map)][1].."s start, "..DTRNewTimes[string.upper(map)][2].."s bonus per lap, "..DTRNewTimes[string.upper(map)][2].."s bonus per CP for map "..string.upper(map))
	elseif not tonumber(map) then
		CONS_Printf(p, "Missing map number!")
	elseif not mapheaderinfo[tonumber(map)] then
		CONS_Printf(p,"Map "..map.." doesn't currently exist!")
	elseif setmaps[string.upper(G_BuildMapName(tonumber(map)))] then
		CONS_Printf(p, DTRNewTimes[string.upper(G_BuildMapName(tonumber(map)))][1].."s start, "..DTRNewTimes[string.upper(G_BuildMapName(tonumber(map)))][2].."s bonus per lap, "..DTRNewTimes[string.upper(G_BuildMapName(tonumber(map)))][3].."s bonus per CP for map "..map)
	else
		CONS_Printf(p, "This map doesn't have a time set yet!")
	end
end)