local pm = FindMetaTable("Player")

function CheckChatCommands(ply, text)

	if string.sub(text, 1, 7) == "/buygun" and ply:GetJobClass() == "gundealer" then
	
		local gun = string.Split(text, " ")[2]
		local tr = ply:GetEyeTrace()
		local gun_class = GetGunClass(gun)
		local gun_cost = GetGun(gun).Cost
		
		if ply:GetMoney() > gun_cost then	
			local ent = ents.Create(gun_class)
			local ply_f = ply:GetForward()
			
			local pos = ply_f + ply:GetPos()
			ent:SetPos(pos)
			ent:Spawn()		
			ply:AddMoney(gun_cost * -1)
		else
			ply:ChatPrint("You cannot afford this!")
		end	
		return false
	end
	
	if string.sub(text, 1, 5) == "/drop" then
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) then
			ply:DropWeapon(wep)
			ply:SelectWeapon("weapon_physgun")
		end
		return false
	end

	if string.sub(text, 1, 9) == "/setmoney" then
		if checkAdmin(ply) then
			local player = findPlayer(string.Split(text, " ")[2])
			local money = tonumber(string.Split(text, " ")[3])
			player:SetMoney(money)
			ply:ChatPrint("Money set to " .. tostring(money))
		end
		return false
	end
	
	if string.sub(text, 1, 5) == "/team" then
		local job = string.Split(text, " ")[2]
		ply:SetJob(job)
		ply:SendMsg(Color(255, 0, 0, 255), "Job set to " .. job .. " (" .. ply:Team() .. ")")
		ply:Kill()
		return false
	end
	
	if string.sub(text, 1, 6) == "/stock" then
		for k, v in pairs (stock_table) do
			ply:ChatPrint(v)
		end
		return false
	end
	
	if string.sub(text, 1, 8) == "/setteam" then
		if checkAdmin(ply) then
			local player = findPlayer(string.Split(text, " ")[2])
			local team = string.Split(text, " ")[3]
			player:SetJob(team)
			ply:ChatPrint("Set player " .. player:Nick() .. " to Team " .. team)
			player:Kill()
		end
		return false
	end
	
	if string.sub(text, 1, 5) == "/name"  or string.sub(text, 1, 5) == "/nick" then
		local nameArgs = string.Split(text, " ")
		local name = ""
		
		local c = 2
		while c <= table.Count( nameArgs ) do
			if name == "" then
				name = name .. nameArgs[c] .. " "
			elseif c == table.Count( nameArgs ) then 
				name = name .. nameArgs[c] .. " "
			else
				name = name .. nameArgs[c]
			end
			c = c + 1
		end
		
		if string.len(name) < 4 then
			ply:ChatPrint("Name must be at least 4 characters long!")
			return false
		end
		ply:SetName(name)
		ply:ChatPrint("Changed name to " .. name)
		return false
	end
	
	if string.sub(text, 1, 8) == "/getjobs" then
		local jobs = getJobs()
		for k, v in pairs (jobs) do
			ply:ChatPrint(v.Name .. ": $" .. v.Salary)
		end
		ply:ChatPrint("Jobs: " .. job_amount)
		return false
	end
	
end
hook.Add("PlayerSay", "checkForComms", CheckChatCommands)

function pm:GetData()
	self:SetNWString("tingrp_rpname", self:GetPData("tingrp_rpname"))
end