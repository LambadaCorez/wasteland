local items = {}

function getItems( name )
	if items[name] then
		return items[name]
	end
	return false
end
 
items["soda1"] = {
	
	name = "Blueberry Soda",
	desc = "SICK ASS FUCKIN TOTALLY TUBULAR SODA",
	ent = "item_basic",
	prices = {
		buy = 4,
		sell = 2,
	},
	model = "models/props_junk/PopCan01a.mdl",
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:AddHealth( 2 )
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("soda")
			end),
			skin = 0,
			buttonDist = 32,
		

}
items["soda2"] = {
	
	name = "Strawberry Soda",
	desc = "SICK ASS FUCKIN TOTALLY TUBULAR SODA",
	ent = "item_basic",
	prices = {
		buy = 4,
		sell = 2,
	},
	model = "models/props_junk/PopCan01a.mdl",
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:AddHealth( 2 )
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("soda")
			end),
			skin = 1,
			buttonDist = 32,
		

}
items["soda3"] = {
	
	name = "ORANGE Soda",
	desc = "SICK ASS FUCKIN TOTALLY TUBULAR SODA",
	ent = "item_basic",
	prices = {
		buy = 4,
		sell = 2,
	},
	model = "models/props_junk/PopCan01a.mdl",
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:AddHealth( 2 )
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("soda")
			end),
			skin = 0,
			buttonDist = 32,
		

}