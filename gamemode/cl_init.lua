 include( "shared.lua" )
include( "db/cl_database.lua")
include("db/items.lua")

local function keyE()

	if input.IsKeyDown(KEY_E) then
		net.Start("KEY_E")
		net.SendToServer()
		
		hook.Call("KEY_E", GAMEMODE, ply)
	end
end
hook.Add("Think","e_press", keyE)


--HUD DISABLE
local tohide = { -- This is a table where the keys are the HUD items to hide
	["CHudHealth"] = false,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudCrosshair"] = true
}
local function HUDShouldDraw(name)
	if (tohide[name]) then
		return false;      -- Return false.
	end
end
hook.Add("HUDShouldDraw", "hider", HUDShouldDraw)