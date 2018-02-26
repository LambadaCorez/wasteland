local items = {}

function getItems( name )
	if items[name] then
		return items[name]
	end
	return false
end
 
 
items["fillervalue"] = {

	name = "fillervalue",
	desc = "Hey... How'd you get this item?!",
	ent = "item_basic",
	prices = {
		buy = 0,
		sell = 0, 
	},
	model = "models/props_junk/PopCan01a.mdl",
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:SetHealth( math.Clamp(ply:Health() + 2, 0, 100 ))
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
items["soda1"] = {
	
	name = "Blueberry Soda",
	desc = "Refresh your tastebuds with this interesting taste of blueberry!",
	ent = "item_basic",
	prices = {
		buy = 4,
		sell = 2, 
	},
	model = "models/props_junk/PopCan01a.mdl",
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:SetHealth( math.Clamp(ply:Health() + 2, 0, 100 ))
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
	
	name = "Redberry Sodie-Pop",
	desc = "Refresh your tastebuds with this interesting taste of redberry!",
	ent = "item_basic",
	prices = {
		buy = 4,
		sell = 2,
	},
	model = "models/props_junk/PopCan01a.mdl",
	pickup = true,
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:SetHealth( math.Clamp(ply:Health() + 2, 0, 100 ))
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
	
	name = "O R A N G E Soda",
	desc = "SICK ASS FUCKIN TOTALLY TUBULAR SODA",
	ent = "item_basic",
	prices = {
		buy = 4,
		sell = 2,
	},
	model = "models/props_junk/PopCan01a.mdl",
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:SetHealth( math.Clamp(ply:Health() + 2, 0, 100 ))
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

items["melon"] = {

	name = "Melon",
	desc = "Ultra juicy melon!",
	ent = "item_basic",
	prices = {
		buy = 10,
		sell = 6,
	},
	model = "models/props_junk/watermelon01.mdl",
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:SetHealth( math.Clamp(ply:Health() + 15, 0, 100 ))
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("melon")
			end),
			skin = 0,
			buttonDist = 48,

}

items["flashlight"] = {

	name = "Flashlight",
	desc = "Allows you to see in the dark.",
	ent = "item_basic",
	prices = {
		buy = 75,
		sell = 45,
	},
	model = "models/maxofs2d/lamp_flashlight.mdl",
	equippable = true,
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:AllowFlashlight(true)
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("flashlight")
			end),
			skin = 0,
			buttonDist = 48,

}
items["glock"] = {
	
	name = "Glock-20",
	desc = "Top military-grade pistol from the heart of Austria.",
	ent = "item_basic",
	prices = {
		buy = 1200,
		sell = 750,
	},
	model = "models/weapons/w_glock20.mdl",
	equippable = true,
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:Give("fas2_glock20")
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("glock")
			end),
			skin = 0,
			buttonDist = 32,
		

}
