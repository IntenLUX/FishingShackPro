local _, ns = ...

local L = setmetatable({}, { __index = function(t, k)
	local v = tostring(k)
	rawset(t, k, v)
	return v
end })

ns.L = L

local LOCALE = GetLocale()

if LOCALE == "enUS" then -- also euGB
	L["UPGRADE_WARN"] = "UPGRADE! "
	L["UPGRADE_TEXT"] = " was replaced with "
	L["EQUIPPED_TEXT"] = "Now wearing: "
return end

if LOCALE == "deDE" then
	L["UPGRADE_WARN"] = "VERBESSERUNG! "
	L["UPGRADE_TEXT"] = " wurde ersetzt durch "
	L["EQUIPPED_TEXT"] = "jetzt tragen "
return end

if LOCALE == "frFR" then
	L["UPGRADE_WARN"] = "SURCLASSEMENT! "
	L["UPGRADE_TEXT"] = " a été remplacé par "
	L["EQUIPPED_TEXT"] = "Now wearing "
return end

if LOCALE == "esES" or LOCALE == "esMX" then
	L["UPGRADE_WARN"] = "MODERNIZACIÓN! "
	L["UPGRADE_TEXT"] = " fue reemplazado con "
	L["EQUIPPED_TEXT"] = "Maintenant porter "
return end

if LOCALE == "ptBR" then -- also ptPT
	L["UPGRADE_WARN"] = "ATUALIZAÇÃO! "
	L["UPGRADE_TEXT"] = " foi substituído com "
	L["EQUIPPED_TEXT"] = "Agor vestindo "
return end

if LOCALE == "ruRU" then
	L["UPGRADE_WARN"] = "ОБНОВИТЬ! "
	L["UPGRADE_TEXT"] = " был заменен "
	L["EQUIPPED_TEXT"] = "Теперь носить "
return end

if LOCALE == "koKR" then
	L["UPGRADE_WARN"] = "업그레이드! "
	L["UPGRADE_TEXT"] = " 로 대체 "
	L["EQUIPPED_TEXT"] = "지금 입고 "
return end

if LOCALE == "zhCN" then
	L["UPGRADE_WARN"] = "升级! "
	L["UPGRADE_TEXT"] = " 与更换 "
	L["EQUIPPED_TEXT"] = "现在穿 "
return end

if LOCALE == "zhTW" then
	L["UPGRADE_WARN"] = "升級! "
	L["UPGRADE_TEXT"] = " 與更換 "
	L["EQUIPPED_TEXT"] = "現在穿 "
return end