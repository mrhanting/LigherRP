local pm = FindMetaTable("Player")
util.AddNetworkString( "job_amount" )
util.AddNetworkString( "stock_table" )
util.AddNetworkString( "gun_table" )

function SetLoadout(ply)

	local pc = ply:GetJobClass()
	ply:Give("weapon_physgun")
	ply:Give("weapon_physcannon")
	ply:Give("gmod_camera")
	ply:Give("gmod_tool")

end

function SetModel(ply)

	local pc = ply:GetJob()
	local model_amnt = table.Count(pc["Models"])
	local rand = math.random(1, model_amnt)
	local newModel = pc["Models"][rand]
	ply:SetModel(newModel)

end

function PlayerPickup( ply, ent )

	-- Enable admin player pickup
	if ( ply:checkAdmin() and ent:GetClass():lower() == "player" ) then
		return true
	end
	
	-- Restrict moving world props and other player's props
	if IsValid(ent) then
		local owner = FPP.entGetOwner(ent)
		if IsValid(owner) then
			if owner:Nick() == "world" then
				return false
			elseif owner:SteamID() == ply:SteamID() then
				return true
			else
				return false
			end
		end
		return false
	end
	return false
end
--hook.Add( "PhysgunPickup", "Allow Player Pickup", PlayerPickup )

function GM:SpawnMenuEnabled()
	return false;
end

function GM:PlayerDeath( victim, weapon, attacker )
	if victim == attacker then
		TellAdminsConsole( "[SUICIDE] " .. victim:Name() .. " killed himself!")
		local oldM = victim:GetMoney()
		if oldM >= 5000 then
			victim:SetMoney(oldM - 5000)
		else
			victim:SetMoney(0)
		end
	else
		TellAdminsConsole( "[KILL] " .. victim:RPName() .. " was killed by " .. attacker:RPName() .. " using " .. attacker:GetActiveWeapon():GetClass() .. "\n")
	end
end

hook.Add( "PlayerCanPickupWeapon", "noDoublePickup", function( ply, wep )
	if ( ply:HasWeapon( wep:GetClass() ) ) then return false end
end )

function pm:SendNetVars()
	net.Start( "job_amount" )
		net.WriteInt(job_amount, 8 )
		net.WriteTable(job_table)
	net.Broadcast()
	
	net.Start( "stock_table" )
		net.WriteTable(stock_table)
	net.Broadcast()
	
	net.Start( "gun_table" )
		net.WriteTable(gun_table)
	net.Broadcast()
end

function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )

	if ( hitgroup == HITGROUP_HEAD ) then
		dmginfo:ScaleDamage( Config.normal_damage * 4 )
	elseif ( hitgroup == HITGROUP_LEFTARM or
		hitgroup == HITGROUP_RIGHTARM or
		hitgroup == HITGROUP_LEFTLEG or
		hitgroup == HITGROUP_RIGHTLEG or
		hitgroup == HITGROUP_GEAR ) then
		dmginfo:ScaleDamage( Config.normal_damage / 2 )
	else	
		dmginfo:ScaleDamage( Config.normal_damage )	
	end
	
end

function GM:ShowSpare2( ply ) -- F4
    umsg.Start( "f4menu", ply ) 
    umsg.End()
end

function GM:ShowSpare1( ply ) -- F3
	if ply:GetJobClass() == "gundealer" then
		umsg.Start( "f3menu", ply ) 
		umsg.End()
	end
end

-- Find Player by SteamID
function findPlayerByID( steam )
	for _, v in ipairs(player.GetAll()) do
		if(string.find(string.lower(v:SteamID()), steam,1,true) != nil)
			then return v;
		end
	end
	return nil
end

-- Find Player by RP Name
function findPlayer( name )
	name = string.lower(name)
	for _, v in ipairs(player.GetAll()) do
		if(string.find(string.lower(v:GetPData("tingrp_rpname")), name,1,true) != nil)
			then return v;
		end
	end
	return nil
end

function pm:SetName(name)
	self:SetPData("tingrp_rpname", name)
	self:SetNWString("tingrp_rpname", name)
end

function pm:RPName()
	return self:GetNWString("tingrp_rpname")
end