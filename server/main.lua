ESX = nil

TriggerEvent(Config.SharedObject, function(obj)
	ESX = obj
end)

math.randomseed(os.time()) 

function getCustomBadge()
    local numBase0 = math.random(100,999)
    local num = string.format("3%05d", numBase0)
	return num
end

ESX.RegisterServerCallback('dv_badges:getOnlinePlayers', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source     = xPlayer.source,
			identifier = xPlayer.identifier,
			name       = xPlayer.name,
			job        = xPlayer.job
		})
	end

	cb(players)
end)

RegisterCommand(Config.BadgeCommand, function(source, args, rawCommand)
    local badgeid = getCustomBadge()
    local xPlayer = ESX.GetPlayerFromId(source)
  
    MySQL.Async.execute('UPDATE users SET badge_id = @badge_id WHERE identifer = @identifier', { 
        ['@badge_id'] = badge_id,
        ['identifier'] = xPlayer.identifier    
    })
    print("asdadasd")
end, false)

function getIdentity(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
    if result[1] ~= nil then
        local identity = result[1]
        return identity
    else
        return nil
    end
end

function getBirth(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT dateofbirth FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
    if result[1] ~= nil then
        return result[1]
    else
        return nil
    end
end

ESX.RegisterServerCallback('dv_badges:getPlayerData', function(source,target,cb)
    local player = ESX.GetPlayerFromId(player)
    if player ~= nil then
        local identifier = GetPlayerIdentifiers(player)[1]
        
        local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
            ['@identifier'] = identifier
        })
        
        local user = result[1]
        local firstname = user['firstname']
        local lastname = user['lastname']
        
        local data = {
            name = GetPlayerName(player),
            job = xPlayer.job,
            firstname = firstname,
            lastname = lastname
        }
        cb(data)
    end
end)

dvbadges = {}

local Webhook = Config.Webhook
local Profile = "https://i.imgur.com/CyFGInF.png"

RegisterNetEvent('dv_badges:AddPoliceBadge')
AddEventHandler('dv_badges:AddPoliceBadge',function(code)
xPlayer = ESX.GetPlayerFromId(source)
if xPlayer.job.name == Config.PoliceJob then
            if not Config.Es_Extended_1_2 and Config.ShowBadgesID and Config.EnableLog then 
                dvbadges[source] = '~w~[~b~#' .. code ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. source .. ' | ' .. GetCharacterName(source)
                PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'Jelvény Rendszer', avatar_url = Profile, content = '```css\n[dv_badges]\n``````ini\n[Név: ' .. xPlayer.name .. '] - használta a Rendőrésgi jelvény jelzést!\n```'}), { ['Content-Type'] = 'application/json' })
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
            if Config.Es_Extended_1_2 and Config.ShowBadgesID and Config.EnableLog then 
                dvbadges[source] = '~w~[~b~#' .. code ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. source .. ' | ' .. xPlayer.getName(source)
                PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'Jelvény Rendszer', avatar_url = Profile, content = '```css\n[dv_badges]\n``````ini\n[Név: ' .. xPlayer.name .. '] - használta a Rendőrésgi jelvény jelzést!\n```'}), { ['Content-Type'] = 'application/json' })
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
            if not Config.Es_Extended_1_2 and not Config.ShowBadgesID and Config.EnableLog then 
                dvbadges[source] = '~w~[~b~#' .. code ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. GetCharacterName(source)
                PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'Jelvény Rendszer', avatar_url = Profile, content = '```css\n[dv_badges]\n``````ini\n[Név: ' .. xPlayer.name .. '] - használta a Rendőrésgi jelvény jelzést!\n```'}), { ['Content-Type'] = 'application/json' })
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
            if Config.Es_Extended_1_2 and not Config.ShowBadgesID and Config.EnableLog then 
                dvbadges[source] = '~w~[~b~#' .. code ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. xPlayer.getName(source)
                PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'Jelvény Rendszer', avatar_url = Profile, content = '```css\n[dv_badges]\n``````ini\n[Név: ' .. xPlayer.name .. '] - használta a Rendőrésgi jelvény jelzést!\n```'}), { ['Content-Type'] = 'application/json' })
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
            if not Config.Es_Extended_1_2 and Config.ShowBadgesID and not Config.EnableLog then 
                dvbadges[source] = '~w~[~b~#' .. code ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. source .. ' | ' .. GetCharacterName(source)
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
            if Config.Es_Extended_1_2 and Config.ShowBadgesID and not Config.EnableLog then 
                dvbadges[source] = '~w~[~b~#' .. code ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. source .. ' | ' .. xPlayer.getName(source)
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
            if not Config.Es_Extended_1_2 and not Config.ShowBadgesID and not Config.EnableLog then 
                dvbadges[source] = '~w~[~b~#' .. code ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. GetCharacterName(source)
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
             end
             if Config.Es_Extended_1_2 and not Config.ShowBadgesID and not Config.EnableLog then 
                dvbadges[source] = '~w~[~b~#' .. code ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. xPlayer.getName(source)
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
             end
    end
end)

RegisterNetEvent('dv_badges:AddAmbulanceBadge')
AddEventHandler('dv_badges:AddAmbulanceBadge',function()
xPlayer = ESX.GetPlayerFromId(source)
if xPlayer.job.name == Config.AmbulanceJob then
            if not Config.Es_Extended_1_2 and Config.ShowBadgesID and Config.EnableLog then
                PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'Jelvény Rendszer', avatar_url = Profile, content = '```css\n[dv_badges]\n``````ini\n[Név: '.. xPlayer.name ..'] - használta a Mentős jelvény jelzést!\n```'}), { ['Content-Type'] = 'application/json' })
                dvbadges[source] = '~r~' .. xPlayer.job.label .. ' ~w~- ~r~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. source .. ' | ' .. GetCharacterName(source)
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
            if Config.Es_Extended_1_2 and Config.ShowBadgesID and Config.EnableLog then
                PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'Jelvény Rendszer', avatar_url = Profile, content = '```css\n[dv_badges]\n``````ini\n[Név: '.. xPlayer.name ..'] - használta a Mentős jelvény jelzést!\n```'}), { ['Content-Type'] = 'application/json' })
                dvbadges[source] = '~r~' .. xPlayer.job.label .. ' ~w~- ~r~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. source .. ' | ' .. xPlayer.getName(source)
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
            if not Config.Es_Extended_1_2 and Config.ShowBadgesID and not Config.EnableLog then 
                dvbadges[source] = '~r~' .. xPlayer.job.label .. ' ~w~- ~r~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. source .. ' | ' .. GetCharacterName(source)
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
            if Config.Es_Extended_1_2 and Config.ShowBadgesID and not Config.EnableLog then 
                dvbadges[source] = '~r~' .. xPlayer.job.label .. ' ~w~- ~r~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. source .. ' | ' .. xPlayer.getName(source)
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
            if not Config.Es_Extended_1_2 and Config.EnableLog and not Config.ShowBadgesID then 
                PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'Jelvény Rendszer', avatar_url = Profile, content = '```css\n[dv_badges]\n``````ini\n[Név: '.. xPlayer.name ..'] - használta a Mentős jelvény jelzést!\n```'}), { ['Content-Type'] = 'application/json' })
                dvbadges[source] = '~r~' .. xPlayer.job.label .. ' ~w~- ~r~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. GetCharacterName(source)
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
            if Config.Es_Extended_1_2 and Config.EnableLog and not Config.ShowBadgesID then 
                PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'Jelvény Rendszer', avatar_url = Profile, content = '```css\n[dv_badges]\n``````ini\n[Név: '.. xPlayer.name ..'] - használta a Mentős jelvény jelzést!\n```'}), { ['Content-Type'] = 'application/json' })
                dvbadges[source] = '~r~' .. xPlayer.job.label .. ' ~w~- ~r~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. xPlayer.getName(source)
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
            if not Config.Es_Extended_1_2 and not Config.EnableLog and not Config.ShowBadgesID then 
                dvbadges[source] = '~r~' .. xPlayer.job.label .. ' ~w~- ~r~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. GetCharacterName(source)
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
            if Config.Es_Extended_1_2 and not Config.EnableLog and not Config.ShowBadgesID then 
                dvbadges[source] = '~r~' .. xPlayer.job.label .. ' ~w~- ~r~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. xPlayer.getName(source)
                TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
            end
    end
end)

function GetCharacterName(source1)
    local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
        ['@identifier'] = GetPlayerIdentifiers(source)[1]
    })

    if result[1] and result[1].firstname and result[1].lastname then
        return ('%s %s'):format(result[1].firstname, result[1].lastname)
    end
end

RegisterNetEvent('dv_badges:RemoveBadge')
AddEventHandler('dv_badges:RemoveBadge',function()
dvbadges[source] = nil
TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
end)

AddEventHandler('playerDropped', function()
dvbadges[source] = nil
TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
end)

function generateBadgeId()
    local numBase0 = math.random(100,999)
    local num = string.format("1%04d", numBase0)
	return num
end

RegisterNetEvent('dv_badges:AddBadge')
AddEventHandler('dv_badges:AddBadge',function(badge_id)
    local xPlayer = ESX.GetPlayerFromId(source)
     if Config.SQLBadges then  
        if xPlayer.job.name == Config.PoliceJob then
                    if not Config.Es_Extended_1_2 and Config.ShowBadgesID and Config.EnableLog then 
                        dvbadges[source] = '~w~[~b~#' .. badge_id ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. source .. ' | ' .. GetCharacterName(source)
                        PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'Jelvény Rendszer', avatar_url = Profile, content = '```css\n[dv_badges]\n``````ini\n[Név: ' .. xPlayer.name .. '] - használta a Rendőrésgi jelvény jelzést!\n```'}), { ['Content-Type'] = 'application/json' })
                        TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
                    end
                    if Config.Es_Extended_1_2 and Config.ShowBadgesID and Config.EnableLog then 
                        dvbadges[source] = '~w~[~b~#' .. badge_id ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. source .. ' | ' .. xPlayer.getName(source)
                        PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'Jelvény Rendszer', avatar_url = Profile, content = '```css\n[dv_badges]\n``````ini\n[Név: ' .. xPlayer.name .. '] - használta a Rendőrésgi jelvény jelzést!\n```'}), { ['Content-Type'] = 'application/json' })
                        TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
                    end
                    if not Config.Es_Extended_1_2 and not Config.ShowBadgesID and Config.EnableLog then 
                        dvbadges[source] = '~w~[~b~#' .. badge_id ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. GetCharacterName(source)
                        PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'Jelvény Rendszer', avatar_url = Profile, content = '```css\n[dv_badges]\n``````ini\n[Név: ' .. xPlayer.name .. '] - használta a Rendőrésgi jelvény jelzést!\n```'}), { ['Content-Type'] = 'application/json' })
                        TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
                    end
                    if Config.Es_Extended_1_2 and not Config.ShowBadgesID and Config.EnableLog then 
                        dvbadges[source] = '~w~[~b~#' .. badge_id ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. xPlayer.getName(source)
                        PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'Jelvény Rendszer', avatar_url = Profile, content = '```css\n[dv_badges]\n``````ini\n[Név: ' .. xPlayer.name .. '] - használta a Rendőrésgi jelvény jelzést!\n```'}), { ['Content-Type'] = 'application/json' })
                        TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
                    end
                    if not Config.Es_Extended_1_2 and Config.ShowBadgesID and not Config.EnableLog then 
                        dvbadges[source] = '~w~[~b~#' .. badge_id ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. source .. ' | ' .. GetCharacterName(source)
                        TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
                    end
                    if Config.Es_Extended_1_2 and Config.ShowBadgesID and not Config.EnableLog then 
                        dvbadges[source] = '~w~[~b~#' .. badge_id ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. source .. ' | ' .. xPlayer.getName(source)
                        TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
                    end
                    if not Config.Es_Extended_1_2 and not Config.ShowBadgesID and not Config.EnableLog then 
                        dvbadges[source] = '~w~[~b~#' .. badge_id ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. GetCharacterName(source)
                        TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
                    end
                    if Config.Es_Extended_1_2 and not Config.ShowBadgesID and not Config.EnableLog then 
                        dvbadges[source] = '~w~[~b~#' .. badge_id ..  '~w~] ~w~| ~b~' .. xPlayer.job.label .. ' ~w~- ~b~' .. xPlayer.job.grade_label .. '~n~ ~w~' .. xPlayer.getName(source)
                        TriggerClientEvent('dv_badges:UpdateBadge',-1,dvbadges)
                    end
                end
    end
end)

RegisterCommand(Config.GetBadgeCommand, function(source, args, rawCommand)
    local badge_id = generateBadgeId()
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute('UPDATE users SET badge_id = @badge_id WHERE identifier = @identifier', {
		['@badge_id'] = badge_id,
		['@identifier'] = xPlayer.identifier
	})

    if Config.EnableLog then 
        PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'Jelvény Rendszer', avatar_url = Profile, content = '```css\n[dv_badges]\n``````ini\n[Név: ' .. xPlayer.name .. '] - új jelvényszámot hozott létre!\n```'}), { ['Content-Type'] = 'application/json' })
    end

end, false)

ESX.RegisterServerCallback('dv_getjelvenyszam', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT badge_id FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1].badge_id ~= nil then
			cb(result[1].badge_id)
		else
			cb('')
		end
	end)	
end)

ESX.RegisterServerCallback('dv_badges:GetBadges',function(cb)
cb(dvbadges)
end)