local pm = FindMetaTable("Player")

local basegun = {}
basegun.Name = "Default"
basegun.Class = "default"
basegun.Command = "buydefault"
basegun.Cost = 0

function addGun(name, class, command, cost)

	local newGun = table.Copy( basegun )
	
	if name and class and command and cost then
		newGun.Name = name
		newGun.Class = class
		newGun.Command = command
		newGun.Cost = cost
	end
	table.insert( gun_table, newGun )
	
end

function GetGunClass(command)
	for k, v in pairs (gun_table) do
		if v.Command == command then
			return v.Class
		end
	end
	return ""
end

function GetGun(command)
	for k, v in pairs (gun_table) do
		if v.Command == command then
			return v
		end
	end
	return false
end