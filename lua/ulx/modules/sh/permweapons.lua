local CATEGORY_NAME = "PermWeapons"

function ulx.givepermweapon( calling_ply, target_plys, weapon_class )
	local affected_plys = {}
	for i=1, #target_plys do
		local v = target_plys[ i ]
        if ( PermWeapons.HasWeapon( v, weapon_class ) ) then continue end
        if ( table.HasValue( PermWeapons.WeaponBlacklist, weapon_class ) ) then continue  end
        v:addPermWeapon( weapon_class )
		table.insert( affected_plys, v )
	end
	ulx.fancyLogAdmin( calling_ply, "#A gave #T #s" , affected_plys, weapon_class )
end
local givepermweapon = ulx.command( CATEGORY_NAME, "ulx givepermweapon", ulx.givepermweapon )
givepermweapon:addParam{ type=ULib.cmds.PlayersArg }
givepermweapon:addParam{ type=ULib.cmds.StringArg, hint="weapon_class" }
givepermweapon:defaultAccess( ULib.ACCESS_SUPERADMIN)
givepermweapon:help( "Give PermWeapon to Player" )

function ulx.removepermweapon( calling_ply, target_plys, weapon_class )
	local affected_plys = {}
	for i=1, #target_plys do
		local v = target_plys[ i ] 
        v:removePermWeapon( weapon_class )
		table.insert( affected_plys, v )
	end
	ulx.fancyLogAdmin( calling_ply, "#A removed from #T #s" , affected_plys, weapon_class )
end
local removepermweapon = ulx.command( CATEGORY_NAME, "ulx removepermweapon", ulx.removepermweapon )
removepermweapon:addParam{ type=ULib.cmds.PlayersArg }
removepermweapon:addParam{ type=ULib.cmds.StringArg, hint="weapon_class" }
removepermweapon:defaultAccess( ULib.ACCESS_SUPERADMIN)
removepermweapon:help( "Remove PermWeapon from Player" )

function ulx.showpermweapons( calling_ply, target_plys )
	local affected_plys = {}
	for i=1, #target_plys do
		local v = target_plys[ i ] 
        local Weapons = v:getAllPermWeapons()
        local Count = 1
        if ( Weapons == nil  ) then DarkRP.notify(calling_ply, 1, 4, "[PW] "..v:Name().." has no PermWeapons!") return end
        for k, v2 in pairs(Weapons) do 
            DarkRP.notify(calling_ply, 2, 10, "[PW] "..v:Name().."`s".." PermWeapon "..Count..": "..v2)
            Count = Count + 1
        end
		table.insert( affected_plys, v )
	end
	ulx.fancyLogAdmin( calling_ply, "#A has shown himself #T PermWeapons" , affected_plys )
end
local showpermweapons = ulx.command( CATEGORY_NAME, "ulx showpermweapons", ulx.showpermweapons )
showpermweapons:addParam{ type=ULib.cmds.PlayersArg }
showpermweapons:defaultAccess( ULib.ACCESS_SUPERADMIN)
showpermweapons:help( "Show PermWeapon from Player" )
