ESX = nil
loaded = false

Citizen.CreateThread(function()
  while ESX == nil do
      TriggerEvent(Config.SharedObject, function(obj) ESX = obj end)
      Citizen.Wait(0)
  end

  while ESX.GetPlayerData().job == nil do
      Citizen.Wait(11)
  end
  loaded = true
  PlayerData = ESX.GetPlayerData()
end)

----- # BADGES #-----

local dvbadges = {}
local IsShowingBadge = false
local BadgeCode = 0

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('playerSpawned')
AddEventHandler('playerSpawned', function()
    while ESX == nil do Wait(0) end
    loaded = true
      PlayerData = ESX.GetPlayerData()
        ESX.TriggerServerCallback('dv_badges:GetBadges',function(badges)
      ESX.TriggerServerCallback('dv_getjelvenyszam',function(badges)
      dvbadges = badges
    end)
  end)
 TriggerEvent('dv_badges:UpdateBadge',-1,dvbadges)
end)

RegisterCommand(Config.FelCommand, function(source, args, rawCommand)
  ESX.TriggerServerCallback('dv_getjelvenyszam', function(badge_id)
      TriggerServerEvent('dv_badges:AddBadge',badge_id)
  end)
end, false)

RegisterCommand(Config.LeCommand, function(source, args, rawCommand)
    TriggerServerEvent('dv_badges:RemoveBadge')
  end)

function DrawText3DBadge(x,y,z, text, r,g,b) 
    local showing,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px,py,pz)-vector3(x,y,z))
 
    local andaze = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local andaze = andaze*fov
   
    if showing then
        SetTextScale(0.25, 0.25)
        SetTextFont(Config.Font)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

RegisterNetEvent('dv_badges:UpdateBadge')
AddEventHandler('dv_badges:UpdateBadge',function(updateBadges)
dvbadges = updateBadges
end)

RegisterCommand(Config.BadgeCommand, function(source,args)
while PlayerData.job == nil do
Citizen.Wait(11)
end
      if not Config.SQLBadges then 
        if PlayerData.job.name == Config.PoliceJob then --and PlayerData.job.grade_name == 'boss' then
           if args[1] then
             if tonumber(args[1]) then
                if not IsShowingBadge then
                IsShowingBadge = true
                
			        	TriggerServerEvent('dv_badges:AddPoliceBadge',args[1])
                ESX.ShowNotification(_U('badge_added'))
                BadgeCode = args[1]
                else
                IsShowingBadge = false
			        	BadgeCode = args[0]
                ESX.ShowNotification(_U('badge_off'))
                TriggerServerEvent('dv_badges:RemoveBadge') 
                end
              else
            
               ESX.ShowNotification(_U('badge_error'))
            
              end
        else
          ESX.ShowNotification(_U('not_allowed')	)
        end
    else
        if not Config.SQLBadges then 
          if PlayerData.job.name == Config.AmbulanceJob then --and PlayerData.job.grade_name == 'boss' then
            if not IsShowingBadge then
              IsShowingBadge = true
              TriggerServerEvent('dv_badges:AddAmbulanceBadge')
              ESX.ShowNotification(_U('badge_added'))
            else
              IsShowingBadge = false
              ESX.ShowNotification(_U('badge_off'))
              TriggerServerEvent('dv_badges:RemoveBadge') 
              end
        else
        ESX.ShowNotification(_U('not_allowed'))
        end
      end
      end
  end
end,false)
TriggerEvent('chat:addSuggestion', Config.BadgeCommand, 'Jelvény Rendszer', {
{ name="Jelvény rendszer",help = "!"}
})

Citizen.CreateThread(function()
Citizen.Wait(500)
    while true do 
      for _, id in ipairs(GetActivePlayers()) do
	 
         local serverid = GetPlayerServerId(id)
		   if dvbadges[serverid] then
		     if id ~= PlayerId() then
		      local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id)),GetEntityCoords(PlayerPedId()))
			  if dist < Config.BadgeDistance then
			  if not IsPedInAnyVehicle(GetPlayerPed(id)) or Config.BadgesInVehicle then
			  x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(id),true))
          DrawText3DBadge(x,y,z+Config.Height,dvbadges[serverid],3,4,155)
			  end
             end
			elseif id == PlayerId() and Config.ShowOwnBadge then
             
			  if not IsPedInAnyVehicle(GetPlayerPed(id)) or Config.BadgesInVehicle then
			  x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(id),true))
          DrawText3DBadge(x,y,z+Config.Height,dvbadges[serverid],3,4,155)
			  end
			
            end
         end
     end
	Citizen.Wait(0) 
    end
end)