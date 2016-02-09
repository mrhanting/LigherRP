function GetAmmoForCurrentWeapon( ply )
	if ( !IsValid( ply ) ) then return -1 end

	local wep = ply:GetActiveWeapon()
	if ( !IsValid( wep ) ) then return -1 end
	
	local clip = ply:GetActiveWeapon():Clip1()

	return clip .. " / " .. ply:GetAmmoCount( wep:GetPrimaryAmmoType() )
end

surface.CreateFont("LevelFont", {

	size = 36,
	weight = 400,
	antialias = true,
	shadow = false,
	font = "Coolvetica"

 })
		
-- Set function
function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

-- Other default values 
local DarkRPHUD2 = "Trebuchet24"
local Health = 0
local avatar_f = 0
local localplayer = LocalPlayer()
			
local function hudPaint()
	
	--[[==================DO NOT TOUCH ANYTHING UNDER HERE UNLESS YOU KNOW WHAT YOU ARE DOING==================]]
	
	local x, y = 30, ScrH() - 20
	local ply = LocalPlayer()
	local localplyer = LocalPlayer()
	
	local ply_r = ply:GetNWInt("tingrp_r")
	local ply_g = ply:GetNWInt("tingrp_g")
	local ply_b = ply:GetNWInt("tingrp_b")
	local JobColor = Color(ply_r, ply_g, ply_b, 255)

	Health = ply:Health()
	Nickname = ply:GetNWString("tingrp_rpname") or ply:Nick()
	Money = ply:GetNWInt("tingrp_money")
	Salary = ply:GetNWInt("tingrp_salary")
	Job = ply:GetNWString("tingrp_jobname")
	
	if IsValid(LocalPlayer()) then 
	
		if string.len(Job) > 18 then
			Job = string.sub(Job, 1, 15) .. "..."
		end
		
		if string.len(Nickname) > 17 then
			Nickname = string.sub(Nickname, 1, 17) .. "..."
		end
		 
		if Salary == nil then
			Salary = "0"
		end
	
	end
	 
	-- Hud Base
	local DrawHealth = math.Min(Health / 100, 1)
	local Border = math.Min(6, math.pow(2, math.Round(3*DrawHealth)))
	draw.RoundedBox(0, 10, y - 90, 400, 100, Color(42,44,43,transparency))
	draw.RoundedBox(0, 10, y - 120, 400, 30, Color(34,37,36,transparency))
	
	--draw.DrawText("Time: " .. tostring(playtime), "DarkRPHUD2", 40, y - 85, Color(255,255,255,255))
	-- Health
	draw.RoundedBox(0, x + 99, y - 28, 275 - 8, 30, Color(0,0,0,200))
	draw.RoundedBox(0, x + 100, y - 27, (275 - 10) * DrawHealth, 28, Color(220,53,34,180))
	
	-- Draw team color
	draw.RoundedBox(0, 10, y - 90, 100, 100, JobColor)
	-- Nickname
	draw.DrawText(Nickname, "DarkRPHUD2", x + 100, y - 75, Color(255,255,255,transparency))
	-- Job
	draw.DrawText(Job or "", "DarkRPHUD2", x + 100, y - 55, Color(255,255,255,transparency))
	-- Health
	draw.DrawText(math.Max(0, math.Round(ply:Health())), "DarkRPHUD2", x + 140 + (200 - 10)/2, y - 24, Color(255,255,255,200), 1)
	-- Money
	draw.DrawText("$" .. string.Comma(Money), "DarkRPHUD2", x + 275, y - 76, Color(255,255,255,transparency))
	-- Salary
	draw.DrawText("Salary: $" .. Salary, "DarkRPHUD2", x + 275, y - 55, Color(255,255,255,transparency))
	-- Ammo
	
	local actwep = ply:GetActiveWeapon()
	if(IsValid(actwep)) then 
	
		local clipleft = actwep:Clip1()
		local totalLeft = ply:GetAmmoCount( actwep:GetPrimaryAmmoType())
	
		if totalLeft > 0  or clipleft > 0 then
	
			local ammoPlace = x + 390
		
			if totalLeft > 100 then
				ammoPlace = x + 386
			end
		
			if totalLeft < 100 and clipleft > 9 then
				ammoPlace = x + 386
			end
		
			if totalLeft > 100 and clipleft > 9 then
				ammoPlace = x + 380
			end
	
			-- Ammo Box
			draw.RoundedBox(0, x + 390, ScrH() - 70, 100, 60, Color(34,37,36,255))
			draw.RoundedBox(0, x + 390, ScrH() - 50, 100, 40, Color(42,44,43,255))
	
			draw.DrawText(clipleft .. " | " .. totalLeft, "DarkRPHUD2",  x + ammoPlace, ScrH() - 40, Color(255,255,255,255))
			draw.DrawText("Ammo", "DarkRPHUD2", x + 413, ScrH() - 68, Color(255,255,255,255))
	
		end
	
		if totalLeft == 0 and clipleft == 0 then
			draw.RoundedBox(0, x + 390, ScrH() - 70, 100, 60, Color(34,37,36,255))
			draw.RoundedBox(0, x + 390, ScrH() - 50, 100, 40, Color(42,44,43,255))
	
			draw.DrawText("0 | 0", "DarkRPHUD2",  x + 425, ScrH() - 40, Color(255,255,255,255))
			draw.DrawText("Ammo", "DarkRPHUD2", x + 420, ScrH() - 68, Color(255,255,255,255))	
		end
		
	end
	
	elMat = Material( "materials/icon16/table.png")
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(elMat)
	surface.DrawTexturedRect(16, y - 114, 18, 18 )
	
	-- Setup avatar picture
	if LocalPlayer():IsValid() then
	
		if avatar_f == 0 then
			local Avatar = vgui.Create( "AvatarImage", Panel)
			Avatar:SetSize( 90, 90 )
			Avatar:SetPos(15, ScrH() - 105)
			Avatar:SetPlayer( LocalPlayer(), 64)
			avatar_f = 1
			
		end
	
	end

end
hook.Add("HUDPaint", "DrawElHud", hudPaint)

local function HideThings( name )
if(name == "CHudHealth") or (name == "CHudBattery") or (name == "CHudAmmo") or (name == "CHudSecondaryAmmo") then
return false
end
end
hook.Add( "HUDShouldDraw", "HideThings", HideThings )