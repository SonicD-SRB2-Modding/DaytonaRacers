/*
Hud code for Daytona Racers
*/

local MILESPERHOUR = 1
local KILOMETERSPERHOUR = 2
local NAUTICALMILESPERHOUR = 3
local METERSPERSECOND = 4
local FOOTPERSECOND = 5
local FRACUNITSPERTIC = 6
local PERCENTAGESPEED = 7

local REDTEXT = 1
local GREENTEXT = 2
local YELLOWTEXT = 3
local BLUETEXT = 4

local customspeedometer = CV_RegisterVar({"arcade_speed", "Miles", CV_SHOWMODIF, {Miles=MILESPERHOUR, Kilometers=KILOMETERSPERHOUR, Meters=METERSPERSECOND, Fracunits=FRACUNITSPERTIC, Knots=NAUTICALMILESPERHOUR, Feet=FOOTPERSECOND, Percent=PERCENTAGESPEED}})


//The base Max Speed for all 9 base speed types (Needs to be updated)
local basemaxspeed = setmetatable({
	2519263, //Speed 1
	2568660, //Speed 2
	2618057, //Speed 3
	2667455, //Speed 4
	2716852, //Speed 5
	2766249, //Speed 6
	2815647, //Speed 7
	2865044, //Speed 8
	2914441  //Speed 9
}, {__index = function() return 2716852 end})

//The Max RPM (outside of boosting) for all 9 base weight types. Can be adjusted
local baseRPM = setmetatable({
	7000, //Weight 1
	7125, //Weight 2
	7250, //Weight 3
	7375, //Weight 4
	7500, //Weight 5
	7625, //Weight 6
	7750, //Weight 7
	7875, //Weight 8
	8000, //Weight 9
}, {__index = function() return 7500 end})

local flash = {
	[0]	= 655360, //Fully transparent
	[1] = V_90TRANS,
	[2] = V_80TRANS,
	[3] = V_70TRANS,
	[4] = V_60TRANS,
	[5] = V_50TRANS,
	[6] = V_40TRANS,
	[7] = V_30TRANS,
	[8] = V_20TRANS,
	[9] = V_10TRANS,
	[10] = 0 //Fully opaque
}

local FONTSTRINGOFFSET =  setmetatable({
	["LRMXG"] = -2,
	["LRMXY"] = -2,
	["LRMXR"] = -2,
	["LRMT"] = -1
}, {__index = function() return 0 end})

local SEALEDSTARTIMES = {
	 [0] = 47,
	 [1] = 75, //I
	 [2] = 23, //II
	 [3] = 20,
	 [4] = 62,
	 [5] = 52, //III
	 [6] = 22,
	 [7] = 89, //I
	 [8] = 48, //I
	 [9] = 27,
	[10] = 18,
	[11] = 51, //I
	[12] = 77,
	[13] = 16,
	[14] = 30,
	[15] = 24, //I
	[16] = 39, //I
	[17] = 53, //I
	[18] = 41, //I
	[19] = 29,
	[20] = 86,
	[21] = 70,
	[22] = 99,
	[23] = 96,
	[24] = 26, //I
	[25] = 43,
	[26] = 55,
	[27] = 80,
	[28] = 32,
	[29] = 98,
	[30] = 73,
	[31] = 28, //I
	[32] = 64,
	[33] = 92,
	[34] = 56
}

local ufo = nil

local function padTimerZero(num)
	if num < 10
		return "0" .. tostring(num)
	else
		return tostring(num)
	end
end

local function getLetterAsciiCode(char)
	local asc = string.byte(char)
	local padding = "000"
	if asc > 99
		padding = ""
	elseif asc > 9
		padding = "0"
	elseif asc > 0
		padding = "00"
	end
	return padding .. asc
end

local function drawNewString(v, font, str, x, y, f, c, style)
	if str == nil
	or string.len(str) == 0
		str = "NIL"
	end
	local strPatches = {}
	local strLenPix = 0
	for a=1,string.len(str) do
		local letter = string.sub(str, a, a)
		if letter == "∞" then
			strPatches[a] = v.cachePatch(font .. "INF")
			strLenPix = $ + strPatches[a].width
			if FONTSTRINGOFFSET[font] then strLenPix = $ + FONTSTRINGOFFSET[font] end
		elseif letter != " " then
			strPatches[a] = v.cachePatch(font .. getLetterAsciiCode(letter))
			strLenPix = $ + strPatches[a].width
			if FONTSTRINGOFFSET[font] then strLenPix = $ + FONTSTRINGOFFSET[font] end
		else
			strLenPix = $ + 6
		end
	end
	local lx = x
	if style == "right" then
		lx = x - (strLenPix - FONTSTRINGOFFSET[font])
	elseif style == "center" then
		lx = x - ((strLenPix - FONTSTRINGOFFSET[font]) / 2)
	end
	for a=1,string.len(str) do
		if strPatches[a] then
			v.draw(lx, y, strPatches[a], f, c)
			lx = $ + strPatches[a].width
			if FONTSTRINGOFFSET[font] then lx = $ + FONTSTRINGOFFSET[font] end
		else
			lx = $ + 6
		end
	end
end

local function drawInfinity(v, font, x, y, f, c, style)
	local strPatches = {}
	local strLenPix = 0
	strPatches[1] = v.cachePatch(font .. "INF")
	strLenPix = $ + strPatches[1].width
	if FONTSTRINGOFFSET[font] then strLenPix = $ + FONTSTRINGOFFSET[font] end
	local lx = x
	if style == "right" then
		lx = x - (strLenPix - FONTSTRINGOFFSET[font])
	elseif style == "center" then
		lx = x - ((strLenPix - FONTSTRINGOFFSET[font]) / 2)
	end
	v.draw(lx, y, strPatches[1], f, c)
end

local function drawLRMAXNum(v, time, x, y, f, colflag, tics, pos)
	local str
	local font = "LRMXG"
	if colflag == REDTEXT then font = "LRMXR"
	elseif colflag == YELLOWTEXT then font = "LRMXY"
	elseif colflag == BLUETEXT then font = "LRMXB" end
	if time == -1 then
		str = "∞"
	elseif tics then
		local secs = time / 35
		if secs < 10 then
			local ds = G_TicsToCentiseconds(time) / 10
			str = tostring(secs) .. "." .. tostring(ds)
		else
			str = tostring(secs)
		end
	else
		str = tostring(time)
	end
	drawNewString(v, font, str, x, y, f, nil, pos)
end

local function drawLRMAXTimer(v, x, y, time, flags, positioncountdown, overtime, p)
	if positioncountdown and (not (gametype & GT_TUTORIAL)) then
		if (gametype & GT_BATTLE) or (gametype & GT_VERSUS) then
			drawNewString(v, "LRMT", "GET READY!", x, y+4, flags, nil, "center")
		elseif modeattacking then
			drawNewString(v, "LRMT", "START THE RUSH!", x, y+4, flags, nil, "center")
		else
			drawNewString(v, "LRMT", "POSITION!", x, y+4, flags, nil, "center")
		end
	elseif overtime then
		drawNewString(v, "LRMT", "OVERTIME!", x, y+4, flags, nil, "center")
	elseif (gametype & GT_SPECIAL) then //Timer spits out an error code
		if ufo and ufo.valid and ufo.health > 0 then
			drawNewString(v, "LRMT", "522 ERROR:", x, y, flags, nil, "center")
			drawNewString(v, "LRMT", "SYNC FAILURE", x, y+7, flags, nil, "center")
		elseif not p.exiting then
			drawNewString(v, "LRMT", "RESYNC IN", x, y, flags, nil, "center")
			drawNewString(v, "LRMT", "PROGRESS...", x, y+7, flags, nil, "center")
		else
			local specflags = flags & (~V_HUDTRANS)
			drawNewString(v, "LRMT", "HVR SYNC", x, y, specflags, nil, "center")
			drawNewString(v, "LRMT", "RESTORED!", x, y+7, specflags, nil, "center")
		end
	else
		drawNewString(v, "LRMT", "TIME", x, y, flags, nil, "center")
		drawNewString(v, "LRMT", "LIMIT", x, y+7, flags, nil, "center")
	end
	local colflag = GREENTEXT
	if positioncountdown then
		colflag = BLUETEXT
	elseif (gametype & GT_SPECIAL) then
		colflag = YELLOWTEXT
	elseif time <= 30*TICRATE then
		if time < 10*TICRATE then
			if (time % 10) <= 4 then colflag = REDTEXT end
		else
			if (time % TICRATE) <= (TICRATE / 2) then colflag = YELLOWTEXT end
		end
	end
	if (time == -1) or (gametype & GT_TUTORIAL) then
		drawInfinity(v, "LRMXG", x, y+15, flags, nil, "center")
	else
		drawLRMAXNum(v, abs(time), x, y+15, flags, colflag, true, "center")
	end
end

local function drawLRMAXLaps(v, p, n, map, flags, flash)
	if not (p and p.valid) then return end
	if (gametype & GT_BATTLE) or (gametype & GT_SPECIAL) or (gametype & GT_VERSUS) or (gametype & GT_TUTORIAL) then return end
	local currentlap
	local lapstring = "LAP"
	local sectorstring
	local maxlaps
	local maxsectors
	local col = GREENTEXT
	if mapheaderinfo[gamemap].levelflags & LF_SECTIONRACE then
		lapstring = "LEG"
		currentlap = p.laps
		if p.laps >= numlaps then currentlap = numlaps end
		if (p.laps + 1) > numlaps then col = YELLOWTEXT end
		maxlaps = numlaps 
	elseif (tonumber(mapheaderinfo[map].lapspersection) ~= nil) and (tonumber(mapheaderinfo[map].lapspersection) > 1) then
		currentlap = ((p.laps - 1) / tonumber(mapheaderinfo[map].lapspersection)) + 1
		if (p.laps + tonumber(mapheaderinfo[map].lapspersection)) > numlaps then col = YELLOWTEXT end
		maxlaps = numlaps / tonumber(mapheaderinfo[map].lapspersection)
		maxsectors = tonumber(mapheaderinfo[map].lapspersection)
		sectorstring = "Section " .. (max(p.laps - 1, 0) % tonumber(mapheaderinfo[map].lapspersection) + 1) .. " of " .. maxsectors
		if p.laps > numlaps then 
			currentlap = maxlaps
			sectorstring = "Section " .. maxsectors .. " of " .. maxsectors
		end
	else
		currentlap = p.laps
		if p.laps >= numlaps then currentlap = numlaps end
		if (p.laps + 1) > numlaps then col = YELLOWTEXT end
		maxlaps = numlaps 
	end
	if flash then 
		if col ~= YELLOWTEXT then col = YELLOWTEXT else col = GREENTEXT end
	end
	local y = 8
	local x = 312
	drawNewString(v, "LRMT", lapstring, 272, 19, flags, nil, "right")
	drawLRMAXNum(v, padTimerZero(currentlap), x, y, flags, col, false, "right")
	drawNewString(v, "LRMT", "OF "..padTimerZero(maxlaps), x, 29, flags, nil, "right")
	if (tonumber(mapheaderinfo[map].lapspersection) ~= nil) and (tonumber(mapheaderinfo[map].lapspersection) > 1) then
		v.drawString(316, 37, sectorstring, flags, "small-right")
	end
end

local function drawLRMAXEmeralds(v, p, flags, x, y)
	x = $ or 240
	y = $ or 5
	
	local em = p.emeralds
	local barcol = v.getColormap(0, SKINCOLOR_NONE)
	
	--Draw the base bar
	v.draw(x, y, v.cachePatch("DUHB_0"), flags, barcol)
	--Draw each emerald in the bar
	local i = em
	local t = 0
	local eno = 0
	while i > 0 do
		if (i % 2) == 1 then
			t = $ + 1
			barcol = v.getColormap(0, SKINCOLOR_CHAOSEMERALD1 + eno)
			v.draw(x, y, v.cachePatch("DUHB_" .. t), flags, barcol)
		end
		i = $ / 2
		eno = $ + 1
	end
	
	local healthbartextcol = V_GRAYMAP    
	if t == 7 then
		healthbartextcol = V_GOLDMAP
	elseif t == 6 then
		healthbartextcol = V_AQUAMAP
	elseif t > 0 then
		healthbartextcol = V_GREENMAP
	end
	
	v.drawString(x, y, t .. " EMERALD" .. ((t != 1 and "S") or ""), flags|bartextcol, "center")
end

local function drawLRMAXUfoHealth(v, flags, x, y, p)
	--Get the position of our health bar
	x = $ or 240
	y = $ or 5
	
	local healthunits = 100
	local health = 0
	local hpcol = SKINCOLOR_RED
	if (ufo) and (ufo.valid) then
		healthunits = ufo.info.spawnhealth - 1
		health = ufo.health - 1
		if healtn == 0 then hpcol = SKINCOLOR_GOLD end
	else
		hpcol = SKINCOLOR_PLATINUM
	end
	
	local hppatch =  v.cachePatch("DUHT_HP")
	local healthbarcol = v.getColormap(0, hpcol)
	local hpstep = min(FixedInt(FixedDiv(health*100, healthunits)), 100)
	
	--Now split the steps into 10s and units
	local basebar = hpstep / 10
	local basebarpen = hpstep % 10
	local penflags = flags & (V_SNAPTOTOP|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_SNAPTORIGHT)
	
	--Now draw the health bar
	v.draw(x, y, v.cachePatch("DUHB_" .. basebar), flags, healthbarcol)
	if (basebarpen > 0) and (not p.exiting) then
		v.draw(x, y, v.cachePatch("DUHF_" .. basebar + 1), penflags|flash[basebarpen], healthbarcol)
	end
	
	--Finally, draw the HP string
	v.draw(x, y, hppatch, flags, healthbarcol)
end

local function drawLRMAXRings(v, p, flags, x, y)
	if not (p and p.valid) then return end
	--Get the position of our health bar
	x = $ or 160
	y = $ or 195
	local textx = x
	local texty = y - 21
	
	local hpunits = 20 //Max HP/Rings
	local health = 0 //Current HP/Rings
	local hpstep //Percentage of HP/Rings
	local hppatch //Patch (if any) for the bar to show
	local hptext = 0 //Value to show
	local hpcol = SKINCOLOR_YELLOW
	local showaddreminder = false
	
	if (gametype & GT_BATTLE) then //Battle Game modes - value will be Bumpers left, bar shows Sphere charge
		if p.mo and p.mo.valid then
			hptext = p.mo.health - 1
		else
			hptext = 0
		end
		hpunits = 40
		health = p.spheres
		hpcol = SKINCOLOR_BLUE
		hppatch = v.cachePatch("DHPT_BP")
	elseif (gametype & GT_SPECIAL) then //Special Stage
		hptext = p.rings
		health = abs(p.rings)
		hppatch = v.cachePatch("DHPT_RG")
		if p.rings < 0 then hpcol = SKINCOLOR_RED end
		
	elseif (gametype & GT_VERSUS) then //Boss fight - bar shows how much HP you have left
		if p.mo and p.mo.valid then
			hptext = p.mo.health
		else
			hptext = 0
		end
		hpunits = 3
		health = hptext
		hpcol = SKINCOLOR_GREEN
		hppatch = v.cachePatch("DHPT_HP")
	else //Race or Tutorial - bar and value shows how many Rings you have
		hptext = p.rings
		health = abs(p.rings)
		hppatch = v.cachePatch("DHPT_RG")
		
		if not (gametype & GT_TUTORIAL) then showaddreminder = true end
		
		if p.rings < 0 then hpcol = SKINCOLOR_RED 
		elseif daytonaracers and (daytonaracers.ringtimer > p.rings) and (p.realtime % 10 < 5) and not (gametype & GT_TUTORIAL) and (not modeattacking) then hpcol = SKINCOLOR_ORANGE end
	end
	
	hpstep = min(FixedInt(FixedDiv(health*100, hpunits)), 100)
	
	local healthbarcol
	local healthbartextcol
	
	if (gametype & GT_BATTLE) then
		if health > 26 then
			healthbarcol = v.getColormap(0, SKINCOLOR_MIDNIGHT)
		elseif health > 13 then
			healthbarcol = v.getColormap(0, SKINCOLOR_NAVY)
		else
			healthbarcol = v.getColormap(0, SKINCOLOR_BLUE)
		end
		if hptext > 1 then
			healthbartextcol = V_GREENMAP
		elseif hptext == 1 then
			healthbartextcol = V_YELLOWMAP
		else
			healthbartextcol = ((p.realtime % 10 < 5) or (hptext == 0)) and V_REDMAP or V_YELLOWMAP
		end
	elseif (gametype & GT_SPECIAL) then
		if hptext > 0 then
			if daytonaracers and (daytonaracers.ringtimer > p.rings) and (p.realtime % 10 < 5) then healthbartextcol = V_ORANGEMAP
			else healthbartextcol = V_YELLOWMAP end
		else
			healthbartextcol = ((p.realtime % 10 < 5) or (hptext == -20)) and V_REDMAP or V_YELLOWMAP
		end
		healthbarcol = v.getColormap(0, hpcol)
	elseif (gametype & GT_VERSUS) then
		if health > 2 then
			healthbartextcol = V_GREENMAP
			healthbarcol = v.getColormap(0, hpcol)
		elseif health == 2 then
			healthbartextcol = V_YELLOWMAP
			healthbarcol = v.getColormap(0, SKINCOLOR_YELLOW)
		else
			healthbartextcol = ((p.realtime % 10 < 5) or (hptext == 0)) and V_REDMAP or V_YELLOWMAP
			healthbarcol = v.getColormap(0, SKINCOLOR_CRIMSON)
		end
	else
		if hptext > 0 then
			healthbartextcol = V_YELLOWMAP
		else
			healthbartextcol = ((p.realtime % 10 < 5) or (hptext == -20)) and V_REDMAP or V_YELLOWMAP
		end
		healthbarcol = v.getColormap(0, hpcol)
	end
	
	--Now split the steps into 10s and units
	local basebar = hpstep / 10
	local basebarpen = hpstep % 10
	local penflags = flags & (V_SNAPTOTOP|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_SNAPTORIGHT)
	
	--Now draw the health bar
	v.draw(x, y, v.cachePatch("DHPB_" .. basebar), flags, healthbarcol)
	if (basebarpen > 0) and (not p.exiting) then
		v.draw(x, y, v.cachePatch("DHPF_" .. basebar + 1), penflags|flash[basebarpen], healthbarcol)
	end
	
	--Finally, draw the HP/BP/Ring string, plus a value of the current health inside the bar
	v.draw(x, y, hppatch, flags, healthbarcol)
	v.drawString(textx, texty, hptext, flags|healthbartextcol, "center")
	
	if showaddreminder and daytonaracers and (daytonaracers.ringtimer <= p.rings) and (p.realtime % 20 < 10) and (not modeattacking) then
		v.drawString(textx + 60, texty + 12, "CUSTOM 1: +1S", V_SNAPTOBOTTOM|V_HUDTRANSHALF|V_YELLOWMAP, "center")
	end
end

local function convertspeed(speed, speedtype, p, mobjscale)
	local convertedspeed
	local fractionspeed
	local typetext
	local result
	if speedtype == MILESPERHOUR then
		typetext = "MPH"
		convertedspeed = FixedDiv(FixedMul(speed, 88465), mobjscale)/(FRACUNIT)
	elseif speedtype == KILOMETERSPERHOUR then
		typetext = "KM/H"
		convertedspeed = FixedDiv(FixedMul(speed, 142371), mobjscale)/(FRACUNIT)
	elseif speedtype == METERSPERSECOND then
		typetext = "M/S"
		convertedspeed = FixedDiv(FixedMul(speed, 39547), mobjscale)/(FRACUNIT)
	elseif speedtype == FRACUNITSPERTIC then
		typetext = "FU/T"
		convertedspeed = FixedDiv(speed, mobjscale)/(FRACUNIT)
	elseif speedtype == NAUTICALMILESPERHOUR then
		typetext = "KNOT"
		convertedspeed = FixedDiv(FixedMul(speed, 76874), mobjscale)/(FRACUNIT)
	elseif speedtype == FOOTPERSECOND then
		typetext = "FT/S"
		convertedspeed = FixedDiv(FixedMul(speed, 129747), mobjscale)/(FRACUNIT)
	elseif speedtype == PERCENTAGESPEED then //Need to sort this out to make sure it shows an accurate percentage, with 100% being the base max speed
		typetext = "%"
		convertedspeed = FixedDiv(speed * 100, basemaxspeed[p.kartspeed])/(FRACUNIT)
	end
	return convertedspeed, typetext
end

local function drawBattleManiaSpeed(v, p, flags, x, y, maxHud)
	if not (p and p.valid) then return end
	if p.speed == nil or p.kartweight == nil or p.kartspeed == nil then return end
	local rpm = 1000 + FixedDiv(FixedMul(FixedDiv(p.speed, mapheaderinfo[gamemap].mobj_scale), (baseRPM[p.kartweight] - 1000)), basemaxspeed[p.kartspeed])
	
	x = $ or 160
	y = $ or 5
	
	local speedflags = flags & (V_SNAPTOTOP|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_SNAPTORIGHT)
	
	local rpmstage = min((rpm/1000), 11)
	local wholespeed
	local typetext
	local speedx = x + 40
	wholespeed, typetext = convertspeed(p.speed, customspeedometer.value, p, mapheaderinfo[gamemap].mobj_scale)
	if string.len(typetext) == 3 then speedx = $ - 8 end
	v.draw(x, y, v.cachePatch("S_REV_"..rpmstage), flags, ((rpmstage > 8) and v.getColormap(0, SKINCOLOR_RED)) or (((rpmstage > 5) and (rpmstage <= 8)) and v.getColormap(0, SKINCOLOR_YELLOW)) or (((rpmstage > 1) and (rpmstage <=5)) and v.getColormap(0, SKINCOLOR_EMERALD)) or v.getColormap(0, SKINCOLOR_JAWZ))
	local transparency = (rpm%1000)/100
	if (rpmstage < 11) and (not p.exiting) then
		v.draw(x, y, v.cachePatch("S_MID_"..(rpmstage + 1)), speedflags|flash[transparency], ((rpmstage > 8) and v.getColormap(0, SKINCOLOR_RED)) or (((rpmstage > 5) and (rpmstage <= 8)) and v.getColormap(0, SKINCOLOR_YELLOW)) or (((rpmstage > 1) and (rpmstage <=5)) and v.getColormap(0, SKINCOLOR_EMERALD)) or v.getColormap(0, SKINCOLOR_JAWZ))
	end
	drawLRMAXNum(v, padTimerZero(wholespeed), x+26, y+24, flags, YELLOWTEXT, false, "right")
	drawNewString(v, "LRMT", typetext, x+26, y+36, flags)
end

local function drawLRMAXPlace(v, p, n, flags)
	if (gametype & GT_SPECIAL) or (gametype & GT_VERSUS) or (gametype & GT_TUTORIAL) then return end //Don't show in Special Stages, Bosses or during the Tutorial
	local pxpos = 310
	local txpos = 300
	local ypos = 170
	local placetext = tostring(padTimerZero(p.position))
	local patch = v.cachePatch("LRMPL"..placetext)
	if not p.exiting then flags = flags|V_HUDTRANS end
	if p.pflags&PF_NOCONTEST then
		patch = v.cachePatch("LRMPDNF")
	end
	if splitscreen then
		ypos = 70
		pxpos = 70
	end
	v.draw(pxpos, ypos, patch, flags)
end

local function drawTATimer(v, p, xmid, y, flags)
	if not (p and p.valid) then return end
	local littletime = nil
	local littletimestr = "--:--.--"
	local medal = 5
	local medalpatch = v.cachePatch("BIGNEEDIT")
	local medalcol = v.getColormap(0, SKINCOLOR_NONE)
	local medaltimes = {}
	local littletimecolflag = V_GRAYMAP
	local currenttime = p.realtime
	xmid = $ or 160
	y = $ or 50
	//Get the medal times
	if mapheaderinfo[gamemap].automedaltime then //This doesn't exist currently
		medaltimes = {
			[1] = mapheaderinfo[gamemap].automedaltime[0],
			[2] = mapheaderinfo[gamemap].automedaltime[1],
			[3] = mapheaderinfo[gamemap].automedaltime[2],
			[4] = mapheaderinfo[gamemap].automedaltime[3]
		}
	elseif DTRMedals[string.upper(G_BuildMapName(gamemap))] then
		medaltimes = GetDTRMedals(gamemap)
	else
		medaltimes = {
			[1] = TICRATE * 30,
			[2] = TICRATE * 60,
			[3] = TICRATE * 120,
			[4] = TICRATE * 300
		}
	end
	for i = 1, 4 do
		if currenttime < medaltimes[i] then
			littletime = medaltimes[i] - p.realtime
			littletimecolflag = 0
			littletimestr = padTimerZero(G_TicsToMinutes(littletime, true)) .. ":" .. padTimerZero(G_TicsToSeconds(littletime)) .. "." ..  padTimerZero(G_TicsToCentiseconds(littletime))
			medal = i
			medalpatch = v.cachePatch("BIGGOTITA")
			medalcol = ({
				[1] = v.getColormap(0, SKINCOLOR_PLATINUM),
				[2] = v.getColormap(0, SKINCOLOR_GOLD),
				[3] = v.getColormap(0, SKINCOLOR_SILVER),
				[4] = v.getColormap(0, SKINCOLOR_BRONZE)
			}) [medal]
			break
		end
	end
	if littletimecolflag == 0 then
		if p.exiting then
			littletimecolflag = V_GREENMAP
		elseif (littletime < 10*TICRATE) and ((p.realtime % 8) >= 4) then
			littletimecolflag = V_REDMAP
		elseif (littletime >= 10*TICRATE) and (littletime <= 30*TICRATE) and ((p.realtime % 16) >= 8) then
			littletimecolflag = V_YELLOWMAP
		end
	end
	v.drawString(xmid, y, littletimestr, flags|littletimecolflag, "center")
	v.drawScaled((xmid + (4*string.len(littletimestr)))*FRACUNIT, y*FRACUNIT, FRACUNIT/2, medalpatch, flags, medalcol)
end

local function drawTAMedalTimes(v, p, x, y, flags)
	if not (p and p.valid) then return end
	local timestep = false
	local medalpatch = v.cachePatch("BIGGOTITA")
	local currenttime = p.realtime
	local medaltimes = {}
	if mapheaderinfo[gamemap].automedaltime then
		medaltimes = {
			[1] = mapheaderinfo[gamemap].automedaltime[0],
			[2] = mapheaderinfo[gamemap].automedaltime[1],
			[3] = mapheaderinfo[gamemap].automedaltime[2],
			[4] = mapheaderinfo[gamemap].automedaltime[3]
		}
	elseif DTRMedals[string.upper(G_BuildMapName(gamemap))] then
		medaltimes = GetDTRMedals(gamemap)
	else
		medaltimes = {
			[1] = TICRATE * 30,
			[2] = TICRATE * 60,
			[3] = TICRATE * 120,
			[4] = TICRATE * 300
		}
	end
	for i = 0, 3 do
		if medaltimes[i+1] then
			local medalcol = ({
				[1] = v.getColormap(0, SKINCOLOR_PLATINUM),
				[2] = v.getColormap(0, SKINCOLOR_GOLD),
				[3] = v.getColormap(0, SKINCOLOR_SILVER),
				[4] = v.getColormap(0, SKINCOLOR_BRONZE)
			}) [i+1]
			local time = medaltimes[i+1]
			local str = padTimerZero(G_TicsToMinutes(time, true)) .. ":" .. padTimerZero(G_TicsToSeconds(time)) .. "." ..  padTimerZero(G_TicsToCentiseconds(time))
			local colflag = 0
			if (not timestep) and (time > currenttime) then 
				if p.exiting then colflag = V_GREENMAP else colflag = V_YELLOWMAP end
				timestep = true
			end
			v.drawScaled(x*FRACUNIT, (y + (10*i))*FRACUNIT, FRACUNIT/2, medalpatch, flags, medalcol)
			if currenttime >= time then 
				local fflags = flags&(~V_HUDTRANS)
				fflags = $|V_HUDTRANSHALF
				colflag = V_GRAYMAP
				v.drawScaled(x*FRACUNIT, (y + (10*i))*FRACUNIT, FRACUNIT/2, v.cachePatch("BIGNEEDIT"), fflags)
			end
			v.drawString(x+10, y + (10*i), str, flags|colflag)
		end
	end
end

rawset(_G, "mapSet", function(mo)
	ufo = nil
end)

rawset(_G, "getufo", function(mo)
	if (mo.health <= 0) return end
	ufo = mo
end)

addHook("MapChange", mapSet)
addHook("MobjThinker", getufo, MT_SPECIAL_UFO)

addHook("ThinkFrame", do
	for p in players.iterate do
		p.karthud[khud_lapanimation] = 0 
	end
end)

hud.add(function(v, p, c)
	//This is where the code for DaytonaKart 2's HUD will go
	local timertime = leveltime - starttime //For the Position stage
	local positioncountdown = false
	local overtime = false
	if (gametype & GT_SPECIAL) then
		local timeframe = (leveltime / 7) % 35
		timertime = SEALEDSTARTIMES[timeframe] * TICRATE
	elseif leveltime >= starttime then 
		if (gametyperules & GTR_TIMELIMIT) then
			timertime = (timelimit + starttime + 1 - leveltime)
			if timertime < 0 then
				if (leveltime > (timelimit + starttime + TICRATE/2)) then
					timertime = -1 //Show infinite time
					if not modeattacking then
						overtime = true
					end
				else
					timertime = 0
				end
			end
		else
			if p.daytona and p.daytona.timelimit and (p.daytona.timelimit > 0) then //Only do this if there is a time limit
				timertime = max(p.daytona.timelimit - (leveltime - starttime), 0)
				if p.daytona.zerotime then timertime = 0 end
			else //No time limit, so consider it infinite
				timertime = -1 
			end
		end
	else
		positioncountdown = true
	end
	
	hud.disable("time") //Time
	hud.disable("gametypeinfo") //Laps
	hud.disable("position") //Placement
	hud.disable("speedometer") //Speed
	hud.disable("freeplay") //Freeplay info
	
	
	drawLRMAXTimer(v, 160, 5, timertime, V_SNAPTOTOP|V_HUDTRANS, positioncountdown, overtime, p)
	drawBattleManiaSpeed(v, p, V_HUDTRANS|V_SNAPTOBOTTOM|V_SNAPTOLEFT, 42, 152, true)
	
	drawLRMAXPlace(v, p, n, V_SNAPTOBOTTOM|V_SNAPTORIGHT)
	drawLRMAXLaps(v, p, nil, gamemap, V_HUDTRANS|V_SNAPTORIGHT|V_SNAPTOTOP)
	drawLRMAXRings(v, p, V_SNAPTOBOTTOM|V_HUDTRANS, 160, 197)
	
	if G_GametypeUsesLives() and (p and p.valid) then
		if p.lives > 1 then
			drawNewString(v, "LRMT", "LIVES: " .. p.lives, 160, 38, V_SNAPTOTOP|V_HUDTRANS, nil, "center")
		else
			drawNewString(v, "LRMT", "LAST LIFE!", 160, 38, V_SNAPTOTOP|V_HUDTRANS, nil, "center")
		end
	end
	
	if (gametyperules & GTR_POWERSTONES) and (not modeattacking) then
		drawLRMAXEmeralds(v, p, V_HUDTRANS|V_SNAPTORIGHT|V_SNAPTOTOP, 280, 5)
	end
	
	if (gametyperules & GTR_CATCHER) then
		drawLRMAXUfoHealth(v, V_HUDTRANS|V_SNAPTORIGHT|V_SNAPTOTOP, 280, 5, p)
	end
	
	if modeattacking and not (gametype & GT_SPECIAL) then
		drawTATimer(v, p, 160, 40, V_SNAPTOTOP|V_HUDTRANS)
		drawTAMedalTimes(v, p, 4, 64, V_SNAPTOTOP|V_SNAPTOLEFT|V_HUDTRANS)
	end
	
	local txstr
	local stringmap = 0
					
	if mapheaderinfo[gamemap].noextension or mapheaderinfo[gamemap].arcadeboss then
		txstr = "NO TIME EXTENSIONS!"
		stringmap = V_REDMAP
	else
		txstr = "TIME EXTENDED!"
	end
	
	if p and p.valid and p.daytona and p.daytona.extendflash and p.daytona.extendflash > 0 and (p.daytona.extendflash % 10) < 5 then
		v.drawString(160, 100, txstr, V_SNAPTOTOP|V_HUDTRANSHALF|stringmap, "center")
	end
	
end, "game")

hud.add(function(v)
	//SonicD Icon
	v.drawScaled(320*FRACUNIT, 0, FRACUNIT/2, v.cachePatch("SDICON"), V_SNAPTORIGHT)
	v.drawString(308, 35, "A SonicD Mod", V_SNAPTORIGHT, "small-right")
end, "title")