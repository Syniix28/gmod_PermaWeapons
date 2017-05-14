
include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw()
    self:DrawModel()
    if self:GetPos():Distance(LocalPlayer():GetPos()) < 600 then
		local pos = self:GetPos() + Vector(0, 0, 1) * math.sin(CurTime() * 2) * 2
		local PlayersAngle = LocalPlayer():GetAngles()
		local ang = Angle( 0, PlayersAngle.y - 180, 0 )

		ang:RotateAroundAxis(ang:Right(), -90)
		ang:RotateAroundAxis(ang:Up(), 90)

		cam.Start3D2D(pos, ang, 0.21)
			draw.SimpleTextOutlined( NPCPW.TextAboveHead, "HUDNumber5", 0, -400,NPCPW.TextAboveHeadColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, NPCPW.TextAboveHeadColorOutline)
		cam.End3D2D()
	end
end 

function ENT:DrawTranslucent()
	self:Draw()
end
