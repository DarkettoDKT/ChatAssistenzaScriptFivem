ESX = nil 

--Darketto Chat Call admin
local open_assists,active_assists = {},{}
function split(s, delimiter)result = {};for match in (s..delimiter):gmatch("(.-)"..delimiter) do table.insert(result, match) end return result end

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


AddEventHandler("playerDropped",function(reason)
    if open_assists[source] then open_assists[source]=nil end
    for k,v in ipairs(active_assists) do
        if v==source then
            active_assists[k]=nil
            TriggerClientEvent("chat:addMessage",k,{color={60,255,191},multiline=false,args={"Supporto Chat"," L'admin che ti stava aiutando è crashato dal server"}})
            return
        elseif k==source then
            TriggerClientEvent("Chatassistenza:accettaAssist",v)
            TriggerClientEvent("chat:addMessage",v,{color={60,255,191},multiline=false,args={"Supporto Staff"," Il player che stavi aiutando è crashato dal server"}})
            active_assists[k]=nil
            return
        end
    end
end)


RegisterCommand('dmfinassist', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if isAdmin(xPlayer) then
        local found = false
        for k,v in pairs(active_assists) do
            if v==source then
                found = true
                active_assists[k]=nil
                TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Staff"," Supporto Via chat concluso, Lo staff ha chiuso la tua richiesta è stata data come risolta"}})
                TriggerClientEvent("Chatassistenza:accettaAssist",source)
            end
        end
        if not found then TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Staff"," Non stai aiutando nessuno"}}) end
    else
        TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Staff"," Non hai il permesso per usare questo comando!"}})
    end
end)

--LISTA RICHIESTA VIA CHAT IN SOSPESO

RegisterCommand("dmlist", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if isAdmin(xPlayer) then
            if args[1]=="assist" then
                local openassistsmsg,activeassistsmsg = "",""
                for k,v in pairs(open_assists) do
                   -- print("questo", open_assists)
                    openassistsmsg=openassistsmsg.."^5ID "..k.." (" .."Giocatore:"..GetPlayerName(k)..")^7  \n"
                end
                    for k,v in pairs(active_assists) do
                        activeassistsmsg=activeassistsmsg.."^5ID "..k.." (" .."Giocatore:"..GetPlayerName(k)..")^7 - "..v.." ("..GetPlayerName(v)..")\n"
                    end
            TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=true,args={"Staff ","Supporto via chat in sospeso:\n"..(openassistsmsg~="" and openassistsmsg or "^1Nessuna chat di supporto in sospeso")}})
            TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=true,args={"Staff ","Supporto via chat attivo:\n"..(activeassistsmsg~="" and activeassistsmsg or "^1Nessuna chat di supporto attiva")}})
            end
    else
        TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Staff ","Non hai i permessi!"}})
    end
end)


RegisterCommand('dmassist', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local time = os.date('%H:%M')
    playerName = xPlayer.getName()

    if not open_assists[source] and not active_assists[source] then
    local ac = TrovaStaff(function(admin) TriggerClientEvent("Chatassistenza:richiestaChatAssist",admin,GetPlayerName(source),source);  TriggerClientEvent("chat:addMessage",admin,{color={0,255,255},multiline=Config.chatassistformat:find("\n")~=nil,args={"Supporto Staff",Config.chatassistformat:format(GetPlayerName(source),source)}}) end)
    


        

    
        -- Verifica se ci sono admin
        if ac>0 then
            open_assists[source]=true
            Citizen.SetTimeout(120000,function()
                if open_assists[source] then open_assists[source]=nil 
                
                end
                    if GetPlayerName(source) ~=nil then
                        --TriggerClientEvent('chat:addMessage', admin, {template = '<div class="chat-message azione"><i class="fab fa-azione"></i> <b><span style="color: #2aa9e0">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',args = { playerName, message, time }})
                    end
            end)
            TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Chat","^2Richiesta di assistenza inviata (scade tra 120sec), scrivi^7 ^1/cansist^7 ^2per cancellare la tua richiesta^7"}})
        else
            TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Chat"," lo Staff al momento non è disponibile"}})

        end
    else
        TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Chat"," Qualcuno sta già chattando con te o hai già una richiesta di chat in sospeso"}})
    end
end)



-- Comando che permette di chattare
RegisterCommand('dmstaff', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    local src = source
    
    local getTime = '<b>' .. os.date("%H:%M") .. '</b> | '
    --print(xtarget)
    playerName = xPlayer.getName()
   
    if havePermission(xPlayer) then
        if args[1] then
            local xAll = ESX.GetPlayers()
		    for i=1, #xAll, 1 do
		        local xTarget = ESX.GetPlayerFromId(xAll[i])
                if havePermission(xTarget) then
                
                    TriggerClientEvent('chat:addMessage', xTarget.source, {
                    template = '<div class="chat-message">' ..getTime.. '<i class="fas fa-hammer" style= margin-right:3px;color:#ff4444;"></i><span class="msgprefix"><span class="staff">STAFF PRIVATA</span>{0}: </span>{1}</div>',
                    args = {"["..source.."]".." ".. GetPlayerName(src), table.concat(args, " ")}
                    })      
                end 
            end   
        end    
    else
        TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Chat ","^1Non hai i permessi necessari per chattare con lo staff^7"}})     
    end
end)

function havePermission(xPlayer, exclude)	-- you can exclude rank(s) from having permission to specific commands 	[exclude only take tables]
	if exclude and type(exclude) ~= 'table' then exclude = nil;print("^3[esx_admin] ^1ERROR ^0exclude argument is not table..^0") end	-- will prevent from errors if you pass wrong argument

	local playerGroup = xPlayer.getGroup()
	for k,v in pairs(Config.Staff) do
		if v == playerGroup then
			if not exclude then
				return true
			else
				for a,b in pairs(exclude) do
					if b == v then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end


-- Comando che permette di chattare
    RegisterCommand('dmchat', function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)
        local src = source
        local ac = TrovaStaff(function(admin)  end)
        local target = tonumber(args[1])
        local _target = target
        local xTarget = ESX.GetPlayerFromId(target)
    
        
        local getTime = '<b>' .. os.date("%H:%M") .. '</b> | '
        --print(xtarget)
        playerName = xPlayer.getName()
       
        if  not open_assists[source] and active_assists[source] or not open_assists[target] and  active_assists[target]  then
   
            if xTarget then
                if ac>0 then
                    table.remove(args, 1)
                
                    --print("ac è maggiore di 0")

                    if ESX.GetPlayerFromId(src).getGroup() ~= "user"  then
                        --print("STAFF UTENTE")

                        TriggerClientEvent('chat:addMessage', source, {
                            template = '<div class="chat-message">' ..getTime.. '<i class="fas fa-hammer" style= margin-right:3px;color:#ff4444;"></i><span class="msgprefix"><span class="staff">STAFF DM</span>{0}: </span>{1}</div>',
                            args = {"["..source.."]".." ".. GetPlayerName(src), table.concat(args, " ")}
                        })
                        TriggerClientEvent('chat:addMessage', target, {
                            template = '<div class="chat-message">' ..getTime.. '<i class="fas fa-hammer" style= margin-right:3px;color:#ff4444;"></i><span class="msgprefix"><span class="staff">STAFF DM</span>{0}: </span>{1}</div>',
                            args = {"["..source.."]".." ".. GetPlayerName(src), table.concat(args, " ")}
                            })
                    else
               
                        TriggerClientEvent('chat:addMessage', source, {
                            template = '<div class="chat-message">' ..getTime..  '<i class="fas fa-comments"></i><span class="msgprefix"><span class="staff">DM</span>{0}: </span>{1}</div>',
                            args = {"["..source.."]".." ".. GetPlayerName(src), table.concat(args, " ")}
                            })
    
                        TriggerClientEvent('chat:addMessage', target, {
                            template = '<div class="chat-message">' ..getTime.. '<i class="fas fa-comments"></i><span class="msgprefix"><span class="staff">DM</span>{0}: </span>{1}</div>',
                            args = {"["..source.."]".." ".. GetPlayerName(src), table.concat(args, " ")}
                            })
                        
                    end
                        --[[TriggerClientEvent('chat:addMessage', target, {
                            template = '<div class="chat-message">' ..getTime.. '<i class="fas fa-hammer" style= margin-right:3px;color:#ff4444;"></i><span class="msgprefix"><span class="staff">STAFF DM</span>{0}: </span>{1}</div>',
                            args = {"["..target.."]".." ".. GetPlayerName(src), table.concat(args, " ")}
                            })--]]
        
                end
            else
                TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Chat ","ID Del giocatore inserito non valido"}})
            end
        else
            TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Chat ","Non puoi chattare perchè non è aperta nessuna richiesta"}})
        end
end)



function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

function getOsDate()
    return os.date("%H:%M")
end
--TriggerClientEvent('chat:addMessage', admin, {template = '<div class="chat-message azione"><i class="fab fa-azione"></i> <b><span style="color: #2aa9e0">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',args = { playerName, message, time }})



-- Darketto annulla la tua richiesta
RegisterCommand('dmaccassist', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = tonumber(args[1])
   
    accettatarichiestaDM(xPlayer,target)
end)

function accettatarichiestaDM(xPlayer, target)

    if isAdmin(xPlayer) then
        local source = xPlayer.source
        for k,v in pairs(active_assists) do
            if v==source then
                TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Chat"," Stai già aiutando qualcuno"}})
                return
            end
        end
        if open_assists[target] and not active_assists[target] then
            open_assists[target]=nil
            active_assists[target]=source
            TriggerClientEvent("Chatassistenza:accettaAssist",source,target)
            TriggerClientEvent("Chatassistenza:hideAssistPopup",source)
            TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Chat Staffer"," Connessione alla chat con il player effettuata con ^2successo^7 digita ^1/dmchat^7 per parlare"}})
        elseif not open_assists[target] and active_assists[target] and active_assists[target]~=source then
            TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Chat Staffer"," Qualcuno sta già aiutando questo player"}})
        else
            TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Chat Staffer"," Il player con questo id non ha richiesto assistenza"}})
        end
    else
        TriggerClientEvent("chat:addMessage",source,{color={60,255,191},multiline=false,args={"Supporto Chat Staffer"," Non hai il permesso per usare questo comando!"}})
    end
end


RegisterCommand("dmdecansist",function(a,b,c)
    TriggerEvent("Chatassistenza:hideAssistPopup")
end, false)

RegisterCommand("dmcansist", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if open_assists[source] then
        open_assists[source]=nil
        xPlayer.showNotification("Richiesta chat con lo staff cancellata con successo")
        TrovaStaff(function(admin) TriggerClientEvent("Chatassistenza:hideAssistPopup",admin) end)
    else
        xPlayer.showNotification("Non hai richieste di supporto via chat in sospeso")
    end
end)





    function TrovaStaff(func)
    
        local ac = 0

        for k,v in ipairs(ESX.GetPlayers()) do
            --print(v)
            if isAdmin(ESX.GetPlayerFromId(v)) then
                ac = ac + 1
                func(v)
            end
        end
        return ac
    end

function isAdmin(xPlayer)
    for k,v in ipairs(Config.Staff) do
        if xPlayer.getGroup()==v then --print(v)--]]   
            return true end
    
    end
    return false
end
