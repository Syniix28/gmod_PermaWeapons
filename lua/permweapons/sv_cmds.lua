--[[

  sv_cmds.lua

]]--

concommand.Add("addpermweapon", function(ply, cmd, args, str)
	if ( !table.HasValue(PermWeapons.CanUseCMDs, ply:GetUserGroup()) ) then DarkRP.notify(ply, 2, 4, "[PW] You don't have the Permissions to use this Command!") return "" end 
  	local cmd = string.Explode( " ", str )
  	if ( cmd[1] && cmd[2] ) then
  		local target = DarkRP.findPlayer( tostring(cmd[1]) )
  		if ( target ) then
        if ( PermWeapons.HasWeapon(target, tostring(cmd[2])) ) then DarkRP.notify(ply, 2, 4, "[PW] Player already has the PermWeapon!") return "" end
        if ( table.HasValue(PermWeapons.WeaponBlacklist,cmd[2]) ) then DarkRP.notify(ply, 2, 4, "[PW] This Weapon is on the Blacklist!") return "" end
          target:addPermWeapon(tostring(cmd[2]))
          DarkRP.notify(ply, 2, 4, "[PW] PermWeapon successfully added!")
          DarkRP.notify(ply, 2, 4, "[PW] "..tostring(cmd[2]).." has been added to your PermWeapons!")
  		end
  	end
end)

concommand.Add("addpermweaponid", function(ply, cmd, args, str)
	if ( !table.HasValue(PermWeapons.CanUseCMDs, ply:GetUserGroup()) ) then DarkRP.notify(ply, 2, 4, "[PW] You don't have the Permissions to use this Command!") return "" end 
  	local cmd = string.Explode( " ", str )
  	if ( cmd[1] && cmd[2] ) then
  		local target = player.GetBySteamID(cmd[1])
  		if ( target ) then
        if ( PermWeapons.HasWeapon(target, tostring(cmd[2])) ) then DarkRP.notify(ply, 2, 4, "[PW] Player already has the PermWeapon!") return "" end
        if ( table.HasValue(PermWeapons.WeaponBlacklist,cmd[2]) ) then DarkRP.notify(ply, 2, 4, "[PW] This Weapon is on the Blacklist!") return "" end
          target:addPermWeapon(tostring(cmd[2]))
          DarkRP.notify(ply, 2, 4, "[PW] PermWeapon successfully added!")
  		end
  	end
end)

concommand.Add("removepermweapon", function(ply, cmd, args, str)
	if ( !table.HasValue(PermWeapons.CanUseCMDs, ply:GetUserGroup()) ) then DarkRP.notify(ply, 2, 4, "[PW] You don't have the Permissions to use this Command!") return "" end 
  	local cmd = string.Explode( " ", str )
  	if ( cmd[1] && cmd[2] ) then
  		 local target = DarkRP.findPlayer( tostring(cmd[1]) )
  		 if ( target ) then
  		 	local IsVal = PermWeapons.HasWeapon(target, tostring(cmd[2]))
  			if ( !IsVal ) then return end
          target:removePermWeapon(tostring(cmd[2]))
          DarkRP.notify(ply, 2, 4, "[PW] PermWeapon successfully removed!")
          DarkRP.notify(ply, 2, 4, "[PW] "..tostring(cmd[2]).." has been removed from your PermWeapons!")
  		 end
  	end
end)

concommand.Add("removepermweaponid", function(ply, cmd, args, str)
	if ( !table.HasValue(PermWeapons.CanUseCMDs, ply:GetUserGroup()) ) then DarkRP.notify(ply, 2, 4, "[PW] You don't have the Permissions to use this Command!") return "" end 
  	local cmd = string.Explode( " ", str )
  	if ( cmd[1] && cmd[2] ) then
  		 local target = player.GetBySteamID(cmd[1])
  		 if ( target ) then
  		 	local IsVal = PermWeapons.HasWeapon(target, tostring(cmd[2]))
  			if ( !IsVal ) then return end
          target:removePermWeapon(tostring(cmd[2]))
          DarkRP.notify(ply, 2, 4, "[PW] PermWeapon successfully removed!")
  		 end
  	end
end)

concommand.Add("showpermweapons", function(ply, cmd, args, str)
	if ( !table.HasValue(PermWeapons.CanUseCMDs, ply:GetUserGroup()) ) then DarkRP.notify(ply, 2, 4, "[PW] You don't have the Permissions to use this Command!") return "" end 
  	local cmd = string.Explode( " ", str )
  	if ( cmd[1] ) then
  		 local target = DarkRP.findPlayer( tostring(cmd[1]) )
  		 if ( target ) then
          local Weapons = target:getAllPermWeapons()
          local Count = 1
          if ( Weapons == nil  ) then DarkRP.notify(ply, 1, 4, "[PW] "..target:Name().." has no PermWeapons!") return "" end
          for k, v in pairs(Weapons) do 
	           DarkRP.notify(ply, 2, 10, "[PW] "..target:Name().."'s".." PermWeapon "..Count..": "..v)
	           Count = Count + 1
          end
          return ""
  		 end
  	end
end)

concommand.Add("showpermweaponsid", function(ply, cmd, args, str)
	if ( !table.HasValue(PermWeapons.CanUseCMDs, ply:GetUserGroup()) ) then DarkRP.notify(ply, 2, 4, "[PW] You don't have the Permissions to use this Command!") return "" end 
  	local cmd = string.Explode( " ", str )
  	if ( cmd[1] ) then
  		 local target = DarkRP.findPlayer( tostring(cmd[1]) )
  		 if ( target ) then
          local Weapons = target:getAllPermWeapons()
          local Count = 1
          for k, v in pairs(Weapons) do 
	           DarkRP.notify(ply, 2, 10, "[PW] "..target:Name().."'s".." PermWeapon "..Count..": "..v)
	           Count = Count + 1
          end
          return ""
  		 end
  	end
end)


hook.Add( "PlayerSay", "PW_ChatCMDs", function( ply, msg, group )
    if ( !table.HasValue(PermWeapons.CanUseCMDs, ply:GetUserGroup()) ) then DarkRP.notify(ply, 2, 4, "[PW] You don't have the Permissions to use this Command!") return "" end 
    msg = string.lower( msg )
    local cmd = string.Explode( " ", msg )
    if ( cmd[1] == "!addpermweapon" || cmd[1] == "!apw" ) then
        if ( cmd[2] && cmd[3] ) then
        	if ( cmd[3] == "" ) then DarkRP.notify(ply, 1, 4, "[PW] Invalid Arguments!") return "" end
            local target = DarkRP.findPlayer( tostring(cmd[2]) )
            if ( target ) then
                if ( PermWeapons.HasWeapon(target, tostring(cmd[3])) ) then DarkRP.notify(ply, 2, 4, "[PW] Player already has the PermWeapon!") return "" end
                if ( table.HasValue(PermWeapons.WeaponBlacklist,cmd[3]) ) then DarkRP.notify(ply, 2, 4, "[PW] This Weapon is on the Blacklist!") return "" end
                target:addPermWeapon(tostring(cmd[3]))
                DarkRP.notify(ply, 2, 4, "[PW] PermWeapon successfully added!")
                DarkRP.notify(ply, 2, 4, "[PW] "..tostring(cmd[3]).." has been added to your PermWeapons!")
                return ""
            end
            return ""
        else
            DarkRP.notify(ply, 1, 4, "[PW] Invalid Arguments!")
            return ""
        end
    end

    if ( cmd[1] == "!removepermweapon" || cmd[1] == "!rpw" ) then
        if ( cmd[2] && cmd[3] ) then
        	if ( cmd[3] == "" ) then DarkRP.notify(ply, 1, 4, "[PW] Invalid Arguments!") return "" end
            local target = DarkRP.findPlayer( tostring(cmd[2]) )
            if ( target ) then
            	local IsVal = PermWeapons.HasWeapon(target, tostring(cmd[3]))
          		if ( !IsVal ) then DarkRP.notify(ply, 1, 4, "[PW] "..target:Name().." has not the PermWeapon!") return "" end
                target:removePermWeapon( tostring(cmd[3]) )
                DarkRP.notify(ply, 2, 4, "[PW] PermWeapon successfully removed!")
                DarkRP.notify(ply, 2, 4, "[PW] "..tostring(cmd[3]).." has been removed from your PermWeapons!")
                return ""
            end
            return ""
        else
            DarkRP.notify(ply, 1, 4, "[PW] Invalid Arguments!")
            return ""
        end
    end
    if ( cmd[1] == "!showpermweapons" || cmd[1] == "!spw" ) then
        if ( cmd[2] ) then
            local target = DarkRP.findPlayer( tostring(cmd[2]) )
            if ( target ) then
            	local Weapons = target:getAllPermWeapons()
              local Count = 1
              if ( Weapons == nil  ) then DarkRP.notify(ply, 1, 4, "[PW] "..target:Name().." has no PermWeapons!") return "" end
              for k, v in pairs(Weapons) do 
                DarkRP.notify(ply, 2, 10, "[PW] "..target:Name().."'s".." PermWeapon "..Count..": "..v)
                Count = Count + 1
              end
              return ""
            end
            return ""
        else
            DarkRP.notify(ply, 1, 4, "[PW] Invalid Arguments!")
            return ""
        end
    end

    if ( cmd[1] == "!addpermweaponid" || cmd[1] == "!apwid" ) then
        if ( cmd[2] && cmd[3] ) then
        	if ( cmd[3] == "" ) then DarkRP.notify(ply, 1, 4, "[PW] Invalid Arguments!") return "" end
            local target = player.GetBySteamID(cmd[2])
            if ( target ) then
                if ( PermWeapons.HasWeapon(target, tostring(cmd[3])) ) then DarkRP.notify(ply, 2, 4, "[PW] Player already has the PermWeapon!") return "" end
                if ( table.HasValue(PermWeapons.WeaponBlacklist,cmd[3]) ) then DarkRP.notify(ply, 2, 4, "[PW] This Weapon is on the Blacklist!") return "" end
                target:addPermWeapon(tostring(cmd[3]))
                DarkRP.notify(ply, 2, 4, "[PW] PermWeapon successfully added!")
                return ""
            end
            return ""
        else
            DarkRP.notify(ply, 1, 4, "[PW] Invalid Arguments!")
            return ""
        end
    end

    if ( cmd[1] == "!removepermweaponid" || cmd[1] == "!rpwid" ) then
        if ( cmd[2] && cmd[3] ) then
        	if ( cmd[3] == "" ) then DarkRP.notify(ply, 1, 4, "[PW] Invalid Arguments!") return "" end
            local target = player.GetBySteamID(cmd[2])
            if ( target ) then
            	local IsVal = PermWeapons.HasWeapon(target, tostring(cmd[3]))
          		if ( !IsVal ) then DarkRP.notify(ply, 1, 4, "[PW] "..target:Name().." has not the PermWeapon!") return "" end
                target:removePermWeapon( tostring(cmd[3]) )
                DarkRP.notify(ply, 2, 10, "[PW] PermWeapon successfully removed!")
                return ""
            end
            return ""
        else
            DarkRP.notify(ply, 1, 4, "[PW] Invalid Arguments!")
            return ""
        end
    end
    if ( cmd[1] == "!showpermweaponsid" || cmd[1] == "!spwid" ) then
        if ( cmd[2] ) then
            local target = player.GetBySteamID(cmd[2])
            if ( target ) then
            	local Weapons = target:getAllPermWeapons()
              local Count = 1
              if ( Weapons == nil  ) then DarkRP.notify(ply, 1, 4, "[PW] "..target:Name().." has no PermWeapons!") return "" end
              for k, v in pairs(Weapons) do 
                DarkRP.notify(ply, 2, 10, "[PW] "..target:Name().."'s".." PermWeapon "..Count..": "..v)
                Count = Count + 1
              end
              return ""
            end
            return ""
        else
            DarkRP.notify(ply, 1, 4, "[PW] Invalid Arguments!")
            return ""
        end
    end
end)