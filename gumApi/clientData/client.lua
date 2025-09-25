local hit = 0
local coords = 0
local entity = 0
local gumApi = {}
local buttons = {}
local allNPCData = {}
local allNPCSpawned = {}
local allNPCChecker = {}
local allBlips = {}
local targetEnable = false
local notifyTable = {}
local points = {}
local inPolyCreator = false
local allPrompts = {}
local allButtonsPrompts = {}
local isShowed = false

RegisterNetEvent('getApi')
AddEventHandler('getApi', function(cb)
	cb(gumApi)
end)


RegisterCommand("polyPoint", function(source, args, rawCommand)
    local playerPos = GetEntityCoords(PlayerPedId())
    if inPolyCreator == false then
		inPolyCreator = true
		table.insert(points, vector3(playerPos.x, playerPos.y, playerPos.z))
		print("New point added: " .. playerPos.x .. ", " .. playerPos.y .. ", " .. playerPos.z)
	else
		inPolyCreator = false
		print("All points cleared.")
		points = {}
	end
end, false)
local hoverEnabled = false
Citizen.CreateThread(function()
    while true do
		local optimize = 100
		hit, coords, entity, coordsTarget = RayCastGamePlayCamera(5.0)
		local showEyeHover = false
		if hit then
			gumApi.getTarget()
			if targetEnable == true then
				optimize = gumApi.fpsTimer()*2
				if entity ~= 0 and GetEntityModel(entity) ~= 0 then
					showEyeHover = true
					if not hoverEnabled then
						hoverEnabled = true
						SendNUIMessage({type = 'hitEye', status = true})
					end
				end
			end
			if Config.EyeKey then
				if Citizen.InvokeNative(0x530944F6F4B8A214, PlayerPedId()) then
					if Citizen.InvokeNative(0xF3A21BCD95725A4A, 0, Config.EyeKey) and not targetEnable then
						targetEnable = true
						SendNUIMessage({type = 'drawEye', status = true})
					end
				end
				if Citizen.InvokeNative(0x648EE3E7F38877DD, 0, Config.EyeKey) and targetEnable then
					targetEnable = false
					SendNUIMessage({type = 'drawEye', status = false})
				end
				if targetEnable and (Citizen.InvokeNative(0xF3A21BCD95725A4A, 0, 0x7065027D) or Citizen.InvokeNative(0xF3A21BCD95725A4A, 0, 0xB4E465B4) or Citizen.InvokeNative(0xF3A21BCD95725A4A, 0, 0xD27782E3) or Citizen.InvokeNative(0xF3A21BCD95725A4A, 0, 0x8FD015D8)) then
					targetEnable = false
					SendNUIMessage({type = 'drawEye', status = false})
				end
			end
		end
		if #points ~= 0 then
			optimize = gumApi.fpsTimer()
			local coords = GetEntityCoords(PlayerPedId())
			gumApi.IsPlayerInsidePolygon(coords, points, true)
			if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0x07B8BEAF) then
				table.insert(points, vector3(coords.x, coords.y, coords.z))
				SendNUIMessage({type = "copyPoly", status = bool, points = points})
			end
		end
		if not showEyeHover and hoverEnabled then
			hoverEnabled = false
			SendNUIMessage({type = 'hitEye',status = false})
		end
        Citizen.Wait(optimize)
    end
end)

RegisterCommand(""..Config.EyeCommand.."", function(source, args, rawCommand)
	if targetEnable == false then
		targetEnable = true
		SendNUIMessage({type = 'drawEye',status = true})
	else
		targetEnable = false
		SendNUIMessage({type = 'drawEye',status = false})
	end
end)

function gumApi.getFolder()
	return Config.FolderWithIcons
end

function gumApi.hideWeapons() 
    local ped = PlayerPedId()
    Citizen.InvokeNative(0xFCCC886EDE3C63EC, ped, false, false, false)
    local _, wepHash = GetCurrentPedWeapon(ped, true, 0, true)
    while not _ do
        _, wepHash = GetCurrentPedWeapon(ped, true, 0, true)
        Wait(0)
    end
end

function gumApi.drawMe(x, y, z, text, dist, marker)
	local playerCoords = GetEntityCoords(PlayerPedId())
	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, x, y, z, true) < dist then
		local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
		local px,py,pz=table.unpack(GetGameplayCamCoord())  
		local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
		local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
		if onScreen then
			SetTextScale(0.30, 0.30)
			SetTextFontForCurrentCommand(1)
			SetTextColor(180, 180, 240, 205)
			SetTextCentre(1)
			DisplayText(str,_x,_y)
			local factor = (string.len(text)) / 225
			-- DrawSprite("feeds", "toast_bg", _x+0.01, _y+0.0125,0.0155+ factor, 0.03, 0.1, 1, 1, 1, 190, 0)
			if marker ~= nil then
				Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, x, y, z-1.0, 0, 0, 0, 0, 0, 0, 1.3, 1.3, 0.4, 255, 200, 122, 155, 0, 0, 2, 0, 0, 0, 0)
			end
		end
	end
end

function gumApi.playerNearCoords(x, y, z, dist, mark)
	local inCoords = false
	local playerCoords = GetEntityCoords(PlayerPedId())
	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, x, y, z, true) < dist and GetEntityHealth(PlayerPedId()) ~= 0 and GetMount(PlayerPedId()) == 0 and GetVehiclePedIsUsing(PlayerPedId()) == 0 then
		inCoords = true
		if mark then
			Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, x, y, z-1.0, 0, 0, 0, 0, 0, 0, dist*2.0, dist*2.0, 0.4, 255, 200, 122, 155, 0, 0, 2, 0, 0, 0, 0)
		end
	end
	return inCoords
end

function gumApi.checkPlayersNearEntity(entity, distance)
    local isNearPlayer = false
    for k,v in pairs(getPlayers()) do
        local entityCoords = GetEntityCoords(entity)
        local playerCoords = GetEntityCoords(GetPlayerPed(v))
        if GetDistanceBetweenCoords(entityCoords.x, entityCoords.y, entityCoords.z, playerCoords.x, playerCoords.y, playerCoords.z, false) < distance then
            if PlayerPedId() ~= GetPlayerPed(v) then
                isNearPlayer = true
            end
        end
    end
    return isNearPlayer
end

function gumApi.groundCheck(x, y)
	local retval, whereGround = nil, nil
	for height = 1, 1000 do
		retval, whereGround = GetGroundZAndNormalFor_3dCoord(x, y, height+0.0)
		if retval then
			return whereGround
		end
	end
	return 0.0
end

--   https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures/blips
--   https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures/blips_mp
function gumApi.createBlip(text, x, y, z, sprite)
	local blip = N_0x554d9d53f696d002(1664425300, x, y, z)
	SetBlipSprite(blip, sprite, 1)
	SetBlipScale(blip, 0.5)
	Citizen.InvokeNative(0x9CB1A1623062F402, blip, text)
	table.insert(allBlips, blip)
end
local lastVehicle = 0
function gumApi.createVehicle(model, x, y, z, h)
	local modelHash = GetHashKey(model)
	RequestModel(modelHash)
	while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, modelHash, Citizen.ResultAsBoolean) do
		Wait(5)
	end
	local createdVehicle = Citizen.InvokeNative(0xAF35D0D2583051B0, modelHash, x,y,z,h, true, false, 0, 1)
	while not DoesEntityExist(entity2) do
		Citizen.Wait(5)
	end
	SetModelAsNoLongerNeeded(modelHash)
	SetEntityAsMissionEntity(createdVehicle, true, true)
	SetVehicleOnGroundProperly(createdVehicle)
	lastVehicle = createdVehicle
end

function gumApi.fpsTimer()
    local minFPS = 15
    local maxFPS = 165
    local minSpeed = 0
    local maxSpeed = 15
    local coefficient = 1 - (getFPS() - minFPS) / (maxFPS - minFPS)
    local result = minSpeed + coefficient * (maxSpeed - minSpeed)
    local reducedResult = result * 0.6
    return reducedResult
end

function getFPS()
	local frameTime = GetFrameTime()
    local frame = 1.0 / frameTime
	return frame
end

function gumApi.getLastVehicle()
    return lastVehicle
end

-- https://github.com/femga/rdr3_discoveries/tree/master/Controls
-- Hold mode Hashes: SHORT_TIMED_EVENT_MP, SHORT_TIMED_EVENT, MEDIUM_TIMED_EVENT, LONG_TIMED_EVENT, RUSTLING_CALM_TIMING, PLAYER_FOCUS_TIMING, PLAYER_REACTION_TIMING

function gumApi.showPrompt(name, prompt, show)
    if prompt ~= nil then
        if show == false then
            allPrompts[prompt] = false
        else
            allPrompts[prompt] = name
        end
    end
end


function gumApi.createPrompt(text, key, promptHash, holdMode, event)
	if buttons[text..promptHash] == nil then
		buttonPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
		PromptSetControlAction(buttonPrompt, key)
		PromptSetText(buttonPrompt, CreateVarString(10, 'LITERAL_STRING', text))
		PromptSetEnabled(buttonPrompt, true)
		PromptSetVisible(buttonPrompt, true)
		if holdMode == false then
			PromptSetHoldMode(buttonPrompt, false)
		else
			PromptSetStandardizedHoldMode(buttonPrompt, GetHashKey(holdMode))
		end
		PromptSetGroup(buttonPrompt, promptHash)
		PromptRegisterEnd(buttonPrompt)
		buttons[text..promptHash] = buttonPrompt
		if allButtonsPrompts[promptHash] == nil then
			allButtonsPrompts[promptHash] = {}
	
			table.insert(allButtonsPrompts[promptHash], {buttonPrompt, event, key})
		else
			table.insert(allButtonsPrompts[promptHash], {buttonPrompt, event, key})
		end
	end
end

function gumApi.promptDelete(text, promptHash)
	if buttons[text..promptHash] ~= nil then
		PromptDelete(buttons[text..promptHash])
		buttons[text..promptHash] = nil
	end
end

function gumApi.setPromptVisible(text, hash, state)
	if state then
		PromptSetVisible(buttons[text..hash], true)
	else
		PromptSetVisible(buttons[text..hash], false)
	end
end

function gumApi.getPrompt(promptHash, text)
	PromptSetActiveGroupThisFrame(promptHash, CreateVarString(10, 'LITERAL_STRING', ""..text..""))
end
local promptIsActive = false
Citizen.CreateThread(function()
	while true do
		local optimize = 300
		promptIsActive = false
		if Config.EyePromptOnly then
			if hoverEnabled then
				for a,b in pairs(allPrompts) do
					if b ~= false then
						optimize = gumApi.fpsTimer()
						PromptSetActiveGroupThisFrame(a, CreateVarString(10, 'LITERAL_STRING', ""..b..""))
						promptIsActive = true
						if allButtonsPrompts[a] ~= nil then
							for c,d in pairs(allButtonsPrompts[a]) do
								if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, d[3]) and Citizen.InvokeNative(0x0D00EDDFB58B7F28, d[1]) and d ~= nil and d[2] ~= nil then
									gumApi.setPromptEnable(d[1], a, false)
									TriggerEvent(d[2])
									targetEnable = false
									SendNUIMessage({type = 'drawEye',status = false})
								end
							end
							break
						end
					end
				end
			end
		else
			if not Citizen.InvokeNative(0x4859F1FC66A6278E, PlayerPedId()) or IsEntityDead(PlayerPedId()) then
				for a,b in pairs(allPrompts) do
					if b ~= false then
						optimize = gumApi.fpsTimer()
						PromptSetActiveGroupThisFrame(a, CreateVarString(10, 'LITERAL_STRING', ""..b..""))
						promptIsActive = true
						if allButtonsPrompts[a] ~= nil then
							for c,d in pairs(allButtonsPrompts[a]) do
								if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, d[3]) and Citizen.InvokeNative(0x0D00EDDFB58B7F28, d[1]) and d ~= nil and d[2] ~= nil then
									gumApi.setPromptEnable(d[1], a, false)
									TriggerEvent(d[2])
									targetEnable = false
									SendNUIMessage({type = 'drawEye',status = false})
								end
							end
							break
						end
					end
				end
			end
		end
		Citizen.Wait(optimize)
	end
end)
function gumApi.getActivePrompt()
    return promptIsActive
end

function gumApi.getPromptButton(text, promptHash)
	local isComplete = false
	local button = buttons[text..promptHash]
	if Citizen.InvokeNative(0xE0F65F0640EF0617, buttons[text..promptHash]) then
		isComplete = true
		Citizen.InvokeNative(0xFC094EF26DD153FA, promptGroup)
		Citizen.InvokeNative(0xF1622CE88A1946FB)
	end
	return isComplete
end

function gumApi.setPromptEnable(text, hash, state)
	if state == true then
		Citizen.InvokeNative(0x8A0FB4D03A630D21, buttons[text..hash], true)
	else
		Citizen.InvokeNative(0x8A0FB4D03A630D21, buttons[text..hash], false)
	end
end
function gumApi.getPromptButtonData(text, promptHash)
	local isComplete = false
	local button = buttons[text..promptHash]
	return button
end

function gumApi.getTarget()
    return coords, entity, coordsTarget
end

function gumApi.createPed(model,x,y,z,h,dist,scenario)
	local random = math.random(1,99999999999999)
	table.insert(allNPCData, {model=model, dist=dist, x=x, y=y, z=z, h=h, scenario=scenario, spawnChecker=random})
end

function gumApi.getAllPeds()
	return GetGamePool('CPed')
end

function gumApi.getAllEntities()
	return GetGamePool('CObject')
end

function gumApi.getAllVehicles()
	return GetGamePool('CVehicle')
end

function gumApi.getTime()
	return GetClockHours(), GetClockMinutes()
end


function gumApi.playAnim(entity, dict, name, flag, time)
	RequestAnimDict(dict)
	local waitSkip = 0
	while not HasAnimDictLoaded(dict) do
		waitSkip = waitSkip + 1
		if waitSkip > 100 then
			break
		end
		Citizen.Wait(0)
	end
	TaskPlayAnim(entity, dict, name, 1.0, 1.0, time, flag, 0, true, 0, false, 0, false)  
end

function gumApi.deleteObj(obj)
	if obj and DoesEntityExist(obj) then
		SetEntityAsMissionEntity(obj, false, true)
		
		if NetworkGetEntityIsNetworked(obj) then
			NetworkRequestControlOfEntity(obj)
			
			local timeout = 0
			while not NetworkHasControlOfEntity(obj) do
				timeout = timeout + 1
				if timeout > 10 then
					break
				end
				Wait(100)
			end
		end
		
		if NetworkHasControlOfEntity(obj) or not NetworkGetEntityIsNetworked(obj) then
			DeleteEntity(obj)
		end
	end
end

function gumApi.deletePed(obj)
    if obj and DoesEntityExist(obj) then
		SetEntityAsMissionEntity(obj, false, true)
		
		if NetworkGetEntityIsNetworked(obj) then
			NetworkRequestControlOfEntity(obj)
			
			local timeout = 0
			while not NetworkHasControlOfEntity(obj) do
				timeout = timeout + 1
				if timeout > 10 then
					break
				end
				Wait(100)
			end
		end
		
		if NetworkHasControlOfEntity(obj) or not NetworkGetEntityIsNetworked(obj) then
			DeletePed(obj)
		end
    end
end

function spawnNPC(model, x, y, z, h, dist, scenario, spawnChecker)
	if allNPCChecker[spawnChecker] == nil then
		allNPCChecker[spawnChecker] = true
		local npcSpawn = model
		while not HasModelLoaded(GetHashKey(npcSpawn)) do
			Wait(0)
			modelRequest( GetHashKey(npcSpawn) )
		end
		npcSpawnCode = CreatePed(GetHashKey(npcSpawn), x, y, z, h, false, false, 0, 0)
		while not DoesEntityExist(npcSpawnCode) do
			Wait(0)
		end
		allNPCSpawned[npcSpawnCode] = {dist, spawnChecker}
		Citizen.InvokeNative(0x283978A15512B2FE, npcSpawnCode, true)
		SetPedAsGroupMember(npcSpawnCode, GetPedGroupIndex(PlayerPedId()))
		SetBlockingOfNonTemporaryEvents(npcSpawnCode,true)
		FreezeEntityPosition(npcSpawnCode, true)
		SetEntityInvincible(npcSpawnCode, true)
		TaskStandStill(npcSpawnCode, -1)
		SetEntityAsMissionEntity(npcSpawnCode, true, true)
		SetModelAsNoLongerNeeded(GetHashKey(npcSpawnCode))
		ClearPedEnvDirt(npcSpawnCode)
		ClearPedDamageDecalByZone(npcSpawnCode ,10 ,"ALL")
		ClearPedBloodDamage(npcSpawnCode)
		if scenario ~= nil then
			TaskStartScenarioInPlace(npcSpawnCode, GetHashKey(scenario), 0,1)
		end
	end
end

RegisterNetEvent('gum_notify:notify')
AddEventHandler('gum_notify:notify', function(title, subtext, icon, duration)
    show_notification(true, title, subtext, icon, duration)
end)

function gumApi.notify(title, text, img, time)
	TriggerEvent("gum_notify:notify", title, text, img, time)
end

function show_notification(bool, title_text, subtext_text, icon_text, duration)
    table.insert(notifyTable, {bool, title_text, subtext_text, icon_text, duration})
end

function delete_show_notification(bool)
    SendNUIMessage({type = "notify", status = bool, folder= Config.FolderWithIcons})
end

local cancelValue = nil
local answerValue = nil
function gumApi.getAnswer(title, first, second, cb)
	SetNuiFocus(true, true);
	SendNUIMessage({type= "open_answer", status = true, title = title, first=first, second=second});
	while answerValue == nil do
        if answerValue ~= nil then
			break
		end
        if cancelValue then
            SetNuiFocus(false, false);
            cancelValue = nil
            return false
        end
		Citizen.Wait(0)
	end
	SendNUIMessage({type= "open_answer", status = false})
	SetNuiFocus(false, false);
    local backUpValue = answerValue
    answerValue = nil
    cb(backUpValue)
end

RegisterNUICallback('cancelAnswer', function(data, cb)
    cancelValue = true
end)

RegisterNUICallback('yes', function(data, cb)
	answerValue = true
end)

RegisterNUICallback('no', function(data, cb)
	answerValue = false
end)

local inputValue = nil
function gumApi.getInput(title, subtext, cb)
	SetNuiFocus(true, true);
	SendNUIMessage({type= "open_inputs", status = true, title = subtext, subtext = title})
    while inputValue == nil do
        if inputValue then
			break
		end
		Citizen.Wait(0)
	end
    local cacheValue = nil
    cacheValue = inputValue
    inputValue = nil
    SendNUIMessage({type= "open_inputs", status = false})
	SetNuiFocus(false, false);
	cb(cacheValue)
end

RegisterNUICallback('button_1', function(data, cb)
	inputValue = "close"
end)

RegisterNUICallback('button_2', function(data, cb)
	inputValue = data.text
end)

local getData = false
local inputDatas = {}
function gumApi.getInputs(data, cb)
	inputDatas = data
	SetNuiFocus(true, true)
	SendNUIMessage({
		type = 'open_multipleinputs',
		data = data
	})

	while not getData do
		if getData then
			break
		end
		Citizen.Wait(100)
	end
	getData = false
	cb(inputDatas) 
end

RegisterNUICallback('multipleinputs', function(data, cb)
	SetNuiFocus(false, false)
	inputDatas = data.inputData
	getData = true
end)


Citizen.CreateThread(function()
    while true do
        for a,b in pairs(notifyTable) do
            SendNUIMessage({type = "notify",status = b[1],title = b[2],text = b[3],id = b[4], folder= Config.FolderWithIcons})
            Citizen.Wait(tonumber(b[5]))
            table.remove(notifyTable, a)
            delete_show_notification(false)
        end
        Citizen.Wait(100)
    end
end)

function gumApi.getLastPed()
    return npcSpawnCode
end

function modelRequest(model)
    Citizen.CreateThread(function()
        RequestModel(model)
    end)
end

function getPlayers()
	local players = {}
	for i = 0, 32 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, i)
		end
	end
	return players
end
function gumApi.getPlayers()
	local players = {}
	for i = 0, 32 do
		if NetworkIsPlayerActive(i) then
            table.insert(players, GetPlayerServerId(i))
		end
	end
	return players
end


function RotationToDirection(rotation)
	local adjustedRotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function RayCastGamePlayCamera(distance)
	local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination = 
	{ 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 1))
	return b, c, e, vector3(destination.x, destination.y, destination.z)
end


function deleteObj(obj, check)
	local timeout = 0
	if obj ~= nil and obj ~= false then
		SetEntityAsMissionEntity(obj, false, true)
		NetworkRequestControlOfEntity(obj)
		while not NetworkHasControlOfEntity(obj) do
			timeout = timeout+1
			if timeout > 10 then
				break
			end
			if not DoesEntityExist(obj) then
				break
			end
			Wait(100)
		end
		if NetworkHasControlOfEntity(obj) then
		end
		DeleteEntity(obj)
		allNPCSpawned[obj] = nil
		allNPCChecker[check] = nil
	end
end

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		for a,b in pairs(allNPCSpawned) do
			deleteObj(a, b[2])
		end
		for a,b in pairs(allBlips) do
			RemoveBlip(b)
		end
	end
end)


function gumApi.IsPlayerInsidePolygon(playerPos, polyPoints, debug, issmall)
    local oddNodes = false
    local x, y = playerPos.x, playerPos.y

    for i = 1, #polyPoints do
        if debug then
            local start = vector3(polyPoints[i].x, polyPoints[i].y, polyPoints[i].z + 4.5)
            local finish = vector3(polyPoints[i % #polyPoints + 1].x, polyPoints[i % #polyPoints + 1].y, polyPoints[i % #polyPoints + 1].z + 4.5)
            local label = tostring(i)
            gumApi.drawMe(polyPoints[i].x, polyPoints[i].y, polyPoints[i].z + 1.0, label, 4.0)
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, polyPoints[i].x, polyPoints[i].y, polyPoints[i].z - 1.0, 0, 0, 0, 0, 0, 0, 0.05, 0.05, 4.0, 255, 255, 255, 100, 0, 0, 2, 0, 0, 0, 0)
        end

        if issmall then
            local start = vector3(polyPoints[i].x, polyPoints[i].y, polyPoints[i].z + 0.2)
            local finish = vector3(polyPoints[i % #polyPoints + 1].x, polyPoints[i % #polyPoints + 1].y, polyPoints[i % #polyPoints + 1].z + 0.2)
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, polyPoints[i].x, polyPoints[i].y, polyPoints[i].z - 1.0, 0, 0, 0, 0, 0, 0, 0.01, 0.01, 4.0, 255, 255, 255, 100, 0, 0, 2, 0, 0, 0, 0)
        end

      	local j = i % #polyPoints + 1
        if ((polyPoints[i].y <= y and polyPoints[j].y > y) or (polyPoints[j].y <= y and polyPoints[i].y > y)) then
            if (polyPoints[i].x + (y - polyPoints[i].y) / (polyPoints[j].y - polyPoints[i].y) * (polyPoints[j].x - polyPoints[i].x) < x) then
                oddNodes = not oddNodes
            end
        end
    end

    return oddNodes
end





function gumApi.calculatePolygonLength(polyPoints)
    local length = 0.0
    local prevPoint = polyPoints[#polyPoints]
    for _, point in ipairs(polyPoints) do
        length = length + #(point - prevPoint)
        prevPoint = point
    end
	return string.format("%.2f", length)
end

function DrawLine(x, y, z, _x, _y, _z, r, g, b, a)
	Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, x, y, z, _x, _y, _z, r, g, b, a)
end


----CORE LOAD

RegisterNetEvent("gum:SelectedCharacter")
AddEventHandler("gum:SelectedCharacter", function(charid)
    Citizen.Wait(2000)
    TriggerServerEvent("gumApi:checkLogin")
end)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
    Citizen.Wait(2000)
    TriggerServerEvent("gumApi:checkLogin")
end)

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
	Citizen.Wait(2000)
	TriggerServerEvent("gumApi:checkLogin")
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	Citizen.Wait(2000)
	TriggerServerEvent("gumApi:checkLogin")
end)

RegisterNetEvent('gumApi:createStash')
AddEventHandler('gumApi:createStash', function(id, size)
	TriggerEvent("inventory:client:SetCurrentStash", id)
	TriggerServerEvent("inventoryOpenInventory", "stash", id, { maxweight = size*1000, slots = invSlots, })
end)
RegisterNetEvent('gumApi:openStash')
AddEventHandler('gumApi:openStash', function(id,size)
	TriggerServerEvent("inventory:server:OpenInventory", "stash", id, { maxweight = size*1000, slots = invSlots, })
end)