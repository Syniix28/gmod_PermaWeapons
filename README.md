# PermWeapons 

PermaWeapons System for GMod DarkRP

## Commandlist

### Chat:

```
!addpermweapon Name weapon_class or !apw Name weapon_class 
!removepermweapon Name weapon_class or !rpw Name weapon_class 
!showpermweapons Name or !spw Name 

!addpermweaponid SteamID Weapon_Class or !apwid SteamID Weapon_Class
!removepermweaponid SteamID Weapon_Class or !rpwid SteamID Weapon_Class  
!showpermweaponsid SteamID or !spwid SteamID
```
### Console:

```
addpermweapon Name weapon_class
removepermweapon Name weapon_class
showpermweapons Name 

addpermweaponid steamid weapon_class
removepermweaponid steamid weapon_class
showpermweaponsid steamid 
```

## Features

* Commands for Chat, Console & ULX
* Saved in Files
* Easy to Use
* Configurable
* NPC Shop

## For Developers

```
Serverside:

ply:addPermWeapon("weapon_class")
ply:removePermWeapon("weapon_class")

Shared:

ply:getAllPermWeapons() - Returns Table
PermWeapons.HasWeapon(Player, "weapon_class")
```


## Planned
```
VGUI Menu for managing Players PermWeapons
Adding Features by request
Optimizing Code  
```