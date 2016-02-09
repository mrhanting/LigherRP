AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

print()
print("REFRESH OR SERVER START TRIGGER")
include("/config/config.lua")
util.AddNetworkString( "job_amount" )
util.AddNetworkString( "stock_table" )

print("Including extensions... (7)") 
include( "/extensions/player.lua")
include( "/extensions/money.lua")
include( "/extensions/stocks.lua")
include( "/extensions/chatcommands.lua")
include( "/extensions/jobs.lua")
include( "/extensions/chat.lua")
include( "/extensions/admin.lua")

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
	
	net.Start( "job_amount" )
		net.WriteInt(job_amount, 8 )
		net.WriteTable(job_table)
	net.Broadcast()
	
	net.Start( "stock_table" )
		net.WriteTable(stock_table)
	net.Broadcast()
	
end

function GM:PlayerInitialSpawn( ply )
	local ply_hasJoinedBefore = ply:GetPData("tingrp_joined") or "false"
	if (ply_hasJoinedBefore == "false") then
		ply:SetMoney(1000)
		ply:SetName(ply:Nick())
		ply:SetJob("Unemployed")
		print("New Player: " .. ply:Nick())
	end
end
