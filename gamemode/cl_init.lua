DeriveGamemode( "sandbox" )
include("shared.lua")
local show_players = false
job_amount = 0

	surface.CreateFont("DarkRPHUD1", {
        size = 16,
        weight = 600,
        antialias = true,
        shadow = true,
        font = tahoma
	})

    surface.CreateFont("DarkRPHUD2", {
        size = 23,
        weight = 400,
        antialias = true,
        shadow = false,
        font = "Coolvetica"
	})

function GetAmmoForCurrentWeapon( ply )
	if ( !IsValid( ply ) ) then return -1 end

	local wep = ply:GetActiveWeapon()
	if ( !IsValid( wep ) ) then return -1 end
	
	local clip = ply:GetActiveWeapon():Clip1()

	return clip .. " / " .. ply:GetAmmoCount( wep:GetPrimaryAmmoType() )
end

function GM:PostDrawViewModel( vm, ply, weapon )
  if ( weapon.UseHands || !weapon:IsScripted() ) then
    local hands = LocalPlayer():GetHands()
    if ( IsValid( hands ) ) then hands:DrawModel() end
  end
end

function GM:ScoreboardShow()
	show_players = true
end

function GM:ScoreboardHide()
	show_players = false
end

function GM:HUDDrawScoreBoard()	
	if show_players then
		
		local players = player.GetAll()
		draw.RoundedBox( 0, (ScrW() / 2) - 500, 25, 1000, 600, Color(20,20,20,100))
		draw.RoundedBox( 0, (ScrW() / 2) - 498, 27, 996, 596, Color(40,40,40,125))
		
		draw.DrawText( "Player Name", "Trebuchet24", (ScrW() / 2) - 490, 30, Color(255,255,255,255))
		draw.DrawText( "Player Value", "Trebuchet24", (ScrW() / 2) - 100, 30, Color(255,255,255,255))
		draw.DrawText( "Player Job", "Trebuchet24", (ScrW() / 2) + 100, 30, Color(255,255,255,255))
		
		local cur_y = 65
		for k, v in pairs (players) do
		
			local plyMoney = v:GetNWInt("tingrp_money")
			local plyJob = v:GetNWString("tingrp_jobname")
			local plyNick = v:GetNWString("tingrp_rpname") or v:Nick()
			local r = v:GetNWInt("tingrp_r")
			local g = v:GetNWInt("tingrp_g")
			local b = v:GetNWInt("tingrp_b")
			
			draw.DrawText( plyNick, "Trebuchet24", (ScrW() / 2) - 490, cur_y, Color(255,255,255,255))
			draw.DrawText( "$ " .. string.Comma(plyMoney), "Trebuchet24", (ScrW() / 2) - 100, cur_y, Color(255,255,255,255))
			draw.DrawText( plyJob, "Trebuchet24", (ScrW() / 2) + 100, cur_y, Color(r, g, b, 255))
			cur_y = cur_y + 30		
			
		end				
	end	
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

hook.Add("PlayerSpawnSWEP", "AdminOnlySWEPs", function( ply, class, wep )
	print("No Weapons")
	return false
end)

function GM:SpawnMenuEnabled()
	return false;
end

function GM:HUDDrawTargetID()
end

function RecieveChatText( um )
	local r = um:ReadShort()
	local g = um:ReadShort()
	local b = um:ReadShort()
	local color = Color( r, g, b )
	local text = um:ReadString()
	
	chat.AddText( color, text )
end
usermessage.Hook( "chatmsg", RecieveChatText )

function RecieveConsoleText( um )
	local r = um:ReadShort()
	local g = um:ReadShort()
	local b = um:ReadShort()
	local color = Color( r, g, b )
	local text = um:ReadString()
	
	MsgC( color, text )
end
usermessage.Hook( "consolemsg", RecieveConsoleText )

local function MyMenu()
    local Menu = vgui.Create("DFrame")
    Menu:SetPos(ScrW() / 2 - 400, ScrH() / 2 - 400)
    Menu:SetSize(800, 700)
	Menu:SetBackgroundBlur(true)
	Menu:SetTitle("Job Selection")
    Menu:SetText("My Menu")
    Menu:SetDraggable(false)
    Menu:ShowCloseButton(true)
    Menu:MakePopup()
 
	local offset = 50
	local offset_x = 25
	for k, v in pairs (job_table) do 
		local DermaButton = vgui.Create( "DButton" )	
		DermaButton:SetParent( Menu )	
		DermaButton:SetText( v["Name"] )				
		DermaButton:SetPos( offset_x, offset )					
		DermaButton:SetSize( 250, 50 )				
		DermaButton.DoClick = function()			
			RunConsoleCommand( "say", "/team " .. v["Command"] )
		end
		offset = offset + 100
		if offset >= 625 then
			offset_x = offset_x + 275
			offset = 50
		end
	end

end
usermessage.Hook("panel1", MyMenu)

net.Receive( "job_amount", function()

	job_amount = net.ReadUInt( 8 )
	job_table = net.ReadTable()
	
end )

net.Receive( "stock_table", function()

	stock_table = {}
	stock_table = net.ReadTable()
	
end )

local function DrawPlayerInfo(ply)

	local zOffset = 50
	local x = ply:GetPos().x			//Get the X position of our player
	local y = ply:GetPos().y			//Get the Y position of our player
	local z = ply:GetPos().z			//Get the Z position of our player
	local pos = Vector(x,y,z+zOffset)	//Add our offset onto the Vector
	local pos2d = pos:ToScreen()		//Change the 3D vector to a 2D one
	local ply_r = ply:GetNWInt("tingrp_r")
	local ply_g = ply:GetNWInt("tingrp_g")
	local ply_b = ply:GetNWInt("tingrp_b")
	local JobColor = Color(ply_r, ply_g, ply_b, 255)
	local ply_money = tonumber(ply:GetNWInt("tingrp_money"))
	local ph = ply:Health()
	local ply_nameTxt = ply:GetNWString("tingrp_rpname")
	
	if ply:GetUserGroup() == "admin" then
		ply_nameTxt = "[A] " .. ply_nameTxt
	elseif ply:GetUserGroup() == "superadmin" then
		ply_nameTxt = "[SA] " .. ply_nameTxt
	end
	
	draw.DrawText( ply_nameTxt, "Default",pos2d.x,pos2d.y - 15,Color(255,255,255,255),TEXT_ALIGN_CENTER)
	
	if ph >= 90 then
		draw.DrawText("Healthy" ,"Default",pos2d.x,pos2d.y,Color(0, 255, 0,255),TEXT_ALIGN_CENTER)
	elseif ph < 90 and ph > 66 then 
		draw.DrawText("Bruised" ,"Default",pos2d.x,pos2d.y,Color(255,255,0,255),TEXT_ALIGN_CENTER)	
	elseif ph <= 66 and ph > 33 then
		draw.DrawText("Injured" ,"Default",pos2d.x,pos2d.y,Color(255,140,0,255),TEXT_ALIGN_CENTER)	
	elseif ph <= 100 then
		draw.DrawText("Near Death" ,"Default",pos2d.x,pos2d.y,Color(255, 0, 0,255),TEXT_ALIGN_CENTER)	
	end
	
	draw.DrawText(ply:GetNWString("tingrp_jobname") ,"Default",pos2d.x,pos2d.y + 15,JobColor,TEXT_ALIGN_CENTER)
	
	if ply_money < 5000 then
		draw.DrawText("Poor" ,"Default",pos2d.x,pos2d.y + 30,Color(255,0,0,255),TEXT_ALIGN_CENTER)
	elseif ply_money >= 5000 and ply_money < 25000 then
		draw.DrawText("Lower Class" ,"Default",pos2d.x,pos2d.y + 30,Color(245,255,84,255),TEXT_ALIGN_CENTER)		
	elseif ply_money >= 25000 and ply_money < 100000 then
		draw.DrawText("Middle Class" ,"Default",pos2d.x,pos2d.y + 30,Color(136,255,84,255),TEXT_ALIGN_CENTER)		
	elseif ply_money >= 100000 then
		draw.DrawText("Upper Class" ,"Default",pos2d.x,pos2d.y + 30,Color(210,84,255,255),TEXT_ALIGN_CENTER)
	end
	
end

hook.Add("HUDPaint", "LoopThroughPlayers", function()	//Add our function to the HUDPaint hook
	for k,v in pairs (player.GetAll()) do	//Loop through all the players
		
		if v:Alive() then
			local plydist = LocalPlayer():GetPos()
			local otherdist = v:GetPos()
			local dist = plydist:Distance(otherdist)
			
			if dist < 300 then
				DrawPlayerInfo(v)
			end		
		end
		
	end
end)