--[[--------------------

RGM Manipulator
The central authority of the entire movement and rendering process of gizmos.
The code using the manipulator (e.g. toolgun) communicates with this entity,
and this entity manages moving skeletons and rendering gizmos.

----------------------]]

ENT.Type = "anim"
ENT.Base = "base_entity"

--Gizmo mode constants.
ENT.GIZMO_MODE_MOVE = 1;
ENT.GIZMO_MODE_ROTATE = 2;
ENT.GIZMO_MODE_SCALE = 3;

function ENT:InitializeShared()

	self.BaseClass.Initialize(self);
	
	self.m_AllowedFuncs = {"SetupGizmos"};
	
	self.m_Gizmos = {};
	
	self.m_GrabData = nil;
	
end

---
-- Returns if the manipulator is enabled or not.
-- When the manipulator is disabled, grabbing, updating positions and rendering
-- functions do nothing.
---
function ENT:IsEnabled()
	return self:GetNWBool("Enabled", false);
end

function ENT:GetGizmos()
	return self.m_Gizmos;
end

function ENT:GetPlayer()
	return self:GetNWEntity("Player", NULL);
end

---
-- Get the current target to be manipulated. (This should be rgm_skeleton)
---
function ENT:GetTarget()
	return self:GetNWEntity("Target", NULL);
end

function ENT:GetScale()
	return self:GetNWFloat("Scale", 1);
end

---
-- Returns if the manipulator is currently grabbed or not.
---
function ENT:IsGrabbed()
	return self:GetNWBool("Grabbed", false);
end

---
-- Get the current mode of the manipulator.
-- Should be 1, 2 or 3, meaning move, rotate or scale.
---
function ENT:GetMode()
	return self:GetNWInt("Mode", self.GIZMO_MODE_MOVE);
end

function ENT:GetMoveGizmo()
	return self.m_MoveGizmo;
end
function ENT:GetRotateGizmo()
	return self.m_RotateGizmo;
end
function ENT:GetScaleGizmo()
	return self.m_ScaleGizmo;
end

---
-- Get the gizmo entity of the current mode.
---
function ENT:GetActiveGizmo()
	local mode = self:GetMode();
	if mode == self.GIZMO_MODE_MOVE then
		return self:GetMoveGizmo();
	elseif mode == self.GIZMO_MODE_ROTATE then
		return self:GetRotateGizmo();
	elseif mode == self.GIZMO_MODE_SCALE then
		return self:GetScaleGizmo();
	else
		return self:GetMoveGizmo();
	end
end

---
-- Test player's eye trace against the active gizmo, and returns rgm.Trace
---
function ENT:GetTrace()
	local gizmo = self:GetActiveGizmo();

	local resp = gizmo:GetTrace();
	
	return resp;
end

---
-- Returns the manipulator's rgm grab data.
-- If no grab data is present (either not grabbed, not synced when clientside), returns nil
---
function ENT:GetGrabData()

	local gd = rgm.GrabData(self:GetNWEntity("GrabData_Axis", NULL), self:GetNWVector("GrabData_AxisOffset", nil));

	if not IsValid(gd.axis) or not gd.axisOffset then return nil; end

	return gd;

end

function ENT:ThinkShared()
	
end

function ENT:UpdateCollision()
	
end