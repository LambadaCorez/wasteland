AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("db/cl_database.lua")
AddCSLuaFile("db/items.lua")

include("shared.lua")
include("db/database.lua")
include("db/items.lua")

util.AddNetworkString("KEY_E")

local models = {}

models[0] = "models/player/Group03/male_01.mdl"
models[1] = "models/player/Group03/male_02.mdl"
models[2] = "models/player/Group03/male_04.mdl"
models[3] = "models/player/Group03/male_05.mdl"
models[4] = "models/player/Group03/male_07.mdl"
models[5] = "models/player/Group03/male_09.mdl"
models[6] = "models/player/Group03/male_08.mdl"

	function GM:PlayerInitialSpawn(ply)
		ply:SetModel(table.Random(models))
		ply:ConCommand("wl_hb")
	end

	function GM:PlayerSpawn( ply )
	ply:SetWalkSpeed(135)
	ply:SetWalkSpeed(145)

	end
	
	function GM:PlayerAuthed( ply, steamid, uniqueid )
	
	ply:databaseCheck()
	
	end
	
	function GM:PlayerDisconnected( ply )
	
	ply:inventoryDisconnect()
	ply:hotbarDisconnect()
	ply:databaseDisconnect()
	
	
	end
	
net.Receive("KEY_E", function(len, ply)
	hook.Call("KEY_E", GAMEMODE, ply)
end)