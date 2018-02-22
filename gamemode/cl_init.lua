include( "shared.lua" )
include( "db/cl_database.lua")
include("db/items.lua")


--HUD DISABLE
local tohide = { -- This is a table where the keys are the HUD items to hide
	["CHudHealth"] = true,
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