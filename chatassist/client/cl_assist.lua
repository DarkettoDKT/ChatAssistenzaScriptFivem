
ESX = nil

local pos_before_assist,assisting,assist_target,last_assist,IsFirstSpawn = nil, false, nil, nil, true


RegisterNetEvent('chat:addMessage1')
AddEventHandler('chat:addMessage1', function(message)
  if group and group ~= "user" then
    SendNUIMessage({
      type = 'ON_MESSAGE',
      message = message
    })
  end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	SetNuiFocus(false, false)
end)

-- Darketto Chat in assistenza system

RegisterNetEvent("Chatassistenza:accettaAssist")
AddEventHandler("Chatassistenza:accettaAssist",function(t,pos)
	if assisting then return end
	local target = GetPlayerFromServerId(t)
	if target then
		if not pos then pos = NetworkGetPlayerCoords(target) end
		local ped = GetPlayerPed(-1)
		pos_before_assist = GetEntityCoords(ped)
		assisting = true
		assist_target = t
		--ESX.Game.Teleport(ped,pos+vector3(0,0.5,0))
	end
end)

RegisterNetEvent("Chatassistenza:assistFatta")
AddEventHandler("Chatassistenza:assistFatta",function()
	if assisting then
		assisting = false
		if pos_before_assist~=nil then --ESX.Game.Teleport(GetPlayerPed(-1),pos_before_assist+vector3(0,0.5,0)); pos_before_assist = nil 
		
		end
		assist_target = nil
	end
end)


RegisterNetEvent("Chatassistenza:richiestaChatAssist")
AddEventHandler("Chatassistenza:richiestaChatAssist",function(tn,t)
	SendNUIMessage({show=true,window="assistreq",data=Config.popassistformat:format(GetPlayerName(GetPlayerFromServerId(t)),t)})
	last_assist=t
end)

RegisterNetEvent("Chatassistenza:hideAssistPopup")
AddEventHandler("Chatassistenza:hideAssistPopup",function(t)
	SendNUIMessage({hide=true})
	last_assist=nil
end)


-- RICHIESTA IN ARRIVO A CHI è STAFF

TriggerEvent('chat:addSuggestion', '/dmlist assist', 'Solo staff mostra le richieste di supporto via chat',{})
TriggerEvent('chat:addSuggestion', '/dmdecansist', 'Nascondi popup richiesta via supporto chat',{})
TriggerEvent('chat:addSuggestion', '/dmassist', 'Richiedi assistenza via chat dello staff',{})
TriggerEvent('chat:addSuggestion', '/dmcansist', 'Annulla la tua richiesta di supporto chat con lo staff',{})
TriggerEvent('chat:addSuggestion', '/dmfinassist', 'Chiudi chat con lo staff',{})
TriggerEvent('chat:addSuggestion', '/dmaccassist', 'Accetta la richiesta di un player per chattare in dm', {{name="ID player", help="ID del player che vuoi aiutare"}})
TriggerEvent('chat:addSuggestion', '/dmchat', 'per chattare in dm', {{name="ID player", help="ID del player con cui vuoi chattare"}})