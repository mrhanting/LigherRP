local pm = FindMetaTable("Player")

function pm:SetMoney(new)
	self:SetPData("tingrp_money", new)
	self:SetNWInt("tingrp_money", new)
end

function pm:AddMoney(new)
	local old = self:GetPData("tingrp_money")
	local new = old + new
	self:SetPData("tingrp_money", new)
	self:SetNWInt("tingrp_money", new)
end

function pm:GetMoney()
	return tonumber(self:GetPData("tingrp_money"))
end

function pm:CheckMoneyExists()

	if self:GetPData("tingrp_money") then
		self:SetNWInt("tingrp_money", self:GetPData("tingrp_money"))
	else
		self:SetPData("tingrp_money", 1000)
		self:SetNWInt("tingrp_money", 1000)
	end

end

function SalaryCycle()
	
	if(timer.Exists("salary_cycle")) then
		timer.Remove("salary_cycle")
	end

	for k, v in pairs (player.GetAll()) do

		local plymoney = v:GetPData("tingrp_money") or 0
		local salary = v:GetPData("tingrp_salary")
		v:SetMoney((plymoney + salary))
		v:SendMsg(Color(255, 0, 0, 0), "Payday! You have recieved $" .. tostring(salary) .. "!")
	
	end
	
	timer.Create("salary_cycle", 300, 1, function() SalaryCycle() end )
end

function DoSalaryCycle()
	
	if Config.doSalary then
		timer.Create("salary_cycle_init", 300, 1, function() SalaryCycle() end )
	end
	
end
