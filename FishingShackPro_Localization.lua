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
return end

if LOCALE == "deDE" then
	L["UPGRADE_WARN"] = "AKTUALISIERUNG! "
	L["UPGRADE_TEXT"] = " wurde ersetzt durch "
return end

if LOCALE == "frFR" then
	L["UPGRADE_WARN"] = "SURCLASSEMENT! "
	L["UPGRADE_TEXT"] = " a été remplacé par "
return end

if LOCALE == "esES" or LOCALE == "esMX" then
	L["UPGRADE_WARN"] = "MODERNIZACIÓN! "
	L["UPGRADE_TEXT"] = " fue reemplazado con "
return end

if LOCALE == "ptBR" then -- also ptPT
	L["UPGRADE_WARN"] = "ATUALIZAÇÃO! "
	L["UPGRADE_TEXT"] = " foi substituído com "
return end

if LOCALE == "ruRU" then
	L["UPGRADE_WARN"] = "ОБНОВИТЬ! "
	L["UPGRADE_TEXT"] = " был заменен "
return end

if LOCALE == "koKR" then
	L["UPGRADE_WARN"] = "업그레이드! "
	L["UPGRADE_TEXT"] = " 로 대체 "
return end

if LOCALE == "zhCN" then
	L["UPGRADE_WARN"] = "升级! "
	L["UPGRADE_TEXT"] = " 与更换 "
return end

if LOCALE == "zhTW" then
	L["UPGRADE_WARN"] = "升級! "
	L["UPGRADE_TEXT"] = " 與更換 "
return end