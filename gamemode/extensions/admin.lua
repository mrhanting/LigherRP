-- Check if Player is Mod+
function checkMod(ply)
	if ply:GetUserGroup() == "moderator" or ply:GetUserGroup() == "superadmin" or ply:GetUserGroup() == "admin" then
		return true
	else
		return false
	end
end

-- Check if Player is Admin+
function checkAdmin(ply)
	if ply:GetUserGroup() == "superadmin" or ply:GetUserGroup() == "admin" then
		return true
	else
		return false
	end
end

-- Check if Player is SuperAdmin+
function checkSuperAdmin(ply)
	if ply:GetUserGroup() == "superadmin" then
		return true
	else
		return false
	end
end