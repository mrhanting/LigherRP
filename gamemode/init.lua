AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

print()
print("REFRESH OR SERVER START TRIGGER")
include("/config/config.lua")

print("Including extensions... (8)") 
include( "/extensions/player.lua")
include( "/extensions/money.lua")
include( "/extensions/merchant.lua")
include( "/extensions/stocks.lua")
include( "/extensions/chatcommands.lua")
include( "/extensions/jobs.lua")
include( "/extensions/chat.lua")
include( "/extensions/admin.lua")

print("Running setup scripts... (3)")
include( "/config/addguns.lua")
SetupJobs()
DoSalaryCycle()

print("Done loading gamemode!")

function GM:PlayerSpawn( ply )	
	-- Configure weapons and model
	SetLoadout(ply)
	SetModel(ply)
	
	-- Set job to class unemployed if no job detected
	local curJob = ply:GetJobClass()
	if curJob == "nojob" then
		curJob = "unemployed"
	end
	ply:SetJob(curJob)
	ply:CheckMoneyExists()
	ply:GetData()
	ply:SendNetVars()
	
end

function GM:PlayerInitialSpawn( ply )
	local ply_hasJoinedBefore = ply:GetPData("tingrp_joined") or "false"
	if (ply_hasJoinedBefore == "false") then
		ply:SetMoney(1000)
		ply:SetName(ply:Nick())
		ply:SetJob("Unemployed")
		ply:SetPData("tingrp_joined",  "true")
		print("New Player: " .. ply:Nick())
	end
end
