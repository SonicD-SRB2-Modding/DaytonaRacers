//This is the main bulk of the code for Daytona Racers

local MINERRORMOD = 5
local MAXERRORMOD = 20

//Debug stuff
local dkartdebug = {
	enabled = false,
	hp = 0,
	regen = 0,
	latent = 0
}

local arcadeon = CV_RegisterVar({"arcade", "On", CV_NETVAR|CV_SHOWMODIF, CV_OnOff})

local difficulty = CV_RegisterVar({"arcade_diff", "Intense", CV_NETVAR|CV_SHOWMODIF, {Beginner=1, Relaxed=2, Intense=3, Vicious=4, Master=5, Lunatic=6, Test=0, Custom=7}})
local starttimermod = CV_RegisterVar{
	name = "arcade_timermod",
	defaultvalue = 0,
	flags = CV_NETVAR,
	PossibleValue = {MIN = -30, MAX = 60} --Added by LunarRay
}

local laptimermod = CV_RegisterVar{
	name = "arcade_laptimermod",
	defaultvalue = 0,
	flags = CV_NETVAR,
	PossibleValue = {MIN = -20, MAX = 20} --Added by LunarRay
}

local extratimemod = CV_RegisterVar{
	name = "arcade_extratimermod",
	defaultvalue = 8,
	flags = CV_NETVAR,
	PossibleValue = {MIN = 5, MAX = 25}
}

local showdiff = CV_RegisterVar{
	name = "arcade_showdiff",
	defaultvalue = "Off",
	flags = CV_SHOWMODIF,
	PossibleValue = CV_OnOff
}

local explosiveKO = CV_RegisterVar{
	name = "arcade_explosiveko",
	defaultvalue = "Off",
	flags =CV_NETVAR|CV_SHOWMODIF,
	PossibleValue = CV_OnOff
}

local ringtimemod = CV_RegisterVar{
	name = "arcade_ringtime",
	defaultvalue = 5,
	flags = CV_NETVAR|CV_SHOWMODIF,
	PossibleValue = {MIN = 5, MAX = 20}
}

local RINGTIME = {
	[0] = 5,
	[1] = 5,
	[2] = 5,
	[3] = 5,
	[4] = 7,
	[5] = 10,
	[6] = 35,
	[7] = -1
}

local DIFFSUFF = ({
			[0] = "T",
			[1] = "B",
			[2] = "E",
			[3] = "N",
			[4] = "H",
			[5] = "M",
			[6] = "L",
			[7] = "LOLNOPE"
})

rawset(_G, "daytonaracers", {
	active = arcadeon.value,
	diff = difficulty.value,
	diffsuff = DIFFSUFF[difficulty.value],
	ringtimer = RINGTIME[difficulty.value],
	startmod = starttimermod.value,
	lapmod = laptimermod.value,
	extimemod = extratimemod.value,
	explosiveKO = true
})

local endtimer
local isFreeplay = true
local numplayers = 0

addHook("NetVars", function(network)
	endtimer = network($)
	DTRTimes = network($)
	setmaps = network($)
	isFreeplay = network($)
	daytonaracers.active = network($)
	daytonaracers.diff = network($)
	daytonaracers.diffsuff = network($)
	daytonaracers.ringtimer = network($)
	daytonaracers.startmod = network($)
	daytonaracers.lapmod = network($)
	daytonaracers.extimemod = network($)
	daytonaracers.explosiveKO = network($)
end)

local FLASHTIME = 5 * TICRATE / 2
local BASETIME = 180 //Test Time Limit
local BASEBONUS = 60 //Test Time Add
local TIMEOVERLENGTH = 5 * TICRATE

local function setmaptime(map)
	local timelimit
	local basetimelimit
	local lapmod
	local bonus
	
	basetimelimit, bonus = GetDTRTimes(map)
	
	if basetimelimit < 0 then return -1, -1 end //No time limit here, so maptime is considered infinite!
	
	if mapheaderinfo[map].arcadeboss then //Overrides for Boss Maps with fixed time limits
		return basetimelimit * TICRATE, 0
	end
	
	if daytonaracers.diff == 7 then //Custom
		timelimit = basetimelimit + daytonaracers.startmod
		bonus = $ + daytonakart.lapmod
		if bonus < 5 then bonus = 5 end
	elseif daytonaracers.diff == 6 then //Lunatic
		timelimit = basetimelimit
		bonus = $
	elseif daytonaracers.diff == 5 then //Master
		timelimit = basetimelimit
		bonus = $
	elseif daytonaracers.diff == 4 then //Hard
		timelimit = basetimelimit
		bonus = $
	elseif daytonaracers.diff == 3 then //Normal
		timelimit = basetimelimit
		bonus = $
	elseif daytonaracers.diff == 2 then //Easy
		timelimit = basetimelimit
		bonus = $
	elseif daytonaracers.diff == 1 then //Beginner
		timelimit = basetimelimit
		bonus = $
	else //daytonaracers.diff == 0 - Test
		timelimit = 180
		bonus = 60
	end
	
	lapmod = numlaps
	lapmod = $ - mapheaderinfo[map].numlaps //Postive if numlaps is more than mapheaderinfo[map].numlaps
	
	local errorbonus
	if daytonakart and extimemod then
		errorbonus = daytonakart.extimemod * lapmod
	else
		errorbonus = 5 * lapmod
	end
	if lapmod ~= 0 and errorbonus < 5 then
		errorbonus = 5 * lapmod
	elseif (errorbonus % 5) > 2 then
		errorbonus = $ - ($ % 5) + 5
	elseif (errorbonus % 5) > 0 then
		errorbonus = $ - ($ % 5)
	end
	
	timelimit = $ + errorbonus
		
	return timelimit * TICRATE, bonus * TICRATE
end

local function startset(player, map)
	if player.daytona == nil then player.daytona = {} end
	player.daytona.extendflash = 0
	player.daytona.quirpcooldown = 0
	player.daytona.ringtimecharge = 0
	player.daytona.timeover = false
	player.daytona.currentlap = 1
	player.daytona.zerotime = false
	if (gametype & GT_SPECIAL) then
		player.daytona.timelimit = -1
		player.daytona.bonustime = 0
	elseif (gametype & GT_BATTLE) then
		player.daytona.timelimit = -1
		player.daytona.bonustime = 0
	elseif (gametype & GT_VERSUS) then
		player.daytona.timelimit = -1
		player.daytona.bonustime = 0
	elseif (gametype & GT_TUTORIAL) then
		player.daytona.timelimit = -1
		player.daytona.bonustime = 0
	else
		if not setmaps[map] then firstloadmap(map) end
		player.daytona.timelimit, player.daytona.bonustime = setmaptime(map)
		//if freeplay, add 10 seconds to the time limit as a buffer 'Position' time
		if mapheaderinfo[map].noextension then
			player.daytona.timelimit = $ + ((numlaps - 1) * player.daytona.bonustime)
		end
		if (((leveltime - starttime) > player.daytona.timelimit) or (leveltime > 90 * TICRATE)) and (player.daytona.timelimit > 0) then //Disable time limit if entering late
			player.daytona.timelimit = -1
			player.daytona.bonustime = 0
		else
			if isFreeplay then player.daytona.timelimit = $ + (10 * TICRATE) end //Add 10 seconds if playing solo
		end
	end
end

addHook("MapChange", do
	endtimer = 0
	daytonaracers.active = (arcadeon.value > 0)
end)

addHook("MapLoad", do
	firstloadmap(gamemap)
	//Set up the variables for the daytonaracers table
	daytonaracers.active = (arcadeon.value > 0)
	daytonaracers.diff = difficulty.value
	daytonaracers.diffsuff = DIFFSUFF[daytonaracers.diff]
	daytonaracers.ringtimer = RINGTIME[daytonaracers.diff]
	if daytonaracers.ringtimer == -1 then daytonaracers.ringtimer = ringtimemod end
	daytonaracers.extimemod = extratimemod.value
	daytonaracers.explosiveKO = explosiveKO.value
	daytonaracers.startmod = starttimermod.value
	daytonaracers.lapmod = laptimermod.value
	if daytonaracers.active then
		//COM_BufInsertText(server, "karteliminatelast off") //Turn off last place going boom
		//COM_BufInsertText(server, "countdowntime 999") //Max out end of map countdown time
		for p in players.iterate do
			startset(p, gamemap)
		end
	end
end)

addHook("ThinkFrame", do
	if daytonaracers.active then
		local outplayers
		local possoutplayers
		numplayers = 0
		outplayers = 0
		possoutplayers = 0
		for p in players.iterate do
			if not p and p.valid continue end
			if p.spectator continue end
			if not p.daytona and leveltime > 26 then startset(p, gamemap) end
			numplayers = $ + 1
			if leveltime < 26 then
				continue --Don't do anything during the first few frames as we need to set things up
			elseif leveltime == 26 then
				firstloadmap(gamemap)
				startset(p, gamemap)
			end
			if p.daytona == nil then startset(p, gamemap) end
			
			if p.exiting then
				outplayers = $ + 1 
				possoutplayers = $ + 1
				continue
			end
			
			if (p.cmd.buttons & BT_LUAA) and (leveltime > starttime) and (p.daytona.timelimit > 0) and (not modeattacking) then
				p.daytona.ringtimecharge = $ + 1
				if (p.daytona.ringtimecharge % 17) == 1 then
					if p.rings >= daytonaracers.ringtimer then
						p.rings = $ - daytonaracers.ringtimer
						p.daytona.timelimit = $ + TICRATE
						//play sound
						S_StartSound(nil,sfx_tmxawd,p)
					end
				end
			else
				if p.daytona.ringtimecharge != 0 then p.daytona.ringtimecharge = 0 end
			end
			
			if p.daytona.timelimit == (leveltime - starttime) and (not p.daytona.timeover) and (leveltime > starttime) and (not p.exiting) then //Time Over
				//...Although not just yet - let's check if they have any Rings that can be drained
				p.daytona.zerotime = true
				if p.rings > -20 then //They do have rings to spare, so use one to add time to the timer!
					local ticstoadd = max(TICRATE / daytonaracers.ringtimer, 1)
					p.rings = $ - 1
					p.daytona.timelimit = $ + ticstoadd
					S_StartSound(nil,sfx_antiri,p) //Play a Ring Drain sound
				else //Outta time and Rings...
					p.daytona.timeover = true
					S_StartSound(nil,sfx_arcko,p)
				end
			elseif p.daytona.timeover and (p.rings > -20) then
				p.daytona.timeover = false //We got rings when about to get KOed? Then we're back in the race!
				local ticstoadd = max(TICRATE / daytonaracers.ringtimer, 1)
				p.rings = $ - 1
				p.daytona.timelimit = (2 + ((leveltime - starttime)/ticstoadd))*ticstoadd
				S_StartSound(nil,sfx_antiri,p) //Play a Ring Drain sound
				p.daytona.extendflash = 0
			elseif p.daytona.extendflash < 0 and not (p.daytona.extendflash == -TIMEOVERLENGTH) then
				p.daytona.extendflash = $ - 1
			end
			
			if p.daytona.timeover then
				p.pflags = $ | PF_STASIS
				possoutplayers = $ + 1
				if p.speed == 0 or (p.rmomx == 0 and p.rmomy == 0) then
					if p.itemtype then
						p.itemtype = 0
						p.itemamount = 0
						K_StripItems(p)
					end
					outplayers = $ + 1
					if p.daytona.extendflash > -1 then
						p.daytona.extendflash = -1
						p.exiting = TIMEOVERLENGTH
						p.daytona.quirpcooldown = -1
						p.pflags = $ | PF_NOCONTEST
						//S_ChangeMusic("LOSERC",true,p) //Play losing music
						if daytonaracers.explosiveKO then --Explosive KO!
							if p.mo then P_DamageMobj(p.mo, nil, nil, 10000) end
							P_FlashPal(p, 1, 10)
						end
					end
				end
				continue
			end
			
			if p.daytona.currentlap < p.laps then
				p.daytona.currentlap = p.laps
				if mapheaderinfo[gamemap].noextension or mapheaderinfo[gamemap].arcadeboss then
					p.daytona.numlaps = $ + 1
					p.daytona.quirpcooldown = TICRATE
					if p.daytona.numlaps == 1 then 
						p.daytona.extendflash = FLASHTIME
					end
				else
					if p.daytona.zerotime then p.daytona.zerotime = false end
					if p.daytona.timeover then //Almost about to lose, but crosses the finish line before stopping
						p.daytona.timeover = false //Back in the game!
						p.daytona.timelimit = (1 + ((leveltime - starttime) / TICRATE)) * TICRATE
						p.daytona.extendflash = 0
					end
					if not (p.daytona.currentlap == numlaps + 1) then
						p.daytona.timelimit = $ + p.daytona.bonustime
						p.daytona.extendflash = FLASHTIME
					end
					p.daytona.quirpcooldown = timeextended(p)
					if p.daytona.timelimit > 13*TICRATE + p.daytona.quirpcooldown then p.announcearcade.warnten = false end
					if p.daytona.timelimit > 30*TICRATE + p.daytona.quirpcooldown then p.announcearcade.warnthirty = false end
				end
			elseif (p.daytona.extendflash > 0) then //Reduce countdown on Lap Bonus
				p.daytona.extendflash = $ - 1
			end
		end
		
		if endtimer and endtimer > 0 then
			endtimer = $ + 1
			if endtimer > (4 * TIMEOVERLENGTH) and not modeattacking then
				G_ExitLevel()
			end
		elseif outplayers == numplayers and numplayers > 0 then
			endtimer = 1
		elseif possoutplayers == numplayers and numplayers > 0 then
			for p in players.iterate() do
				if p.spectator continue end
				if p.exiting then continue end
				if p.daytona.timelimit + (TIMEOVERLENGTH) < leveltime then
					if (p.daytona.extendflash > -1) then
						p.daytona.extendflash = -1
						//S_ChangeMusic("LOSERC",true,p) //Play losing music
						p.pflags = $|PF_NOCONTEST
						p.exiting = TIMEOVERLENGTH
						p.daytona.quirpcooldown = -1
						if daytonaracers.explosiveKO then --Explosive KO!
							if p.mo then P_DamageMobj(p.mo, nil, nil, 10000) end
							P_FlashPal(p, 1, 10)
						end
					end
					outplayers = $ + 1
				end
				if outplayers == numplayers and numplayers > 0 then
					endtimer = 1
				end
			end
		end
		if (numplayers == 1) and not isFreeplay then isFreeplay = true
		elseif (numplayers > 1) and (isFreeplay) then isFreeplay = false end
	end
end)

hud.add(function(v)
	if not daytonakart.active then return end
	if not ((gametype & GT_BATTLE) or (gametype & GT_SPECIAL) or (gametype & GT_VERSUS) or (gametype & GT_TUTORIAL)) then
		local difficultytext = ({
			[7] = "Custom difficulty",
			[1] = "Beginner",
			[2] = "Easy",
			[3] = "Normal",
			[4] = "Hard",
			[5] = "Master",
			[6] = "Lunatic",
		}) [daytonaracers.diff]
		v.drawString(0, 192, difficultytext, V_ALLOWLOWERCASE|V_40TRANS|V_SNAPTOBOTTOM|V_SNAPTOLEFT)
	end
	v.drawString(320, 192, "Daytona Racers: "..ADRVersion.." ", V_ALLOWLOWERCASE|V_40TRANS|V_SNAPTOBOTTOM|V_SNAPTORIGHT, "right")
end, "scores")

print("\x82".."Daytona Racers "..ADRVersion.." is now installed!")

COM_AddCommand("daytonaHelp", function(p)
	CONS_Printf(p, "\x82".."arcade_speed: Determines what speedometer type to use. Default Miles.")
	CONS_Printf(p, "\x82".."Options - Miles, Kilometers, Meters, Fracunits, Knots, Feet, Percentage.")
end)

COM_AddCommand("daytonaServerHelp", function(p)
	CONS_Printf(p, "\x82".."arcade: Toggles Arcade Mode on and off. Default On.")
	CONS_Printf(p, "\x82".."arcade_diff: Determines the modifiers for the time limit.")
	CONS_Printf(p, "\x82".."Potential Difficulties include the following:") 
	CONS_Printf(p, "\x82".."Beginner, Relaxed, Intense, Vicious, Master and Lunatic.")
	CONS_Printf(p, "\x82".."There is also a Custom difficulty left for you to discover.")
	CONS_Printf(p, "\x82".."Default difficulty is Intense.")
end, 1)