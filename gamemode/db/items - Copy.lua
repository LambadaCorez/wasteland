
local items = {}

function getItems( name )
	if items[name] then
		return items[name]
	end
	return false 
end
 
local smgrounds = "models/Items/BoxSRounds.mdl"
local arrounds = "models/Items/BoxMRounds.mdl"
local shotgunrounds = "models/Items/BoxBuckshot.mdl"
local pistolrounds = "models/Items/357ammo.mdl"
local attachments = "models/Items/car_battery01.mdl"

 
local items = {}
 
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


-- FOOD 
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
			ply:SetHealth( math.Clamp(ply:Health() + 4, 0, 100 ))
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("soda1")
			end),
			skin = 0,
			buttonDist = 32,
		

}
items["soda2"] = {
	
	name = "Redberry Soda",
	desc = "Refresh your tastebuds with this ball-busting taste of redberry!",
	ent = "item_basic",
	prices = {
		buy = 4,
		sell = 2,
	},
	model = "models/props_junk/PopCan01a.mdl",
	pickup = true,
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:SetHealth( math.Clamp(ply:Health() + 4, 0, 100 ))
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("soda2")
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
			ply:SetHealth( math.Clamp(ply:Health() + 100, 0, 100 ))
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("soda3")
			end),
			skin = 0,
			buttonDist = 32,
		

}
items["milk"] = {

	name = "Milk",
	desc = "Freshest milk in the wasteland, guarenteed!",
	ent = "item_basic",
	prices = {
		buy = 6,
		sell = 3,
	},
	model = "models/props_junk/garbage_milkcarton002a.mdl",
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:SetHealth( math.Clamp(ply:Health() + 13, 0, 100 ))
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("milk")
			end),
			skin = 0,
			buttonDist = 48,

}
items["beer1"] = {


	name = "Beer",
	desc = "Don't drink too much!",
	ent = "item_basic",
	prices = {
		buy = 7,
		sell = 4,
	},
	model = "models/props_junk/garbage_glassbottle003a.mdl",
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:SetHealth( math.Clamp(ply:Health() + 8, 0, 100 ))
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("beer1")
			end),
			skin = 0,
			buttonDist = 48,

}
items["coffee"] = {


	name = "Coffee",
	desc = "Gets you feelin' pumped!",
	ent = "item_basic",
	prices = {
		buy = 4,
		sell = 2,
	},
	model = "models/props_junk/garbage_coffeemug001a.mdl",
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:SetHealth( math.Clamp(ply:Health() + 3, 0, 100 ))
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
items["beans"] = {

	name = "Can of Beans",
	desc = "Don't stink up the place, kiddo.",
	ent = "item_basic",
	prices = {
		buy = 9,
		sell = 5,
	},
	model = "models/props_junk/garbage_metalcan001a.mdl",
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:SetHealth( math.Clamp(ply:Health() + 13, 0, 100 ))
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("beans")
			end),
			skin = 0,
			buttonDist = 48,

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
items["tofu"] = {

	name = "Tofu",
	desc = "Did someone order takeout?",
	ent = "item_basic",
	prices = {
		buy = 4,
		sell = 2,
	},
	model = "models/props_junk/watermelon01.mdl",
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:SetHealth( math.Clamp(ply:Health() + 14, 0, 100 ))
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("tofu")
			end),
			skin = 0,
			buttonDist = 48,

}
items["boot"] = {

	name = "Boot",
	desc = "Please don't eat this.",
	ent = "item_basic",
	prices = {
		buy = 3,
		sell = 1,
	},
	model = "models/props_junk/shoe001a.mdl",
	
	use = (function(ply, ent)
		if ply:IsValid() then
			ply:SetHealth( math.Clamp(ply:Health() + 2, 0, 100 ))
			if ent then
				ent:Remove()
		end
		end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("boot")
			end),
			skin = 0,
			buttonDist = 48,

}

-- AMMO TYPES
items["9x18"] = {

	name = "9x18mm Ammo",
	desc = "Ammo used for the PP-19 Bizon.",
	ent = "item_basic",
	prices = {
		buy = 120,
		sell = 65,
	},
	model = smgrounds,
	equippable = false,
	ammo = true,
	use = (function(ply, ent)
			if ent then
				ent:Remove()
			end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("9x18")
			end),
			skin = 0,
			buttonDist = 48,
			
}
items["9x19"] = {

	name = "9x19mm Ammo",
	desc = "Ammo used for the MP5 A5.",
	ent = "item_basic",
	prices = {
		buy = 100,
		sell = 45,
	},
	model = smgrounds,
	equippable = false,
	ammo = true,
	use = (function(ply, ent)
			if ent then
				ent:Remove()
			end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("9x19")
			end),
			skin = 0,
			buttonDist = 48,
			
}
items["762x51"] = {

	name = "7.62x51mm Ammo",
	desc = "Ammo used for the G3A3 and the M24.",
	ent = "item_basic",
	prices = {
		buy = 140,
		sell = 75,
	},
	model = arrounds,
	equippable = false,
	ammo = true,
	use = (function(ply, ent)
			if ent then
				ent:Remove()
			end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("762x51")
			end),
			skin = 0,
			buttonDist = 48,
			
}
items["762x39"] = {

	name = "7.62x39mm Ammo",
	desc = "Ammo used for the AK-47, the RPK-47, the SKS, and the Sako RK-95.",
	ent = "item_basic",
	prices = {
		buy = 160,
		sell = 95,
	},
	model = arrounds,
	equippable = false,
	ammo = true,
	use = (function(ply, ent)
			if ent then
				ent:Remove()
			end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("762x39")
			end),
			skin = 0,
			buttonDist = 48,
			
}
items["556x45"] = {

	name = "5.56x45mm Ammo",
	desc = "Ammo used for the SG 552.",
	ent = "item_basic",
	prices = {
		buy = 100,
		sell = 55,
	},
	model = arrounds,
	equippable = false,
	ammo = true,
	use = (function(ply, ent)
			if ent then
				ent:Remove()
			end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("556x45")
			end),
			skin = 0,
			buttonDist = 48,
			
}
items["545x39"] = {

	name = "5.45x39mm Ammo",
	desc = "Ammo used for the AK-74.",
	ent = "item_basic",
	prices = {
		buy = 145,
		sell = 75,
	},
	model = arrounds,
	equippable = false,
	ammo = true,
	use = (function(ply, ent)
			if ent then
				ent:Remove()
			end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("556x45")
			end),
			skin = 0,
			buttonDist = 48,
			
}
items["12gauge"] = {

	name = "12 Gauge Ammo",
	desc = "Ammo used for the M3 Super 90.",
	ent = "item_basic",
	prices = {
		buy = 95,
		sell = 40,
	},
	model = shotgunrounds,
	equippable = false,
	ammo = true,
	use = (function(ply, ent)
			if ent then
				ent:Remove()
			end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("12gauge")
			end),
			skin = 0,
			buttonDist = 48,
			
}
items["10x25"] = {

	name = "10x25mm Ammo",
	desc = "Ammo used for the Glock-20.",
	ent = "item_basic",
	prices = {
		buy = 65,
		sell = 30,
	},
	model = pistolrounds,
	equippable = false,
	ammo = true,
	use = (function(ply, ent)
			if ent then
				ent:Remove()
			end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("10x25")
			end),
			skin = 0,
			buttonDist = 48,
			
}
items["454casull"] = {

	name = ".454 Casull Ammo",
	desc = "Ammo used for the Raging Bull.",
	ent = "item_basic",
	prices = {
		buy = 75,
		sell = 35,
	},
	model = pistolrounds,
	equippable = false,
	ammo = true,
	use = (function(ply, ent)
			if ent then
				ent:Remove()
			end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("454casull")
			end),
			skin = 0,
			buttonDist = 48,
			
}

-- ATTACHMENTS
items["acog"] = {

	name = "ACOG Scope",
	desc = "ACOG Scope Attachment.",
	ent = "item_basic",
	prices = {
		buy = 135,
		sell = 75,
	},
	model = attachments,
	equippable = false,
	ammo = false,
	use = (function(ply, ent)
			if ent then
				ent:Remove()
				ply:FAS2_PickUpAttachment(self.Attachment)
			end
		end),
		spawn = (function(ply, ent)
			ent:SetItemName("acog")
			end),
			skin = 0,
			buttonDist = 48,
			
}
-- HOTBARRABLE ITEMS
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
	dequip = (function(ply, ent)
		if ply:IsValid() then
			ply:Flashlight( false )
			ply:AllowFlashlight(false)
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
			ply:Give("fas2_glock20", true)
			if ent then
				ent:Remove()
		end
		end
		end),
		dequip = (function(ply, ent)
		if ply:IsValid() then
			ply:StripWeapon("fas2_glock20")
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
