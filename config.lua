Config = {}

Config.SharedObject    =      'esx:getSharedObject'   -- SharedObject

Config.Es_Extended_1_2 =      true                    -- es_extended verió. Amennyiben 1.2-es verziónál régebbit használsz az érték legyen 'false', amennyiben újabb mint megyegezik 1.2 veriózval az érték 'true' legyen. (https://github.com/esx-framework/es_extended)

Config.Locale          =      'hu'                    -- Fordítás változtatása     

Config.PoliceJob       =      "police"                -- Rendőr Job neve
Config.AmbulanceJob    =      "ambulance"             -- Mentős Job neve

Config.Webhook         =      'webhook'               -- Discord Webhook, parancsok logolása.

Config.Font            =      8                       -- Jelvények betűtíusának változtatása. GTA Font Rendszer (1-10)

Config.BadgeCommand    =      "jelveny"               -- Mentős Jelvény Parancs neve.

Config.BadgeDistance   =      2.5                     -- Milyen távolról lehessen látni a jelvény feliratot.
Config.Height          =      0.98                    -- Jelvény pozíciónak állítása. (Magasság)
Config.BadgesInVehicle =      true                    -- Kimutassa járműben is a jelvényeket?
Config.ShowOwnBadge    =      true                    -- Kimutassa a jelvényt a saját fejed fölött is?

-- V2 --
Config.SQLBadges       =      false                   -- SQL mentés és generálás bekapcsolása a jelvényszámokhoz, amennyiben ez az érték "true" a saját jelvényszám használata nem fog működni. - Csak a rendőr jelvény jelzésre tartozik. 
Config.GetBadgeCommand =      "jelvenyszam"           -- Jelvényszám le és újragenerálásának parancsa. - Csak a rendőr jelvény jelzésre tartozik. 

Config.FelCommand      =      "jelfel"                -- Jelvény felrakásának parancsa, csak akkor szükséges ha a Config.SQLBadges értéke "true", amennyiben false a Config.BadgeCommandal egybe működni fog a fel és levétel is.
Config.LeCommand       =      "jelle"                 -- Jelvény levételének parancsa, csak akkor szükséges ha a Config.SQLBadges értéke "true", amennyiben false a Config.BadgeCommandal egybe működni fog a fel és felrakás is.

Config.EnableLog       =      false                   -- Jelvány logaltatás ki/be kapcsolása  
Config.ShowBadgesID    =      true                    -- Jelvény alatt ID-k megjelenítése.