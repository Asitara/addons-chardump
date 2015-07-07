local myJSON = json.json
CHDMP = CHDMP or {}
local private = {}



function private.GetGlobalInfo() --------- GLOBAL
	local retTbl = {}

	local _, class          = UnitClass("player");
	local _, race           = UnitRace("player");
	local il_all, il_eq		= GetAverageItemLevel()

	retTbl.name             = UnitName("player");
	retTbl.title			= GetCurrentTitle();
	retTbl.gender           = UnitSex("player");
	retTbl.race             = race;
	retTbl.class            = class;
	retTbl.level            = UnitLevel("player");
	retTbl.health			= UnitHealthMax("player");
	retTbl.power			= UnitPowerMax("player");
	retTbl.date				= notfalls time()
	retTbl.ilevel_equipped	= il_eq;
	retTbl.ilevel_overall	= il_all;
	retTbl.money            = GetMoney();
	retTbl.version			= version;
	retTbl.locale			= GetLocale();
	retTbl.realm			= GetRealmName();

	private.ILog("Global Infos DONE...");
	return retTbl;
end

function private.GetStatsData() ---------- STATS
	local il_all, il_eq = GetAverageItemLevel()

	local minMainDmg, maxMainDmg, minOffDmg, minMaxDmg = UnitDamage("player")
	local MainSpeed, OffSpeed = UnitAttackSpeed("player")

	retTbl = {
		['health'] = UnitHealthMax("player"),
		['power'] = UnitPowerMax("player"),
		['averageItemLevel'] = il_all,
		['averageItemLevelEquipped'] = il_eq,

		['str'] = UnitStat("player", 1),
		['agi'] = UnitStat("player", 2),
		['sta'] = UnitStat("player", 3),
		['int'] = UnitStat("player", 4),
		['spr'] = UnitStat("player", 5),

		['mainHandDmgMin'] = minMainDmg,
		['mainHandDmgMax'] = maxMainDmg,
		['mainHandSpeed'] = MainSpeed,
		['offHandDmgMax'] = minOffDmg,
		['offHandDmgMin'] = minMaxDmg,
		['offHandSpeed'] = OffSpeed,
		['meleeAttackPower'] = UnitAttackPower("player"),
		['meleeHaste'] = GetCombatRating(CR_HASTE_MELEE),
		['meleeHit'] = GetCombatRating(CR_HIT_MELEE),
		['meleeCrit'] = GetCritChance(),
		['meleeExp'] = GetExpertise(),

		['rangeDmgMin'] = minRangeDmg,
		['rangeDmgMax'] = maxRangeDmg,
		['rangeSpeed'] = RangeSpeed,
		['rangeHaste'] = GetCombatRating(CR_HASTE_RANGED),
		--['rangeFocusReg'] = , -- maybe inactiveRegen, activeRegen = GetPowerRegen()
		['rangeHit'] = GetCombatRating(CR_HIT_RANGED),
		['rangeCrit'] = GetRangedCritChance(),

		['spellBonusDmg'] = GetSpellBonusDamage(2),
		['spellBonusHealing'] = GetSpellBonusHealing(),
		['spellHaste'] = GetCombatRating(CR_HASTE_SPELL),
		['spellHit'] = GetCombatRating(CR_HIT_SPELL),
		['spellPen'] = GetSpellPenetration(),
		['mana5'] = floor(GetManaRegen() * 5.0),
		['spellCrit'] = GetSpellCritChance(2),

		['armor'] = UnitArmor("player"),
		['dodge'] = GetDodgeChance(),
		['parry'] = GetParryChance(),
		['block'] = GetBlockChance(),
		['resilience'] = GetCombatRating(COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN),

		['resistHoly'] = UnitResistance("player", 1),
		['resistFire'] = UnitResistance("player", 2),
		['resistNature'] = UnitResistance("player", 3),
		['resistFrost'] = UnitResistance("player", 4),
		['resistShadow'] = UnitResistance("player", 5),
		['resistArcane'] = UnitResistance("player", 6),

		['mastery'] = GetCombatRating(CR_MASTERY),
	}

	private.ILog("Stats DONE...");
    return retTbl
end

function private.GetTitlesData() --------- TITLES
    local retTbl = {}

    for i = 1, GetNumTitles() do
		if IsTitleKnown(i) == 1 then
			local titleName = GetTitleName(i);
			retTbl[tostring(i)] = tostring(i);
		end
    end

    private.ILog("Titles DONE...");
    return retTbl
end

function private.GetReputationData() ----- REPUTATION
    local retTbl = {}

	local faFactionDataRow = {};
		faFactionDataRow[1037] = 1;
		faFactionDataRow[1106] = 2;
		faFactionDataRow[529]  = 3;
		faFactionDataRow[1012] = 4;
		faFactionDataRow[1204] = 5;
		faFactionDataRow[1177] = 6;
		faFactionDataRow[1133] = 7;
		faFactionDataRow[87]   = 8;
		faFactionDataRow[21]   = 9;
		faFactionDataRow[910]  = 10;
		faFactionDataRow[609]  = 11;
		faFactionDataRow[942]  = 12;
		faFactionDataRow[909]  = 13;
		faFactionDataRow[530]  = 14;
		faFactionDataRow[69]  = 15;
		faFactionDataRow[1172]  = 16;
		faFactionDataRow[577]  = 17;
		faFactionDataRow[930]  = 18;
		faFactionDataRow[1068]  = 19;
		faFactionDataRow[1104]  = 20;
		faFactionDataRow[729]  = 21;
		faFactionDataRow[369]  = 22;
		faFactionDataRow[92]  = 23;
		faFactionDataRow[1134]  = 24;
		faFactionDataRow[54]  = 25;
		faFactionDataRow[1158]  = 26;
		faFactionDataRow[1168]  = 27;
		faFactionDataRow[1178]  = 28;
		faFactionDataRow[946]  = 29;
		faFactionDataRow[1052]  = 30;
		faFactionDataRow[749]  = 31;
		faFactionDataRow[47]  = 32;
		faFactionDataRow[989]  = 33;
		faFactionDataRow[1090]  = 34;
		faFactionDataRow[1098]  = 35;
		faFactionDataRow[978]  = 36;
		faFactionDataRow[1011]  = 37;
		faFactionDataRow[93]  = 38;
		faFactionDataRow[1015]  = 39;
		faFactionDataRow[1038]  = 40;
		faFactionDataRow[76]  = 41;
		faFactionDataRow[1173]  = 42;
		faFactionDataRow[470]  = 43;
		faFactionDataRow[349]  = 44;
		faFactionDataRow[1031]  = 45;
		faFactionDataRow[1077]  = 46;
		faFactionDataRow[809]  = 47;
		faFactionDataRow[911]  = 48;
		faFactionDataRow[890]  = 49;
		faFactionDataRow[970]  = 50;
		faFactionDataRow[730]  = 51;
		faFactionDataRow[72]  = 52;
		faFactionDataRow[70]  = 53;
		faFactionDataRow[932]  = 54;
		faFactionDataRow[1156]  = 55;
		faFactionDataRow[933]  = 56;
		faFactionDataRow[510]  = 57;
		faFactionDataRow[1135]  = 58;
		faFactionDataRow[1126]  = 59;
		faFactionDataRow[1067]  = 60;
		faFactionDataRow[1073]  = 61;
		faFactionDataRow[509]  = 62;
		faFactionDataRow[941]  = 63;
		faFactionDataRow[1105]  = 64;
		faFactionDataRow[990]  = 65;
		faFactionDataRow[934]  = 66;
		faFactionDataRow[935]  = 67;
		faFactionDataRow[1094]  = 68;
		faFactionDataRow[1119]  = 69;
		faFactionDataRow[1124]  = 70;
		faFactionDataRow[1064]  = 71;
		faFactionDataRow[967]  = 72;
		faFactionDataRow[1091]  = 73;
		faFactionDataRow[1171]  = 74;
		faFactionDataRow[59]  = 75;
		faFactionDataRow[947]  = 76;
		faFactionDataRow[81]  = 77;
		faFactionDataRow[576]  = 78;
		faFactionDataRow[922]  = 79;
		faFactionDataRow[68]  = 80;
		faFactionDataRow[1050]  = 81;
		faFactionDataRow[1085]  = 82;
		faFactionDataRow[889]  = 83;
		faFactionDataRow[1174]  = 84;
		faFactionDataRow[589]  = 85;
		faFactionDataRow[270]  = 86;

	for blizzID, listID in pairs(faFactionDataRow) do
		local name, _, _, barMin, barMax, barValue = GetFactionInfoByID(blizzID)
		local _, _, _, _, _, earnedValue = GetFactionInfo(listID)

		retTbl[blizzID] = earnedValue
	end

    private.ILog("Reputation DONE...");
    return retTbl;
end

function private.GetCurrenciesData() ----- CURRENCIES
    local retTbl = {}

	for i = 1, GetCurrencyListSize() do
		local _, isHeader, _, _, _, count = GetCurrencyListInfo(i)
		local link = GetCurrencyListLink(i)

		if not isHeader then
			local id = link:match("currency:(%d+)")
			retTbl[id] = count
		end
	end

	private.ILog("Currencies DONE...");
    return retTbl;
end

function private.GetTalentsData() -------- TALENTS
	local retTbl = {}

	local specID	= 0			-- uniqueID of specType for localization, will be changed dynamicly

	for talentGroup = 1, 2 do -- ( PRIMARY / SECONDARY )
		if (talentGroup == 2) then specType = 'secondary'; specID = 0; end

		for tabIndex = 1, 3 do -- check each Tab of Spec
			local id, _, _, _, pointsSpent = GetTalentTabInfo(tabIndex, false, false, talentGroup)

			if pointsSpent and (pointsSpent >= 10) then -- get the unique id of the main/sec spec
				specID = id
				retTbl[specID] = {['glyphs'] = {}}
			end
		end

		if (specID > 0) then -- if we have a spec, checkout...
			for tabIndex = 1, 3 do -- each tab
				local id = GetTalentTabInfo(tabIndex, false, false, talentGroup)
				retTbl[specID][id] = {}

				for talentIndex = 1, GetNumTalents(tabIndex) do -- each talent
					local name, icon, row, column, rank, maxRank = GetTalentInfo(tabIndex, talentIndex, false, false, specID)
					retTbl[specID][id][talentIndex] = {
						['name']	= name,
						['tier']	= row,
						['column']	= column,
						['rank']	= rank,
						['maxRank'] = maxRank,
					}
				end
			end

			for glyphSocket = 1, GetNumGlyphSockets() do -- get the glyphs
				local enabled, glyphType, glyphTooltipIndex, glyphSpell, icon = GetGlyphSocketInfo(glyphSocket, talentGroup)

				if enabled and glyphSpell then
					retTbl[specID]['glyphs'][glyphSocket] = glyphSpell
				end
			end

		end
	end

--[[


	for talentGroup = 1, 2 do -- loop 1 = PRIMARY, 2 = SECONDARY
		if (talentGroup == 2) then talentGroupName = 'secondary'; end

		local tabIndex = GetPrimaryTalentTree(false, false, talentGroup) -- get tabIndex for primary/secondary
		local spec_id, spec_name, _, _, _, points = GetTalentTabInfo(tabIndex);
		retTbl[talentGroupName] = {
					['id'] = spec_id,
					['name'] = spec_name,
					['points'] = points,
					['talents'] = {},
					['glyphs'] = {}
		}
		for talentIndex = 1, GetNumTalents(tabIndex) do
			local name, icon, row, column, points, max_points = GetTalentInfo(tabIndex, talentIndex, false);
			retTbl[talentGroupName]['talents'][icon] = {
										['name'] = name,
										['row'] = row,
										['column'] = column,
										['points'] = points,
										['max_points'] = max_points,
			}
		end

		for glyphSocket = 1, GetNumGlyphSockets() do
			local enabled, glyphType, glyphTooltipIndex, glyphSpell, icon = GetGlyphSocketInfo(glyphSocket, talentGroup);
			if(enabled == 1 and glyphSpell) then
				local name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRange = GetSpellInfo(glyphSpell)
				retTbl[talentGroupName]['glyphs'][glyphSocket] = {
					['id']	 = glyphSpell,
					['name'] = name,
					['type'] = glyphType
				}
			else
				retTbl[talentGroupName]['glyphs'][glyphSocket] = nil;
			end
		end
	end

	]]

	private.ILog("Talents DONE...");
    return retTbl;
end

function private.GetProfessionsData() ---- PROFESSIONS
	local retTbl = {['primary'] = {}, ['secondary'] = {}}

	local profIndex = {GetProfessions()}

	for profession, listIndex in pairs(profIndex) do
		if not (profession > 2) then
			local _, _, skillLevel, _, _, _, skillLine = GetProfessionInfo(listIndex);
			retTbl['primary'][skillLine] = skillLevel
		else
			local _, _, skillLevel, _, _, _, skillLine = GetProfessionInfo(listIndex);
			retTbl['secondary'][skillLine] = skillLevel
		end
	end

	private.ILog("Profesions DONE...");
    return retTbl;
end

function private.GetMountsData() --------- MOUNTS
    local retTbl = {}

    for i = 1, GetNumCompanions("MOUNT") do
        local id = GetCompanionInfo("MOUNT", i);
        retTbl[i] = id;
    end

    private.ILog("Mounts DONE...");
    return retTbl;
end

function private.GetCrittersData() ------- CRITTERS
    local retTbl = {}

    for i = 1, GetNumCompanions("CRITTER") do
        local id = GetCompanionInfo("CRITTER", i);
        retTbl[i] = id;
    end

    private.ILog("Critters DONE...");
    return retTbl;
end

function private.GetAchievementsData() --- ACHIEVEMENTS
    local retTbl = {}

	-- Later we need to scan which category has parrent catgegory with GetCategoryInfo();

	for a, categoryID in pairs(GetCategoryList()) do
		for i = 1 , GetCategoryNumAchievements(categoryID) do
			local achID, name, points, completed, Month, Day, Year, _, flags, _, _, isGuild = GetAchievementInfo(categoryID, i)
			if achID and not isGuild then
				local posixtime = 0

                if completed then
                    local posixtime = time{year = 2000 + Year, month = Month, day = Day}
                end

				retTbl[categoryID] = {
					[achID] = {
						['name'] = name,
						['points'] = points,
						['completed'] = completed,
						['date'] = posixtime,
						['flag'] = flags
					}
				}
			end
		end
	end

    private.ILog("Achievements DONE...");
    return retTbl;
end

function private.GetStatisticsData() ----- STATISTICS
    local retTbl = {}

	-- Later we need to scan which category has parrent catgegory with GetCategoryInfo();

	for a, categoryID in pairs(GetStatisticsCategoryList()) do
		for i = 1 , GetCategoryNumAchievements(categoryID) do
			local id, Name = GetAchievementInfo(categoryID, i);
			if id then
				local value = GetStatistic(id);

				retTbl[categoryID] = { [id] = Name }
			end
		end
	end

    private.ILog("Statistics DONE...");
    return retTbl;
end

function private.GetInventoryData() ------ INVENTORY
	local retTbl = { ['equiped'] = {}, ['bags'] = {}, ['bank'] = {} }

	---- http://wowwiki.wikia.com/Equipment_slot  --icons undso .. voll toll !!!
	for i = 1, 19, 1 do
		local link = GetInventoryItemLink("player", i)
		if link then
			retTbl['equiped'][i] = link
		end
	end

    private.ILog("Inventory DONE...");
    return retTbl;
end


--------------------------------------------------
--                Main Function                 --
--------------------------------------------------
function private.CreateCharDump()
	private.dmp = {};

	private.dmp.global		= private.trycall(private.GetGlobalInfo, private.ErrLog)		or {};		-- it works!
	private.dmp.stats		= private.trycall(private.GetStatsData, private.ErrLog)			or {};		-- it works!
	private.dmp.titles		= private.trycall(private.GetTitlesData, private.ErrLog)		or {};		-- it works!
	private.dmp.reputation	= private.trycall(private.GetReputationData, private.ErrLog)	or {};		-- it works!
	private.dmp.currencies	= private.trycall(private.GetCurrenciesData, private.ErrLog)	or {};		-- it works!
	private.dmp.talents		= private.trycall(private.GetTalentsData, private.ErrLog)		or {};		-- it works!
	private.dmp.professions = private.trycall(private.GetProfessionsData, private.ErrLog)	or {};		-- it works!
	private.dmp.mounts		= private.trycall(private.GetMountsData, private.ErrLog)		or {};		-- it works!
	private.dmp.critters	= private.trycall(private.GetCrittersData, private.ErrLog)		or {};		-- it works!
--	private.dmp.achievements = private.trycall(private.GetAchievementsData, private.ErrLog)	or {};	-- Development
--	private.dmp.statistics	= private.trycall(private.GetStatisticsData, private.ErrLog)	or {}; -- implement into achievements
	private.dmp.inventory   = private.trycall(private.GetInventoryData, private.ErrLog)		or {};		-- it works!

	return myJSON.encode(private.dmp);
end



--[[

function private._GETAchievments(list)
    local retTbl = {}
    list = list[1]

    for a, b in pairs(list) do
        for i = 1 , GetCategoryNumAchievements(b) do
            IDNumber, Name, Points, Completed, Month, Day, Year, _, _, _, isGuildAch = GetAchievementInfo(b,i)
            if IDNumber then
				local posixtime = 0

                if Completed then
                    posixtime = time{year = 2000 + Year, month = Month, day = Day}
                end

                retTbl[tostring(IDNumber)] = {["name"] = Name, ["points"] = Points, ["completed"] = Completed, [date] = posixtime}
            end
        end
    end

    return retTbl;
end

function private.GetAchievements()
    local retTbl = {}

	retTbl.achiev = private._GETAchievments({GetCategoryList()})
    retTbl.stats = private._GETAchievments({GetStatisticsCategoryList()})

    private.ILog("Achievements DONE...");
    return retTbl;
end

function private.GetSpellData()
    local retTbl = {}
	for i = 1, MAX_SKILLLINE_TABS do
        local name, _, _, offset, _ = GetSpellTabInfo(i);
		if not name then
            break;
        end
		for s = offset + 1, offset + 700 do
			spellInfo = GetSpellLink(s, BOOKTYPE_SPELL);
			if spellInfo ~= nil then
				for spellid in string.gmatch(GetSpellLink(s, BOOKTYPE_SPELL),".-Hspell:(%d+).*") do
                   retTbl[name] = spellid;
                end
			end
		end
	end
	private.ILog("Spells DONE...");
    return retTbl;
end


]]




function private.Log(str_in)
    print("\124c0080C0FF  "..str_in.."\124r");
end

function private.ErrLog(err_in)
    private.errlog = private.errlog or ""
    private.errlog = private.errlog .. "err=" .. err_in .. "\n"
    print("\124c00FF0000"..(err_in or "nil").."\124r");
end

function private.GetCharDump()
    return private.CreateCharDump();
end

function private.ILog(str_in)
    print("\124c0080FF80"..str_in.."\124r");
end

function private.trycall(f,herr)
    local status, result = xpcall(f,herr)
    if status then
        return result;
    end
    return status;
end

function private.SaveCharData(data_in)
    private.ILog("DUMP COMPLETE...\nDump gespeichert im WoW Ordner \\WTF\\Account\\%Username%\\SavedVariables\\chardump.lua");
    CHDMP_DATA  = data_in
end

function private.TradeSkillFrame_OnShow_Hook(frame, force)
    if private.done == true then
        return
    end
    if frame and frame.GetName and frame:GetName() == "TradeSkillFrame" then
        local isLink, _ = IsTradeSkillLinked();
        if isLink == nil then
            local link = GetTradeSkillListLink();
            if not link then
                return
            end
            local skillname = link:match("%[(.-)%]");
            private.dmp = private.dmp or {};
            private.dmp.skilllink = private.dmp.skilllink or {};
            private.dmp.skilllink[skillname] = link;
            print("TradeSkillFrame_Show",skillname,link)
            private.SaveCharData(private.Encode(private.GetCharDump()))
        end
    end
end

SLASH_CHDMP1 = "/chardump";
SlashCmdList["CHDMP"] = function(msg)
    if msg == "done" then
        private.done = true;
        return;
    elseif msg == "help" then
        return;
    else
        private.done = false;
    end
    if not private.tradeskillframehooked then
        hooksecurefunc(_G, "ShowUIPanel", private.TradeSkillFrame_OnShow_Hook);
        private.tradeskillframehooked = true;
    end
    private.SaveCharData(private.GetCharDump())
end