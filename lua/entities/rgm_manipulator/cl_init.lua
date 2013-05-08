
include("shared.lua");

function ENT:Initialize()
	
	self:InitializeShared();

	self:SetNoDraw(true);
	
end

---
-- Gizmo setup function called by the server
---
function ENT:SetupGizmos(move, rotate, scale)

	self.MoveGizmo = move;
	self.RotateGizmo = rotate;
	self.ScaleGizmo = scale;
	
	self.m_Gizmos =
	{
		self.MoveGizmo,
		self.RotateGizmo,
		self.ScaleGizmo
	};
	
end

function ENT:DrawDirectionLine(norm,scale,ghost) --TODO: Get rid!
	local pos1 = self:GetPos():ToScreen()
	local pos2 = (self:GetPos()+(norm*scale)):ToScreen()
	local grn = 255
	if ghost then grn = 150 end
	surface.SetDrawColor(0,grn,0,255)
	surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
end

---
-- Draw the currently active gizmo
---
function ENT:Render()

	if not self:IsEnabled() then return; end

	local pl = self:GetPlayer();
	if pl ~= LocalPlayer() then return; end --Don't render for other players
	
	local gizmo = self:GetActiveGizmo();
	gizmo:Render();
	
end

function ENT:Think()
	
	
	
end