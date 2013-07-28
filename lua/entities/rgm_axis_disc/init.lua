
include("shared.lua");
AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

function ENT:Initialize()

	self.BaseClass.Initialize(self);

end

function ENT:ProcessMovement(offpos,offang,eyepos,eyeang,ent,bone,ppos,pnorm)
	local intersect = self:GetGrabPos(eyepos,eyeang,ppos,pnorm)
	local localized = self:WorldToLocal(intersect)
	localized = Vector(localized.y,localized.z,0):Angle()
	local pos = self:GetPos()
	local ang = self:LocalToWorldAngles(Angle(0,0,localized.y))
	local _p,_a = LocalToWorld(Vector(0,0,0),offang,pos,ang)
	return pos,_a
end

---
-- Updates the skeleton node position
---
function ENT:UpdatePosition()

	local offset = self:GetGrabOffset();

	local pl = self:GetPlayer();
	local eyepos, eyeang = rgm.EyePosAng(pl);

	local target = self:GetTarget();

	local planepos = self:GetPos();
	local planenorm = self:GetAngles():Forward();
	local linepos, lineang = eyepos, eyeang:Forward();

	local intersect = rgm.IntersectRayWithPlane(planepos, planenorm, linepos, lineang);

	local localized = self:WorldToLocal(intersect);

	local iAng = localized:Angle();
	local gAng = offset:Angle();
	local ang = iAng - gAng;

	target:SetAngles(ang);

end