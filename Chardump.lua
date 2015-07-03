local myJSON = json.json
CHDMP = CHDMP or {}
local private = {}

function private.GetGlobalInfo()
	local retTbl = {}
	local version, build, date, tocversion = GetBuildInfo();

	retTbl.version			= version;
	retTbl.locale           = GetLocale();
	retTbl.date      		= date;
	retTbl.realm            = GetRealmName();

	return retTbl;
end

function private.GetUnitInfo()
	local retTbl = {}
	local _, class          = UnitClass("player");
	local _, race           = UnitRace("player");

	retTbl.name             = UnitName("player");
	retTbl.race             = race;
	retTbl.gender           = UnitSex("player");
	retTbl.class            = class;
	retTbl.level            = UnitLevel("player");
	retTbl.money            = GetMoney();

	-- NOT IMPLEMENTED
--	currentTitle = GetCurrentTitle();

	return retTbl;
end

function private.GetRepData()
    local retTbl = {}

    for i = 1, GetNumFactions() do
        local name, _, _, _, _, earnedValue, _, _, _, _, _, _, _ = GetFactionInfo(i)
        retTbl[i] = {["name"] = name, ["points"] = earnedValue}
    end

    private.ILog("Reputations DONE...");
    return retTbl;
end

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

function private.GetGlyphData()
    local retTbl = {}

	for i = 1, NUM_GLYPH_SLOTS do
		local _, _, _, glyphSpellID, _ = GetGlyphSocketInfo(i);
		if glyphSpellID then
			retTbl[i] = {['id'] = glyphSpellID};
		end
	end

    private.ILog("Glyphs DONE...");
    return retTbl;
end

function private.GetMACData()
    local retTbl = {}

    for i = 1, GetNumCompanions("MOUNT") do
        local M = GetCompanionInfo("MOUNT", i);
        retTbl["M"..i] = M;
    end

    for i = 1, GetNumCompanions("CRITTER") do
        local C = GetCompanionInfo("CRITTER", i);
        retTbl["C"..i] = C;
    end

    private.ILog("Mounts & Critters DONE...");
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

function private.GetIData()
    local retTbl = {}

    for i = 1, 74 do
        itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            count = GetInventoryItemCount("player",i)
            for entry, chant, Gem1, Gem2, Gem3,unk1,unk2,unk3,lvl1 in string.gmatch(itemLink,".-Hitem:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+).*") do
                retTbl["0000:"..i] =  {["I"] = entry, ["C"] = count, ["G1"] = Gem1, ["G2"] = Gem2, ["G3"] = Gem3};
            end
        end
    end

    for bag = 0, 11 do
        for slot = 1, GetContainerNumSlots(bag) do
            ItemLink = GetContainerItemLink(bag, slot)
            if ItemLink then
                local texture, count, locked, quality, readable = GetContainerItemInfo(bag, slot);
                local p = bag + 1000;
                for entry, chant, Gem1, Gem2, Gem3, unk1, unk2, unk3, lvl1 in string.gmatch(ItemLink,".-Hitem:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+).*") do
                    retTbl[p..":"..slot] = {["I"] = entry, ["C"] = count, ["G1"] = Gem1, ["G2"] = Gem2, ["G3"] = Gem3};
                end
            end
        end
    end

    private.ILog("Inventory DONE...");
    return retTbl;
end

function private.GetTitleData()
    local retTbl = {}

    for i = 1, GetNumTitles() do
		if IsTitleKnown(i) == 1 then
			titleName = GetTitleName(i);
			retTbl[tostring(i)] = GetTitleName(i);
		end
    end

    private.ILog("Title DONE...");
    return retTbl
end

function private.GetCurrencyData()
    local retTbl = {}

    for i = 1, GetCurrencyListSize() do
        local name, _, _, _, _, count, _, _, _ = GetCurrencyListInfo(i)
		retTbl[i] = {['name'] = name, ['count'] = count};
    end

	private.ILog("Currency DONE...");
    return retTbl;
end

function private.GetGuildData()
	local retTbl = {}

	if IsInGuild() == "" then
		local guildName, guildRankName, guildRankIndex = GetGuildInfo("player");
		print(guildName);
	end

    return retTbl;
end

function private.CreateCharDump()
	private.dmp = {};
	private.dmp.global		= private.trycall(private.GetGlobalInfo, private.ErrLog)    or {};
	private.dmp.unit		= private.trycall(private.GetUnitInfo, private.ErrLog)      or {};
	private.dmp.rep         = private.trycall(private.GetRepData, private.ErrLog)       or {};
	private.dmp.awards      = private.trycall(private.GetAchievements, private.ErrLog)  or {};
	private.dmp.glyphs      = private.trycall(private.GetGlyphData, private.ErrLog)     or {};
	private.dmp.creature    = private.trycall(private.GetMACData, private.ErrLog)       or {};
	private.dmp.spells      = private.trycall(private.GetSpellData, private.ErrLog)     or {};
	--	private.dmp.skills      = private.trycall(private.GetSkills, private.ErrLog)        or {}; -- Hier prüfen warum spells  und skills Berufe haben
	--	private.dmp.inventory   = private.trycall(private.GetIData, private.ErrLog)         or {};
	private.dmp.title       = private.trycall(private.GetTitleData, private.ErrLog)     or {};
	--	private.dmp.quest       = private.trycall(private.GetQuestData, private.ErrLog)     or {}; -- Benötigt die initialisierung methode
	private.dmp.currency    = private.trycall(private.GetCurrencyData, private.ErrLog)  or {};

    return myJSON.encode(private.dmp);
end

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