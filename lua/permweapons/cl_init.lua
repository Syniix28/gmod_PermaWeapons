--[[

	cl_init.lua

]]--

surface.CreateFont( "PW_Title", {
	font = "Arial",
	size = 21,
	weight = 2000,
} )

surface.CreateFont( "PW_Close", {
	font = "Arial",
	size = 21,
	weight = 2000,
} )

surface.CreateFont( "PW_Weapon_Name", {
	font = "Arial",
	size = 32,
	weight = 2000,
} )

surface.CreateFont( "PW_Weapon_Price", {
	font = "Arial",
	size = 28,
	weight = 1000,
} )

surface.CreateFont( "PW_Weapon_Buy", {
	font = "Arial",
	size = 16,
	weight = 2000,
} )

surface.CreateFont( "PW_Weapon_Sell", {
	font = "Arial",
	size = 13,
	weight = 500,
} )

local width, height = 500,610

surface.SetFont("PW_Close")
local tW, tH = surface.GetTextSize("X")
surface.SetFont("PW_Weapon_Buy")
local bW, bH = surface.GetTextSize("Buy")
surface.SetFont("PW_Weapon_Buy")
local bW2, bH2 = surface.GetTextSize("Already Bought")
surface.SetFont("PW_Weapon_Buy")
local sW2, sH2 = surface.GetTextSize("Sell")



local blur = Material("pp/blurscreen")
local function DrawBlur(panel)
	local x, y = panel:LocalToScreen(0, 0)

	surface.SetDrawColor(255, 255, 255, 200)
	surface.SetMaterial(blur)

	for i = 1, 3 do
		blur:SetFloat("$blur", (i / 5) * 20)
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(-x, -y, ScrW(), ScrH())
	end
end

net.Receive("_Open_PW_Menu",function(len, ply)
	local Base = vgui.Create("DFrame")
	Base:SetSize(width,height)
	Base:Center()
	Base:SetTitle("")
	Base:ShowCloseButton(false)
	Base:SetDraggable(false)
	Base.Paint = function(self, w, h)
		DrawBlur(self)
		surface.SetDrawColor(50,50,50,240)
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(95,63,127,150)
		surface.DrawRect(0,0,w,25)

		draw.SimpleText("PermaWeapons Shop","PW_Title",250,2,Color(255,255,255,255),TEXT_ALIGN_CENTER)
	end
	Base:MakePopup()

	local ScrollP = vgui.Create( "DScrollPanel", Base )
	ScrollP:SetSize( 500, 575 )
	ScrollP:SetPos( 0, 30 )

	local CloseButton = vgui.Create("DButton", Base)
	CloseButton:SetSize(21,21)
	CloseButton:SetPos(477,2)
	CloseButton:SetText("")
	CloseButton.Paint = function(self, w, h)
		if ( CloseButton:IsHovered() ) then
			surface.SetDrawColor(200,200,200,255)
			surface.DrawRect(0,0,w,h)

			draw.SimpleText("X","PW_Close",w/2,h/2-(tH/2),Color(0,0,0,255),TEXT_ALIGN_CENTER)
		else
			surface.SetDrawColor(255,255,255,255)
			surface.DrawRect(0,0,w,h)

			draw.SimpleText("X","PW_Close",w/2,h/2-(tH/2),Color(0,0,0,255),TEXT_ALIGN_CENTER)
		end
	end
	CloseButton.DoClick = function()
		Base:Remove()
	end

	local PosY = 0
	for k, v in pairs(NPCPW.Items) do
		local Panel = vgui.Create( "DPanel", ScrollP )
		Panel:SetPos( 0, 0+PosY )
		Panel:SetSize(500,100)
		Panel.Paint = function(self, w, h)
			surface.SetDrawColor(100,100,100,100)
			surface.DrawRect(0,0,w,h)

			draw.SimpleText(v.name,"PW_Weapon_Name",w/2,5,Color(255,255,255,255),TEXT_ALIGN_CENTER)
			draw.SimpleText(DarkRP.formatMoney(v.price),"PW_Weapon_Price",w/2,35,Color(33,255,0,255),TEXT_ALIGN_CENTER)
		end
		if ( !PermWeapons.HasWeapon(LocalPlayer(), k) ) then
			local BuyButton = vgui.Create("DButton", Panel)
			BuyButton:SetPos(500/2-50,70)
			BuyButton:SetSize(100,25)
			BuyButton:SetText("")
			BuyButton.Paint = function(self, w, h)
				if ( PermWeapons.HasWeapon(LocalPlayer(), k) ) then
					if ( BuyButton:IsHovered() ) then
						surface.SetDrawColor(0,150,31,255)
						surface.DrawRect(0,0,w,h)

						draw.SimpleText("Already Bought","PW_Weapon_Buy",w/2,h/2-(bH2/2),Color(255,255,255,255),TEXT_ALIGN_CENTER)
					else
						surface.SetDrawColor(0,127,31,255)
						surface.DrawRect(0,0,w,h)

						draw.SimpleText("Already Bought","PW_Weapon_Buy",w/2,h/2-(bH2/2),Color(255,255,255,255),TEXT_ALIGN_CENTER)
					end
				else
					if ( BuyButton:IsHovered() ) then
						surface.SetDrawColor(60,60,60,255)
						surface.DrawRect(0,0,w,h)

						draw.SimpleText("Buy","PW_Weapon_Buy",w/2,h/2-(bH/2),Color(255,255,255,255),TEXT_ALIGN_CENTER)
					else
						surface.SetDrawColor(40,40,40,255)
						surface.DrawRect(0,0,w,h)

						draw.SimpleText("Buy","PW_Weapon_Buy",w/2,h/2-(bH/2),Color(255,255,255,255),TEXT_ALIGN_CENTER)
					end
				end
			end
			BuyButton.DoClick = function()
				net.Start("PW_BuyWeapon")
				net.WriteString(k)
				net.SendToServer()
				Base:Remove()
			end
		end
		if ( PermWeapons.HasWeapon(LocalPlayer(), k) ) then
			local SellButton = vgui.Create("DButton", Panel)
			SellButton:SetPos(250-37.5,70)
			SellButton:SetSize(75,25)
			SellButton:SetText("")
			SellButton.Paint = function(self, w, h)
				if ( SellButton:IsHovered() ) then
					surface.SetDrawColor(255,0,0,255)
					surface.DrawRect(0,0,w,h)

					draw.SimpleText("Sell","PW_Weapon_Buy",w/2,h/2-(sH2/2),Color(255,255,255,255),TEXT_ALIGN_CENTER)
				else
					surface.SetDrawColor(200,0,0,255)
					surface.DrawRect(0,0,w,h)

					draw.SimpleText("Sell","PW_Weapon_Buy",w/2,h/2-(sH2/2),Color(255,255,255,255),TEXT_ALIGN_CENTER)
				end
			end

			SellButton.DoClick = function()
				net.Start("PW_SellWeapon")
				net.WriteString(k)
				net.SendToServer()
				Base:Remove()
			end
		end
		PosY = PosY + 105
	end
end)