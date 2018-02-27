include("items.lua")

local ply = FindMetaTable( "Player" )
util.AddNetworkString("database")
util.AddNetworkString("inv_drop")
util.AddNetworkString("inv_use")
util.AddNetworkString("inv_equip")
util.AddNetworkString("inv_dequip")
util.AddNetworkString("inv_attach")

function ply:ShortSteamID()

	local id = self:SteamID()
	local id = tostring(id)
	local id = string.Replace(id,"STEAM_0:0:", "")
	local id = string.Replace(id,"STEAM_0:1:", "")
	return id
end

function ply:databaseDefault()

	self:databaseSetValue( "money", 0 )
	self:databaseSetValue( "hunger", 100 )
	self:databaseSetValue( "thirst", 100 )
	self:databaseSetValue( "hotbar", {["fillervalue"] = {amount = 1}} )
	self:databaseSetValue( "attachments", {["fillervalue"] = {amount = 1}} )
	
	local i = {}
	i["fillervalue"] = { amount = 1 }
	i["soda1"] = { amount = 10 }
	i["soda2"] = { amount = 10 }
	i["glock"] = { amount = 1 }
	i["tritium"] = { amount = 5 }
	i["flashlight"] = { amount = 1 }
	i["melon"] = { amount = 1 }
	i["suppressor"] = {amount = 50}
	self:databaseSetValue("inventory", i)
end


function ply:databaseNetworkedData()

	local money = self:databaseGetValue("money")
	local hunger = self:databaseGetValue("hunger")
	local thirst = self:databaseGetValue("thirst")
	self:SetNWInt("money", money)
	self:SetNWInt("hunger", hunger)
	self:SetNWInt("thirst", thirst)
	
	self:KillSilent()
	self:Spawn() 
	
end

function ply:databaseFolders()

	return "server/wasteland/players/" .. self:ShortSteamID() .. "/"

end

function ply:databasePath()

	return self:databaseFolders() .. "database.txt"

end

function ply:databaseSet( tab )

	self.database = tab

end

function ply:databaseGet()

	return self.database
	
end

function ply:databaseCheck()

	self.database = {}
	
	local f = self:databaseExists()
	
	if f then
		self:databaseRead()
	else
		self:databaseCreate()
	end

	self:databaseSend()
	self:databaseNetworkedData()
	
end

function ply:databaseExists()

	local f = file.Exists(self:databasePath(), "DATA")
	return f

end

function ply:databaseRead()

	local str = file.Read(self:databasePath(), "DATA")
	
	self:databaseSet(util.KeyValuesToTable(str))

end

function ply:databaseSave()

	local str = util.TableToKeyValues(self.database)
	local f = file.Write(self:databasePath(), str)
	self:databaseSend()

end

function ply:databaseCreate()

	self:databaseDefault()
	local b = file.CreateDir( self:databaseFolders() )
	self:databaseSave()

end

function ply:databaseSend()

	net.Start("database")
		net.WriteTable( self:databaseGet() )
			net.Send( self )

end



function ply:databaseSetValue( name, v )

	if not v then return end
	
	if type(v) == "table" then
		if name == "inventory" or "hotbar" then
			for k,b in pairs(v) do
				if b.amount <= 0 then
					v[k] = nil
				end
			end
		end
	end
	
	local d = self:databaseGet()
	d[name] = v
	
	self:databaseSave()

end

function ply:databaseGetValue( name )

	local d = self:databaseGet()
	return d[name]

end

function ply:databaseDisconnect()

	self:databaseSave()

end

function ply:inventoryDisconnect()

	self:inventorySave()

end

function ply:hotbarDisconnect()

	self:inventoryHotbarSave()

end

function GM:ShowSpare2( ply )
	ply:ConCommand( "wl_inv" )
end

function ply:inventorySave( i )
	
	self:databaseSetValue( "inventory", i )
	
	
end

function ply:inventoryHotbarSave( i )
	
	self:databaseSetValue( "hotbar", i )
	
	
end

function ply:inventoryAttachmentSave( i )
	
	self:databaseSetValue( "attachments", i )
	
	
end

function ply:inventoryGet()

	local i = self:databaseGetValue("inventory")
	return i
end

function ply:inventoryHotbarGet()

	local i = self:databaseGetValue("hotbar")
	return i
	
end

function ply:inventoryHasItem( name, amount )

	if not amount then amount = 1 end
	
	local i = self:inventoryGet()
	
	if i then
		if i[name] then
			if i[name].amount >= amount then
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

function ply:inventoryHotbarHasItem( name )

	amount = 1 
	
	local i = self:inventoryHotbarGet()
	
	if i then
		if i[name] then
			if i[name].amount >= amount then
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

function ply:inventoryEquipHasSpace( name )

	amount = 1
	
	local i = self:inventoryBarGet()
	
	if i then
		if i[name] then
			if i[name].amount >= amount then
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

function ply:inventoryTakeItem( name, amount )

	if not amount then amount = 1 end
	
	local i = self:inventoryGet()
	
	local k = self:inventoryHotbarGet()
	
	if self:inventoryHasItem( name, amount ) then
	
		i[name].amount = i[name].amount - amount
		
		self:databaseSend()
		self:inventorySave(i)
		self:inventoryHotbarSave(k)
		
		return true
	else
		return false
	end
end

function ply:hotbarHasSpace()

	if table.Count(self:databaseGet("hotbar")) != 4 or !IsValid(self:databaseGet("hotbar")) then
		return true
	else
		return false
	end

end

function ply:inventoryGiveItem( name, amount )

	if not amount then amount = 1 end
	
	local i = self:inventoryGet()
	local k = self:inventoryHotbarGet()
	
	local item = getItems(name)
	
	if not item then return end
	
	if amount == 1 then
		self:PrintMessage(HUD_PRINTTALK, "You picked up a " .. item.name .. ".")
	elseif amount > 1 then
		self:PrintMessage(HUD_PRINTTALK, "You recieved " .. amount .. " " .. item.name .. "s.")
	end
	if self:inventoryHasItem( name, amount ) then
		i[name].amount = i[name].amount + amount
	else
		i[name] = {amount = amount}
	end
	
	self:databaseSend()
	self:inventorySave(i)
	self:inventoryHotbarSave(k)

end

function ply:inventoryHotbarGiveItem( name )

	amount = 1
	
	local i = self:inventoryHotbarGet()
	
	local k = self:inventoryGet()
	
	local item = getItems(name)
	
	if not item then return end
	
	
	if amount == 1 then
		self:PrintMessage(HUD_PRINTTALK, "You put the " .. item.name .. " into your hotbar.")
	end

	if self:inventoryHotbarHasItem( name, amount ) then
		i[name].amount = i[name].amount + amount
	else
		i[name] = {amount = amount}
	end
	
	self:databaseSend()
	self:inventorySave(k)
	self:inventoryHotbarSave(i)

end

function ply:inventoryAttachmentHasItem( name, amount )

	if not amount then amount = 1 end
	
	local i = self:inventoryAttachmentGet()
	
	if i then
		if i[name] then
			if i[name].amount >= amount then
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

function ply:inventoryAttachmentSave(i)


end
function ply:inventoryAttachmentGet()

	local i = self:databaseGetValue("attachments")
	return i

end

function ply:inventoryAttachmentGiveItem( name )

	amount = 1
	
	local i = self:inventoryAttachmentGet()
	
	local k = self:inventoryGet()
	
	local item = getItems(name)
	
	if not item then return end
	
	
	if amount == 1 then
		self:PrintMessage(HUD_PRINTTALK, "You put the " .. item.name .. " into your Attachments stash.")
	end

	if self:inventoryAttachmentHasItem( name, amount ) then
		i[name].amount = i[name].amount + amount
	else
		i[name] = {amount = amount}
	end
	
	self:inventoryAttachmentRegister()
	self:databaseSend()
	self:inventorySave(k)
	self:inventoryAttachmentSave(i)

end

function ply:inventoryAttachmentRegister()

	local i = self:inventoryAttachmentGet()
	
	ply.FAS2Attachments = {}
	
	for k, v in pairs(i) do
		print(k)
		local item = getItems(k)
			if (item.name != "fillervalue") then
				if not table.HasValue(ply.FAS2Attachments, item.IDname) then
				ply:FAS2_PickUpAttachment(item.IDname)
				end
			end
	end
			
		end


function ply:inventoryAttachmentTakeItem( name )

	amount = 1
	
	local i = self:inventoryAttachmentGet()
	
	local k = self:inventoryGet()
	
	local item = getItems(name)
	
	if not item then return end
	
	
		i[name].amount = i[name].amount - amount
	
		for k, v in pairs(i) do
			if v.amount <= 0 then
				i[k] = nil
			end
		end
		
		self:databaseSend()
		self:inventorySave(k)
		self:inventoryAttachmentSave(i)

end


function ply:inventoryHotbarTakeItem( name )

	amount = 1
	
	local i = self:inventoryHotbarGet()
	
	local k = self:inventoryGet()
	
	local item = getItems(name)
	
	if not item then return end
	
	
		i[name].amount = i[name].amount - amount
	
		for k, v in pairs(i) do
			if v.amount <= 0 then
				i[k] = nil
			end
		end
		
		self:databaseSend()
		self:inventorySave(k)
		self:inventoryHotbarSave(i)


end

net.Receive("inv_drop", function(len, ply)

	local name = net.ReadString()
	
	if ply:inventoryHasItem( name, 1 ) then
		ply:inventoryTakeItem( name, 1 )
		
		makeItem( ply, name, itemSpawnPos( ply ) )
	end

end)

net.Receive("inv_use", function(len, ply)

	local name = net.ReadString()
	
	local item = getItems( name )
	
	if item then
		if ply:inventoryHasItem( name, 1 ) then
			
			ply:inventoryTakeItem( name, 1 )
			if item.ent == "item_basic" then
			item.use( ply )
			end
		end
	end
end)

net.Receive("inv_equip", function(len, ply)

	local name = net.ReadString()
	
	local item = getItems( name )
	
	local hbar = ply:inventoryHotbarGet()
	
	if item then
	
		if ply:inventoryHasItem( name, 1 ) then
			print("has sucessfully equipped item")
			ply:inventoryTakeItem( name, 1 )
			ply:equipItem( name )
			hbar[name].enabled = true
			ply:setVariables(name)
		end
	end
end)

net.Receive("inv_dequip", function(len, ply)

	local name = net.ReadString()
	print(name)
	
	local item = getItems( name )
	
	local hbar = ply:inventoryHotbarGet()
	
	if item then
			ply:inventoryGiveItem( name, 1 )
			hbar[name].enabled = false
			ply:setVariablesNegative(name)
			ply:inventoryHotbarTakeItem( name )
			
			
		end
end)

net.Receive("inv_attach", function(len, ply)

	local name = net.ReadString()
	
	if ply:inventoryHasItem( name, 1 ) then
		ply:inventoryTakeItem( name, 1 )
		
		ply:attachItem( name )
	end

end)

function ply:equipItem( item )

	if self:hotbarHasSpace() then
	
		print("Item put into hotbar.")
		self:inventoryHotbarGiveItem( item )
	
	else
		return false
	end

end

function ply:attachItem( item )
	
	print("Attachment put into stash.")
	self:inventoryAttachmentGiveItem( item )
	
	end

local idd = 0

function makeItem( ply, name, pos )

	local itemT = getItems( name )
	
	if itemT then
		idd = idd + 1
	
		local item = ents.Create( itemT.ent )
		
		item:SetNWBool("attachment", itemT.attachment or false)
		item:SetNWString("name", itemT.name)
		item:SetNWString("itemName", name)
		item:SetNWInt("uID", idd)
		item:SetNWBool("pickup", true)
		item:SetPos( pos )
		item:SetNWEntity("owner", ply )
		item:SetSkin(itemT.skin or 0)
		itemT.spawn(ply, item)
		item:SetNWBool("ammo", itemT.attachment)
		item:Spawn()
		item:Activate()
	else
		return false
	end

end

function itemSpawnPos( ply )

	local pos = ply:GetShootPos()
	local ang = ply:GetAimVector()
	
	local td = {}
	
	td.start = pos
	td.endpos = pos + (ang*80)
	td.filter = ply
	local trace = util.TraceLine(td)
	return trace.HitPos

end

function inventoryPickup( ply )

	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply
	
	local tr = util.TraceLine(trace)
	
	if (tr.HitWorld) then return end
	
	if !tr.Entity:IsValid() then return end
	
	if tr.Entity:GetNWBool("pickup") then
	
		if tr.Entity:GetNWBool("attachment") then return false end
		local item = getItems( tr.Entity:GetNWString("itemName"))
			if tr.Entity:GetNWBool("pickup") == nil then
				ply:inventoryGiveItem( tr.Entity:GetNWString("itemName"), 1)
				tr.Entity:Remove()
			else
				if tr.Entity:GetNWBool("pickup") then
					ply:inventoryGiveItem( tr.Entity:GetNWString("itemName"), 1)
					tr.Entity:Remove()
				end
			end
	end
end
hook.Add("KEY_E", "inventoryPickup", inventoryPickup)

function ply:setVariables(name)

	local is = self:inventoryHotbarGet()
	
	local item = getItems( name )
	
				if is[name].enabled then
					item.use( self )
				end
			

	self:databaseSave()
	self:inventoryHotbarSave(is)

end

function ply:setVariablesNegative(name)

	local is = self:inventoryHotbarGet()
	
	local item = getItems( name )
	
				if !is[name].enabled then
					item.dequip( self )
				end
			

	self:databaseSave()
	self:inventoryHotbarSave(is)

end