if ( SERVER ) then
	AddCSLuaFile("sh_config_pw.lua")
	AddCSLuaFile("permweapons/cl_init.lua")

	include("sh_config_pw.lua")
	include("permweapons/sv_init.lua")
	include("permweapons/sv_cmds.lua")
	include("permweapons/sv_hooks.lua")
	include("permweapons/sv_meta.lua")
end

if ( CLIENT ) then
	include("sh_config_pw.lua")
	include("permweapons/cl_init.lua")
end