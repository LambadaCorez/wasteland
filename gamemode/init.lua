AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("db/cl_database.lua")
AddCSLuaFile("db/items.lua")

include("shared.lua")
include("db/database.lua")

	function GM:PlayerInitialSpawn()
		
	end

	function GM:PlayerSpawn( ply )

	ply:SetWalkSpeed(135)
	ply:SetWalkSpeed(145)

	end
	
	function GM:PlayerAuthed( ply, steamid, uniqueid )
	
	ply:databaseCheck()
	
	end
	
	function GM:PlayerDisconnected( ply )
	
	ply:databaseDisconnect()
	
	end