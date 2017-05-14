PermWeapons = {} -- DO NOT TOUCH
NPCPW = {} -- DO NOT TOUCH

--[[
Commandlist:

Chat:
	!addpermweapon Name weapon_class or !apw Name weapon_class 
	!removepermweapon Name weapon_class or !rpw Name weapon_class 
	!showpermweapons Name or !spw Name 

	!addpermweaponid SteamID Weapon_Class or !apwid SteamID Weapon_Class
	!removepermweaponid SteamID Weapon_Class or !rpwid SteamID Weapon_Class  
	!showpermweaponsid SteamID or !spwid SteamID

Console: 
	addpermweapon Name weapon_class
	removepermweapon Name weapon_class
	showpermweapons Name 

	addpermweaponid steamid weapon_class
	removepermweaponid steamid weapon_class
	showpermweaponsid steamid
]]--

PermWeapons.CanUseCMDs = {
	"superadmin",
	"admin",
}

--[[
	Weapons that can`t be given by the Commands.
]]--

PermWeapons.WeaponBlacklist = {
	"weapon_rpg",
}

--[[
	PermWeapons NPC Shop Settings
]]--

NPCPW.NPCModel = "models/Humans/Group03/male_03.mdl"
NPCPW.TextAboveHead = "PermaWeapons Shop"
NPCPW.TextAboveHeadColor = Color(100,100,100,255)
NPCPW.TextAboveHeadColorOutline = Color(0, 0, 0, 255)
NPCPW.RefundAmount = 0.3

NPCPW.Items = {
	["weapon_ar2"] = {
		name = "AR2",
		price = 10000,
	},
	["weapon_shotgun"] = {
		name = "Shotgun",
		price = 15000,
	},
	["weapon_stunstick"] = {
		name = "Stungun",
		price = 5000,
	},
	["weapon_smg1"] = {
		name = "SMG",
		price = 12000,
	},
	["weapon_crossbow"] = {
		name = "Crossbow",
		price = 15000,
	},
	["weapon_crowbar"] = {
		name = "Crowbar",
		price = 15000,
	},
}


--[[
	For Developer:

	Serverside:

	ply:addPermWeapon(Weapon_Class)
	ply:removePermWeapon(Weapon_Class)

	Shared:

	PermWeapons.HasWeapon(Player, Weapon_Class)
	ply:getAllPermWeapons() Returns Table
]]--

--[[
	Ignore this
]]--

local meta = FindMetaTable("Player")

function meta:getAllPermWeapons()
	if ( !self ) then return end
	if ( self:IsBot() || game.SinglePlayer() ) then return end
	local Path = "pw/"..self:SteamID64()..".txt"

	if ( file.Exists( "pw/"..self:SteamID64()..".txt","DATA" ) ) then
		local Weapons = file.Read( Path,"DATA" )
		local Tbl = {}
		Tbl = util.JSONToTable( Weapons )
		return Tbl
	end
end

function PermWeapons.HasWeapon(ply, wep)
	if ( !ply || !wep ) then return end
	if ( ply:IsBot() || game.SinglePlayer() ) then return end
	local Path = "pw/"..ply:SteamID64()..".txt"

	if ( file.Exists( "pw/"..ply:SteamID64()..".txt","DATA" ) ) then
		local Weapons = file.Read( Path,"DATA" )
		local Tbl = {}
		Tbl = util.JSONToTable( Weapons )
		for k, v in pairs(Tbl) do 
			if ( v == wep ) then
				return true
			end
		end
		return false
	end
end