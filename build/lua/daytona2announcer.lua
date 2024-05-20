//Announcer stuff for Daytona Racers

freeslot(
"sfx_arccr", "sfx_arclo", "sfx_arcko", "sfx_arcbt",
"sfx_am1lpr", "sfx_am2lpr", "sfx_am5lpr", "sfx_am7lpr",
"sfx_am1lgr", "sfx_am2lgr",
"sfx_amatuw", "sfx_amgoal", "sfx_amlot1", "sfx_amlot2",
"sfx_amsc1", "sfx_amsc2", "sfx_amsc3", "sfx_amscgo",
"sfx_amtex1", "sfx_amtex2", "sfx_amtex3", "sfx_amtex4", "sfx_amtex5"
)

local timeextension = {
{sfx_amtex1, 50},
{sfx_amtex2, 60},
{sfx_amtex3, 90},
{sfx_amtex4, 90},
{sfx_amtex5, 85}
}

local lapstogosfx = {
	[1] = sfx_am1lpr,
	[2] = sfx_am2lpr,
	[3] = nil,
	[5] = sfx_am5lpr,
	[7] = sfx_am7lpr
}

local legstogosfx = {
	[1] = sfx_am1lgr,
	[2] = sfx_am2lgr,
	[3] = nil
}

local function announcerstartendcallouts(p)
	local timeforthree = starttime - (3*TICRATE)
	local timefortwo = starttime - (2*TICRATE)
	local timeforone = starttime - TICRATE
	local timeforgo = starttime
	local timeforunderway = starttime + TICRATE
	
	if leveltime < TICRATE then return end
	
	if leveltime == timeforthree then
		S_StartSound(nil,sfx_amsc3,p)
	elseif leveltime == timefortwo then
		S_StartSound(nil,sfx_amsc2,p)
	elseif leveltime == timeforone then
		S_StartSound(nil,sfx_amsc1,p)
	elseif leveltime == timeforgo then
		S_StartSound(nil,sfx_amscgo,p)
	elseif leveltime == timeforunderway then
		S_StartSound(nil,sfx_amatuw,p)
	elseif (p.exiting) and (not p.announcearcade.finish) then
		if p.pflags & PF_NOCONTEST then
			
		else
			S_StartSound(nil,sfx_amgoal,p)
		end
		p.announcearcade.finish = true
	end
end

rawset(_G, "timeextended", function(p)
	local rand = P_RandomRange(1, #timeextension)
	local quirp = timeextension[rand]
	S_StartSound(nil,quirp[1],p)
	return quirp[2]
end)

local function announcerlapcallouts(p)
	if (gametype & GT_BATTLE) or (gametype & GT_SPECIAL) or (gametype & GT_VERSUS) or (gametype & GT_TUTORIAL) then return end
	local lapstogo = (numlaps + 1) - p.laps
	if p.daytona then
		if not (p.daytona.quirpcooldown == 0) then
			return
		end
	elseif (p.announcearcade.lapquirp != lapstogo) then
		 p.announcearcade.lapquirp = lapstogo
	else
		return
	end
	
	local sfxpack = lapstogosfx
	if mapheaderinfo[gamemap].levelflags & LF_SECTIONRACE then
		sfxpack = legstogosfx
	elseif (tonumber(mapheaderinfo[gamemap].lapspersection) ~= nil) and (tonumber(mapheaderinfo[gamemap].lapspersection) > 1) then
		if (lapstogo % tonumber(mapheaderinfo[gamemap].lapspersection)) != 0 then return end
		lapstogo = lapstogo / tonumber(mapheaderinfo[gamemap].lapspersection)
	end
	if sfxpack[lapstogo] then S_StartSound(nil,sfxpack[lapstogo],p) end
end

local function announcerlowtimewarnings(p, timeleft)
	if leveltime <= starttime + (TICRATE * 5) then return end //Don't play any warnings during the first 5 seconds of the race/match
	if p.exiting then return end //Also don't play if they're leaving
	if (timeleft == (30 * TICRATE)) and (not p.announcearcade.warnthirty) then
		p.announcearcade.warnthirty = true
		S_StartSound(nil,sfx_amlot1,p)
	elseif (timeleft == (13 * TICRATE)) and (not p.announcearcade.warnten) then
		S_StartSound(nil,sfx_amlot2,p)
		p.announcearcade.warnten = true
	elseif timeleft == (10 * TICRATE) then
		S_StartSound(nil,sfx_arccr,p)
	elseif (timeleft < (10 * TICRATE)) and((timeleft % TICRATE) == 0) and (timeleft > 0) then
		S_StartSound(nil,sfx_arclo,p)
	end
end

addHook("ThinkFrame", do
	for p in players.iterate do
		if not p.announcearcade then
			p.announcearcade = {}
			p.announcearcade.warnthirty = false
			p.announcearcade.warnten = false
			p.announcearcade.finish = false
			p.announcearcade.lapquirp = 0
		end
		announcerstartendcallouts(p)
		if not p.daytona then
			announcerlapcallouts(p)
		elseif not ((gametype & GT_BATTLE) or (gametype & GT_SPECIAL) or (gametype & GT_VERSUS) or (gametype & GT_TUTORIAL)) then
			local lapstogo = (numlaps + 1) - p.laps
			if (p.announcearcade.lapquirp != lapstogo) and (p.laps > 1) and (p.laps < numlaps) then
				p.announcearcade.lapquirp = lapstogo
			else
				if p.daytona.quirpcooldown and (p.daytona.quirpcooldown > 0) then
					p.daytona.quirpcooldown = $ - 1
					if (p.daytona.quirpcooldown == 0) then
						announcerlapcallouts(p)
					end
				else
					announcerlowtimewarnings(p, max(p.daytona.timelimit - (leveltime - starttime), 0))
				end
			end
		end
		if (gametyperules & GTR_TIMELIMIT) then
			local timeleft = (timelimit + starttime + 1 - leveltime)
			announcerlowtimewarnings(p, timeleft)
		end
	end
end)

addHook("MapChange", do
	for p in players.iterate do
		p.announcearcade = {}
		p.announcearcade.warnthirty = false
		p.announcearcade.warnten = false
		p.announcearcade.finish = false
		p.announcearcade.lapquirp = 0
	end
end)