
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel(NPCPW.NPCModel)
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:SetBloodColor(BLOOD_COLOR_RED)
end;

local nextUse = 0
local delay = 1
function ENT:AcceptInput(name, activator, caller)	
	if CurTime() < nextUse then return end
	if (name == "Use" and caller:IsPlayer()) then
		net.Start("_Open_PW_Menu")
		net.Send(activator)
	end;
	nextUse = CurTime() + delay
end