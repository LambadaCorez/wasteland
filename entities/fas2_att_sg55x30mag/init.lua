AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Items/car_battery01.mdl") 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	local phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
end

function ENT:OnTakeDamage(dmginfo)
	self:GetPhysicsObject():AddVelocity(dmginfo:GetDamageForce() * 0.1)
end

function ENT:Use(activator, caller)
	if activator:IsPlayer() then
		if not table.HasValue(activator.FAS2Attachments, self.Attachment) then
			activator:FAS2_PickUpAttachment(self.Attachment)
			self:Remove()
		end
	end
end

function ENT:OnRemove()
	return false
end 