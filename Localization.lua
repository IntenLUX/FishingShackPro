local debug = false
--[===[@debug@
debug = true
--@end-debug@]===]

local L, _, ns = {}, ...
setmetatable(L, { __index = function(t, k) t[k] = k return k end })
ns.L = L

-- Please feel free to suggest updates / corrections to the localizations below via 
-- http://wow.curseforge.com/addons/fishing-shack-pro/localization/

local CURRENT_LOCALE = GetLocale()
-- English (enUS)
if CURRENT_LOCALE == "enUS" then return end

-- Brazilian Portuguese (ptBR)
if CURRENT_LOCALE == "ptBR" then
L["Now using"] = "Agor vestindo" -- Needs review
L["replaced by"] = "foi substituído com" -- Needs review
L["UPGRADE!"] = "ATUALIZAÇÃO" -- Needs review

end

-- French (frFR)
if CURRENT_LOCALE == "frFR" then
L["Now using"] = "Maintenant porter" -- Needs review
L["replaced by"] = "a été remplacé par" -- Needs review
L["UPGRADE!"] = "SURCLASSEMENT!" -- Needs review
end

-- German (deDE)
if CURRENT_LOCALE == "deDE" then
L["Now using"] = "jetzt tragen" -- Needs review
L["replaced by"] = "wurde ersetzt durch" -- Needs review
L["UPGRADE!"] = "VERBESSERUNG!" -- Needs review

end

-- Italian (itIT)
if CURRENT_LOCALE == "itIT" then
L["Now using"] = "ora indossa" -- Needs review
L["replaced by"] = "sostituito da" -- Needs review
L["UPGRADE!"] = "UPGRADE !" -- Needs review

end

-- Korean (koKR)
if CURRENT_LOCALE == "koKR" then
L["Now using"] = "Now using" -- Requires localization
L["replaced by"] = "replaced by" -- Requires localization
L["UPGRADE!"] = "UPGRADE!" -- Requires localization

end

-- Latin American Spanish (esMX)
if CURRENT_LOCALE == "esMX" then
L["Now using"] = "ahora llevaba" -- Needs review
L["replaced by"] = "reemplazado con" -- Needs review
L["UPGRADE!"] = "MODERNIZACIÓN" -- Needs review

end

-- Russian (ruRU)
if CURRENT_LOCALE == "ruRU" then
L["Now using"] = "Now using" -- Requires localization
L["replaced by"] = "replaced by" -- Requires localization
L["UPGRADE!"] = "UPGRADE!" -- Requires localization

end

-- Simplified Chinese (zhCN)
if CURRENT_LOCALE == "zhCN" then
L["Now using"] = "Now using" -- Requires localization
L["replaced by"] = "replaced by" -- Requires localization
L["UPGRADE!"] = "UPGRADE!" -- Requires localization

end

-- Spanish (esES)
if CURRENT_LOCALE == "esES" then
L["Now using"] = "ahora llevaba" -- Needs review
L["replaced by"] = "fue reemplazado con" -- Needs review
L["UPGRADE!"] = "MODERNIZACIÓN" -- Needs review

end

-- Traditional Chinese (zhTW)
if CURRENT_LOCALE == "zhTW" then
L["Now using"] = "Now using" -- Requires localization
L["replaced by"] = "replaced by" -- Requires localization
L["UPGRADE!"] = "UPGRADE!" -- Requires localization

end