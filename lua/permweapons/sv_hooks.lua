--[[

	sv_hooks.lua

]]--

hook.Add("Initialize", "PW_CreateDir", function()
	if ( !file.Exists("pw", "DATA") ) then
		file.CreateDir("pw")
	end
end)

hook.Add("PlayerInitialSpawn", "PW_PlayerInitialSpawn", function(ply)
	timer.Simple(1,function()
		local Weapons = ply:getAllPermWeapons()
		if ( Weapons == nil || game.SinglePlayer() ) then return end
		for k, v in pairs(Weapons) do
			ply:Give(v)
			DarkRP.notify(ply, 2, 4, "[PW] PermWeapon successfully given!")
		end
	end)
end)

hook.Add("PlayerLoadout", "PW_PlayerLoadout", function(ply)
	local Weapons = ply:getAllPermWeapons()
	if ( Weapons == nil || game.SinglePlayer() ) then return end
	for k, v in pairs(Weapons) do
		ply:Give(v)
		DarkRP.notify(ply, 2, 4, "[PW] PermWeapon successfully given!")
	end
end)