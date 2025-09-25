local HouseInfo = {}
local RoomInfo = {}
local VorpInv = exports.vorp_inventory:vorp_inventoryApi()
local VORPcore = exports.vorp_core:GetCore()

-------------- Register Inventory -----------
AddEventHandler("onResourceStart", function(resourcename)
	if GetCurrentResourceName() ~= resourcename then
		return
	end
	if Config.debug then
		print("SOURCE STARTED")
	end
	for k, loc in pairs(Config.Rooms) do
		VorpInv.registerInventory(loc.key, loc.Name, loc.MaxWeight, true, true, true)
	end
	for k, loc in pairs(Config.Houses) do
		VorpInv.registerInventory(loc.key, loc.Name, loc.MaxWeight, true, true, true)
	end
	if Config.debug then
		print("INVENTORY REGISTERED")
	end
	HouseInfo = Config.Houses
	RoomInfo  = Config.Rooms
end)

-------------- Load Rooms ---------------
VORPcore.addRpcCallback("Vorp_housing:getrooms", function(source, cb, args)
	MySQL.query('SELECT * FROM rooms', {}, function(result)
		if result[1] then
			return cb(result) -- Success
		else
			return cb(nil) -- No Rooms
		end
	end)
end)

-------- Load Houses ----------
VORPcore.addRpcCallback("Vorp_housing:gethouses", function(source, cb, args)
	MySQL.query('SELECT * FROM housing', {}, function(result)
		if result[1] then
			return cb(result) -- Success
		else
			return cb(nil) -- No Houses
		end
	end)
end)

--------- Buy House ------------
VORPcore.addRpcCallback("Vorp_housing:buyhouse", function(source, cb, args)
	local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter
	local money = Character.money
	local price = args.Price
	---- returns > 1 = succes , 2 = another player bought before , 3 = no money
	if money >= price then
		MySQL.query('SELECT * FROM housing WHERE id = ?', { args.Id }, function(result)
			--if result[1] then
			if result[1] then
				return cb(2) -- another player bought before
			else
				local Parameters = {
					["@id"] = args.Id,
					["@name"] = args.Name,
					["@identifier"] = Character.identifier,
					["@charidentifier"] = Character.charIdentifier,
					["@key"] = args.key
				}
				MySQL.query(
					"INSERT INTO `housing`(`id`, `name`, `identifier`, `charidentifier`, `key`) VALUES ( @id , @name , @identifier , @charidentifier , @key)",
					Parameters, function(result2) end)
				Character.removeCurrency(0, price)
				VorpInv.addItem(_source, args.key, 1, false)
				return cb(1) -- succes
			end
			--else
			--	return cb(nil) -- server nil
			--end
		end)
	else
		return cb(3) -- no money
	end
end)

--------- Buy Room ------------
VORPcore.addRpcCallback("Vorp_housing:buyrooms", function(source, cb, args)
	local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter
	local money = Character.money
	local price = args.Price
	---- returns > 1 = succes , 2 = another player bought before , 3 = no money
	if money >= price then
		MySQL.query('SELECT * FROM rooms WHERE id = ?', { args.Id }, function(result)
			--	if result ~= nil then
			if result[1] ~= nil then
				return cb(2) -- another player bought before
			else
				local Parameters = {
					["@id"] = args.Id,
					["@name"] = args.Name,
					["@identifier"] = Character.identifier,
					["@charidentifier"] = Character.charIdentifier,
					["@key"] = args.key
				}
				MySQL.query(
					"INSERT INTO `rooms`(`id`, `name`, `identifier`, `charidentifier`, `key`) VALUES ( @id , @name , @identifier , @charidentifier , @key)",
					Parameters, function(result2)
					end)

				Character.removeCurrency(0, price)
				VorpInv.addItem(_source, args.key, 1, false)
				return cb(1) -- succes
			end
			--else
			--	return cb(nil) -- server nil
			--end
		end)
	else
		return cb(3) -- no money
	end
end)

---------- Give Key Command ---------
RegisterNetEvent("Vorp_housing:givekeys", function(id, key)
	local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter
	local charidentifier = Character.charIdentifier

	MySQL.query('SELECT key FROM housing WHERE charidentifier = ? AND id = ?', { charidentifier, id }, function(result)
		--if result ~= nil then
		if result[1] then
			VorpInv.addItem(_source, result[1].key, 1, false)
		end
		--end
	end)
end)

---------- Sell House Command ---------
RegisterNetEvent("Vorp_housing:sellhouse", function(id, key)
	local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter
	local charidentifier = Character.charIdentifier
	local sell = false
	MySQL.query('SELECT * FROM housing WHERE charidentifier = ? AND id = ?', { charidentifier, id }, function(result)
		if result[1] then
			for k, loc in pairs(Config.Rooms) do
				if loc.Id == id then
					sell = loc.sell
				end
			end
			for k, loc in pairs(Config.Houses) do
				if loc.Id == id then
					sell = loc.sell
				end
			end
			if sell then
				MySQL.query('DELETE FROM `housing` WHERE charidentifier = ? AND id = ?', { charidentifier, id },
					function(r)
						MySQL.query('SELECT * FROM housing WHERE charidentifier = ? AND id = ?', { charidentifier, id },
							function(result2)
								if result2[1] == nil then
									for k, loc in pairs(Config.Rooms) do
										if loc.Id == id then
											local lastprice = loc.Price * Config.SellPrice
											Character.addCurrency(0, lastprice)
											local keycount = VorpInv.getItemCount(_source, result[1].key, nil)
											if keycount > 0 then
												VorpInv.subItem(_source, result[1].key, keycount, nil)
											end
											Core.NotifyRightTip(_source, _U('sellhouse') .. lastprice, 4000)
										end
									end

									for k, loc in pairs(Config.Houses) do
										if loc.Id == id then
											local lastprice = loc.Price * Config.SellPrice
											Character.addCurrency(0, lastprice)
											local keycount = VorpInv.getItemCount(_source, result[1].key, nil)
											if keycount > 0 then
												VorpInv.subItem(_source, result[1].key, keycount, nil)
											end
											Core.NotifyRightTip(_source, _U('sellhouse') .. lastprice, 4000)
										end
									end
									TriggerClientEvent("vorp_housing:refreshall", _source)
								end
							end)
					end)
			else
				Core.NotifyObjective(_source, _U('dontsell'), 4000)
			end
		end
	end)
end)

--------- Open Inventory Rooms -------------------
RegisterNetEvent("Vorp_housing:GetInventoryRooms", function(id)
	local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter
	local charidentifier = Character.charIdentifier
	MySQL.query('SELECT * FROM rooms WHERE id = ? AND charidentifier = ?', { id, charidentifier }, function(result)
		if result[1] then
			if result[1].id == id then
				VorpInv.OpenInv(_source, result[1].key)
			end
		end
	end)
end)

--------- Open Inventory Housing-------------------
RegisterNetEvent("Vorp_housing:GetInventoryHouses", function(id)
	local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter
	local charidentifier = Character.charIdentifier
	MySQL.query('SELECT * FROM housing WHERE id = ? AND charidentifier = ?', { id, charidentifier }, function(result)
		if result[1] then
			VorpInv.OpenInv(_source, result[1].key)
		end
	end)
end)

------------------------------ Doors --------------------------------
RegisterNetEvent('Vorp_housing:Load', function()
	TriggerClientEvent('Vorp_housing:setStateHouse2', -1, HouseInfo)
	TriggerClientEvent('Vorp_housing:setStateRoom2', -1, RoomInfo)
end)

VORPcore.addRpcCallback("Vorp_housing:checkkey", function(source, cb, args)
	local _source = source
	local itemCount = VorpInv.getItemCount(_source, args, false)
	if itemCount > 0 then
		return cb(true)
	else
		return cb(false)
	end
end)

RegisterNetEvent('Vorp_housing:updateStatehouse', function(k, k2, state)
	HouseInfo[k].Doors[k2].locked = state
	TriggerClientEvent('Vorp_housing:setStateHouse', -1, k, k2, state)
end)

RegisterNetEvent('Vorp_housing:updateStateroom', function(k, k2, state)
	RoomInfo[k].Doors[k2].locked = state
	TriggerClientEvent('Vorp_housing:setStateRoom', -1, k, k2, state)
end)
