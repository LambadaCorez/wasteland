
local ply = FindMetaTable("Player")

surface.CreateFont( "invHighlight", {
	font = "Roboto Heavy", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 18,
	weight = 500,
	blursize = 0,
	scanlines = 2,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
} )


local database = {}

local function databaseReceive( tab )
	database = tab
end
net.Receive("database", function(len)
	local tab = net.ReadTable()
	databaseReceive( tab )
end)

function databaseTable()
	return database
end

function databaseGetValue( name )

	local d = databaseTable()
	return d[name]
	
end

function inventoryTable()

	return databaseGetValue( "inventory" ) or {}

end

function hotbarTable()

	return databaseGetValue( "hotbar" ) or {}

end

function inventoryHasItem( name, amount )
	if not amount then amount = 1 end
	
	local i = inventoryTable()
	
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
	
	local hzCross = false
	
	local stringName;
	
function invGlow()

	local trace = {}
	trace.start = LocalPlayer():EyePos()
	trace.endpos = trace.start + LocalPlayer():GetAimVector() * 85
	trace.filter = LocalPlayer()
	
	local tr = util.TraceLine(trace)
	
	local trace = {}
	trace.start = LocalPlayer():EyePos()
	trace.endpos = trace.start + LocalPlayer():GetAimVector() * 85
	trace.filter = LocalPlayer()
	
	local tr = util.TraceLine(trace)
	
	if (tr.HitWorld) then hzCross = false return end
	
	if !tr.Entity:IsValid() then hzCross = false return end
	
	
	if tr.Entity:GetNWBool("pickup") then
	hzCross = true
	stringName = tr.Entity
	--Entity glow effect
	 halo.Add({tr.Entity}, Color( 255, 255, 255 ))
		
	 else
	 hzCross = false
	 end
	 
	 
end

function hudSystem()
	if hzCross then
	surface.DrawCircle(ScrW() / 2, ScrH() / 2, 2, Color(255,255,255))
	surface.DrawCircle(ScrW() / 2, ScrH() / 2, 1, Color(255,255,255))
	draw.RoundedBox( 4, ScrW() / 2 + 15, ScrH() / 2 - 16, 32, 32, Color(35,35, 35))
	surface.SetFont( "invHighlight" )
		draw.DrawText("E","invHighlight", ScrW()/2 + 27.5, ScrH()/2 - 9)
		surface.SetTextPos( ScrW() / 2 + 55, ScrH() / 2 - 10 )
		surface.DrawText(tostring(stringName:GetNWString("name")))	
		
		end
		
	end

hook.Add("HUDPaint","CustomCross",hudSystem)
hook.Add("Think", "itemGlow", invGlow)

local SKINS = {}
SKINS.COLORS = {
	lightgrey = Color(131,131,131,180),
	grey = Color(111,111,111,180),
	lowWhite = Color(243,243,243, 180),
	goodBlack = Color( 41,41,41,230 )
}

function SKINS:DrawFrame(w, h)
	
	topHeight = 24
	local rounded = 4
	
	draw.RoundedBoxEx( rounded, 0, 0, w, topHeight, SKINS.COLORS.lightgrey, true, true, false, false)
	draw.RoundedBoxEx( rounded, 0, topHeight, w, h-topHeight, SKINS.COLORS.lightgrey, false, false, true, true)
	draw.RoundedBoxEx( rounded, 2, topHeight, w-4, h-topHeight-2, SKINS.COLORS.goodBlack, false, false, true, true)
	
	local QuadTable = {}
	QuadTable.texture = surface.GetTextureID( "gui/gradient" )
	QuadTable.color = Color( 10,10,10, 120 )
	QuadTable.x = 2
	QuadTable.y = topHeight
	QuadTable.w = w-4
	QuadTable.h = h-topHeight-2
	draw.TexturedQuad( QuadTable )

end

	function hotbarItemButton( iname, name, amount, desc, model, parent, dist, buttons )
	
		if not dist then dist = 128 end
	
		local p = vgui.Create( "DPanel", parent )
	
		p:SetPos( 4, 4 )
		p:SetSize( 48, 48 )
	
		local mp = vgui.Create( "DModelPanel", p )
		mp:SetSize( p:GetWide(), p:GetTall() )
		mp:SetPos( 0, 0 )
		mp:SetModel(model)
		mp:SetAnimSpeed(0.1)
		mp:SetAnimated( true )
		mp:SetAmbientLight( Color( 50,50,50 ) )
		mp:SetDirectionalLight( BOX_TOP, Color(255,255,255))
		mp:SetCamPos(Vector(dist,dist,dist))
		mp:SetLookAt(Vector(0,0,0))
		mp:SetFOV(20)
	
	function mp:LayoutEntity(Entity)
		self:RunAnimation()
		Entity:SetSkin(getItems(iname).skin or 0)
		Entity:SetAngles(Angle(0,0,0))
	end
	
	local b = vgui.Create("DButton", p)
	b:SetPos( 4, 4 )
	b:SetSize(64,64)
	b:SetText("")
	b:SetToolTip("Name: " .. name .. "\n\n" .. "Description: " .. "\n" .. desc)
	
	b.DoClick = function()
		local opt = DermaMenu()
		
		for k, v in pairs(buttons) do
			opt:AddOption(k,v)
		end
		opt:Open()
	end	
	
	b.DoRightClick = function()
	end
	
	function b:Paint()
		return true
	end
	
	if amount != 1 then
		local l = vgui.Create("DLabel", p)
		l:SetPos(6,4)
		l:SetFont("default")
		l:SetText(amount)
		l:SizeToContents()
	end
	
	return p
	
	end

local function inventoryItemButton( iname, name, amount, desc, model, parent, dist, buttons )
	if not dist then dist = 128 end
	
	local p = vgui.Create( "DPanel", parent )
	
	p:SetPos( 4, 4 )
	p:SetSize( 64, 64 )
	
	local mp = vgui.Create( "DModelPanel", p )
	mp:SetSize( p:GetWide(), p:GetTall() )
	mp:SetPos( 0, 0 )
	mp:SetModel(model)
	mp:SetAnimSpeed(0.1)
	mp:SetAnimated( true )
	mp:SetAmbientLight( Color( 50,50,50 ) )
	mp:SetDirectionalLight( BOX_TOP, Color(255,255,255))
	mp:SetCamPos(Vector(dist,dist,dist))
	mp:SetLookAt(Vector(0,0,0))
	mp:SetFOV(20)
	
	
	function mp:LayoutEntity(Entity)
		self:RunAnimation()
		Entity:SetSkin(getItems(iname).skin or 0)
		Entity:SetAngles(Angle(0,0,0))
	end
	
	local b = vgui.Create("DButton", p)
	b:SetPos( 4, 4 )
	b:SetSize(64,64)
	b:SetText("")
	b:SetToolTip("Name: " .. name .. "\n\n" .. "Description: " .. "\n" .. desc)
	
	b.DoClick = function()
		local opt = DermaMenu()
		
		for k, v in pairs(buttons) do
			opt:AddOption(k,v)
		end
		opt:Open()
	end	
	
	b.DoRightClick = function()
	end
	
	function b:Paint()
		return true
	end
	
	if amount then
		local l = vgui.Create("DLabel", p)
		l:SetPos(6,4)
		l:SetFont("default")
		l:SetText(amount)
		l:SizeToContents()
	end
	
	return p
	
	
end

local function inventoryEquip(item)
	net.Start("inv_equip")
	net.WriteString(tostring(item))
	net.SendToServer()
end

local function inventoryDequip(item)
	net.Start("inv_dequip")
	net.WriteString(tostring(item))
	net.SendToServer()
end

local function inventoryDrop(item)
	net.Start("inv_drop")
	net.WriteString(tostring(item))
	net.SendToServer()
end

local function inventoryUse(item)
	net.Start("inv_use")
	net.WriteString(tostring(item))
	net.SendToServer()
end

function inventoryMenu()
	local w = 506
	local h = 512
	
	
	
	r = vgui.Create("DFrame")
	r:SetSize(w,h)
	r:SetPos( (ScrW()/2) - (w/2), (ScrH()/2) - (h/2))
	r:SetDraggable(false)
	r:ShowCloseButton(true)
	r:MakePopup()
	
	r.Paint = function()
	
	SKINS:DrawFrame(506, 512)
	end
	
	local ps = vgui.Create( "DPropertySheet", r)
	ps:SetPos( 8, 28 )
	ps:SetSize( w - 16, h - 36 )
	
	local padding = 4
	
	local items = vgui.Create( "DPanelList", ps )
	items:SetPos( padding, padding )
	items:SetSize( w-32 - padding*2, h-48 - padding*2)
	items:EnableVerticalScrollbar(true)
	items:EnableHorizontal(true)
	items:SetPadding( padding )
	items:SetSpacing( padding )
	
	function items:Paint()
		draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color( 60, 60, 60 ) )
	end
	
	local inventory = inventoryTable()
	
	local function ItemButtons()
		for k,v in pairs(inventory) do
		local i = getItems(k)
		if i then
			local buttons = {}
			
			if i.equippable then
			buttons["Equip"] = (function()
				inventoryEquip(k)
				refreshPanels()
				end)
			end
			if !i.equippable then
			buttons["Use"] = (function()
				inventoryUse(k)
				r:Close()
			end)
			end
			buttons["Drop"] = (function()
				inventoryDrop(k)
				r:Close()
			end)
		local b = inventoryItemButton( k, i.name .. " (" .. v.amount .. ")", v.amount, i.desc, i.model, items, i.buttonDist, buttons )
		items:AddItem(b)
		end
	end
	
end

	ItemButtons()


	ps:AddSheet("Items", items, "icon16/box.png", false, false, "Item storage.")

	return r
	
end



function hotbarMenu()
	local w = 256
	local h = 64
	
	f = vgui.Create("DFrame")
	f:SetSize(w,h)
	f:SetPos( (ScrW()/2) - (w/2), (ScrH()/1.1))
	f:SetDraggable(false)
	f:ShowCloseButton(false)
	f:SetTitle( "" )
	f:Refresh()
	f.Paint = function()
		draw.RoundedBox( 4, 0, 0, w, h, Color( 100, 100, 100 ) )
	end
	
	
	local padding = 4
	
	local items = vgui.Create( "DPanelList", f )
	items:SetPos( padding, padding )
	items:SetSize( w - padding*2, h - padding*2)
	items:EnableVerticalScrollbar(true)
	items:EnableHorizontal(true)
	items:SetPadding( padding )
	items:SetSpacing( padding )
	
	function items:Paint()
		draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color( 60, 60, 60 ) )
	end
	
	
	
	local hotbar = hotbarTable()
	
	local function specButtons()
		for k,v in pairs(hotbar) do
		local i = getItems(k)
		print(k)
		if i then
			local buttons = {}
			if i.equippable then
			buttons["De-Equip"] = (function()
				inventoryDequip(k)
				refreshPanels()
				end)
			end
			if !i.equippable then
			buttons["Use"] = (function()
				inventoryUse(k)
				
			end)
			end
		if( i.name != "fillervalue" ) then
			local b = hotbarItemButton( k, i.name .. " (" .. v.amount .. ")", v.amount, i.desc, i.model, items, i.buttonDist, buttons )
			items:AddItem(b)
		end
		end
	end
	
end

	specButtons()
	
	return f
	


end


function refreshPanels()

	hotbarMenu():Remove()
	inventoryMenu():Remove()
	timer.Simple(2, function()
	hotbarMenu()
	inventoryMenu()
	end)

end
concommand.Add("wl_inv", inventoryMenu)
concommand.Add("wl_hb", hotbarMenu)