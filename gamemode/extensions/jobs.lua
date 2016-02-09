local pm = FindMetaTable("Player")
local joblist = {}

local jobclass = {}
jobclass.Name = "Default"
jobclass.Salary = 30
jobclass.Command = "default"
jobclass.teamid = 1

function newJob( name, salary, command, color, models )
	
	local newJobClass = table.Copy( jobclass )
	
	if name and salary and command and color and models then
		newJobClass.Name = name
		newJobClass.Salary = salary
		newJobClass.Color = color
		newJobClass.Command = command	
		newJobClass.Models = models
	end
	table.insert( joblist, newJobClass )
	
end

function getJobs(jobTable)
	return joblist
end

function SetupJobs()	
	
	include("/config/addjobs.lua")

	local c = 5
	local jobs = 0
	for k, v in pairs (joblist) do
		team.SetUp(c, v.Command, v.Color)
		v.teamid = c
		c = c + 1
		jobs = jobs + 1
	end
	job_amount = jobs
	job_table = joblist
end

function pm:GetJob()
	return findJobByCommand(self:GetNWString("tingrp_job"))
end

function pm:GetJobClass()
	return self:GetNWString("tingrp_job")
end

function pm:JobColor()
	local r = self:GetNWInt("tingrp_r")
	local g = self:GetNWInt("tingrp_g")
	local b = self:GetNWInt("tingrp_b")
	return Color(r, g, b, 255)
end

function pm:SetJob(job)
	local orig = job
	local job = findJobByCommand(job)
	self:SetPData("tingrp_job", job.Command)
	self:SetNWString("tingrp_job", job.Command)
	
	self:SetPData("tingrp_salary", job.Salary)
	self:SetNWString("tingrp_salary", job.Salary)
	
	self:SetPData("tingrp_jobname", job.Name)
	self:SetNWString("tingrp_jobname", job.Name)
	
	self:SetNWInt("tingrp_r", job.Color["r"])
	self:SetNWInt("tingrp_g", job.Color["g"])
	self:SetNWInt("tingrp_b", job.Color["b"])
	
	self:SetTeam(findJobTeamByCommand(orig))
	
end

function findJobTeamByCommand(name)
	for k, v in pairs (joblist) do
		if v.Command == name then
			return v.teamid	
		end
	end
	return 0
end

function findJobByCommand(name)

	local flag = 0
	
	for k, v in pairs (joblist) do
		if v.Command == name then
			flag = 1
			return v	
		end
	end
	
	if flag == 0 then
		
		local noex = {}
		noex.Name = "Unemployed"
		noex.Salary = 0
		noex.Command = "unemployed"
		noex.Color = Color(255, 255, 115, 0)
		noex.Models = {"models/player/kleiner.mdl"}
	
		return noex
	end

end

