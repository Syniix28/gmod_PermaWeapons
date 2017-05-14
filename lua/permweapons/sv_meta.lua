--[[

	sv_meta.lua

]]--

local meta = FindMetaTable("Player")

function meta:addPermWeapon(ent)
	if ( !ent || !self ) then return end
	if ( self:IsBot() || game.SinglePlayer() ) then return end
	local Path = "pw/"..self:SteamID64()..".txt"

	if ( file.Exists( "pw/"..self:SteamID64()..".txt","DATA" ) ) then
		local Weapons = file.Read( Path,"DATA" )
		local Tbl = {}
		Tbl = util.JSONToTable( Weapons )
		table.insert( Tbl, tostring(ent) )
		file.Write( Path, util.TableToJSON(Tbl) )
	else
		local Tbl = { tostring(ent) }
		file.Write( Path, util.TableToJSON(Tbl) )
	end
end

function meta:removePermWeapon(ent)
	if ( !ent || !self ) then return end
	if ( self:IsBot() || game.SinglePlayer() ) then return end
	if ( !PermWeapons.HasWeapon(self, ent) ) then return end
	local Path = "pw/"..self:SteamID64()..".txt"

	if ( file.Exists( "pw/"..self:SteamID64()..".txt","DATA" ) ) then
		local Weapons = file.Read( Path,"DATA" )
		local Tbl = {}
		Tbl = util.JSONToTable( Weapons )
		table.RemoveByValue( Tbl, tostring(ent) )
		file.Write( Path, util.TableToJSON(Tbl) )
	end
end