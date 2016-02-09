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

hook.Add("HUDPaint", "LoopThroughPlayers", function()
	for k,v in pairs (player.GetAll()) do
		
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

local function DrawEntityInfo(entity)

	local zOffset = 50
	local x = entity:GetPos().x			//Get the X position of our player
	local y = entity:GetPos().y			//Get the Y position of our player
	local z = entity:GetPos().z			//Get the Z position of our player
	local pos = Vector(x,y,z+zOffset)	//Add our offset onto the Vector
	local pos2d = pos:ToScreen()		//Change the 3D vector to a 2D one
	
	draw.DrawText(entity:GetClass() ,"Default",pos2d.x,pos2d.y + 100,Color(255,255,255,255),TEXT_ALIGN_CENTER)

end

hook.Add("HUDPaint", "LoopAllGuns", function()
	for k,v in pairs (ents.GetAll()) do
		
		if IsValid(v) then
			local plydist = LocalPlayer():GetPos()
			local otherdist = v:GetPos()
			local dist = plydist:Distance(otherdist)
			local owner = v:GetOwner()
			
			if IsValid(owner) and owner:GetClass() == "player" then
				-- Do nothing
			else			
				if dist < 300 and v:IsWeapon() then
					DrawEntityInfo(v)
				end					
			end
		end
		
	end
end)