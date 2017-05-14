--[[

  sv_init.lua

]]--

util.AddNetworkString("_Open_PW_Menu")
util.AddNetworkString("PW_BuyWeapon")
util.AddNetworkString("PW_SellWeapon")

net.Receive("PW_BuyWeapon", function(len, ply)
    local wep = net.ReadString()
    if ( !wep || PermWeapons.HasWeapon(ply, wep) ) then return end
    for k, v in pairs(NPCPW.Items) do
        if ( wep == k ) then
            if ( ply:getDarkRPVar("money") > v.price ) then
                local cash = v.price
                ply:addMoney(-cash)
                ply:Give(k)
                ply:addPermWeapon(k)

                DarkRP.notify(ply, 2, 4, "[PW] PermWeapon successfully bought!")
            else
                DarkRP.notify(ply, 1, 4, "[PW] You don't have enough money to buy the PermWeapon!")
            end
        end
    end
end)

net.Receive("PW_SellWeapon", function(len, ply)
    local wep = net.ReadString()
    if ( !wep || !PermWeapons.HasWeapon(ply, wep) ) then DarkRP.notify(ply, 1, 4, "[PW] You don't have that PermWeapon!") return end
    for k, v in pairs(NPCPW.Items) do
        if ( wep == k ) then
          local cash = v.price*NPCPW.RefundAmount
          ply:addMoney(cash)
          ply:removePermWeapon(k)
          ply:StripWeapon(k)

          DarkRP.notify(ply, 2, 4, "[PW] PermWeapon successfully sold! You have gotten "..DarkRP.formatMoney(cash)..".")
        end
    end
end)
