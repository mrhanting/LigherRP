local pm = FindMetaTable("Player")

-- Send a colored message to client
function pm:SendMsg( color, text )
	umsg.Start( "chatmsg", self )
		umsg.Short( color.r )
		umsg.Short( color.g )
		umsg.Short( color.b )
		umsg.String( text )
	umsg.End()
end

function pm:SendConsoleMsg( color, text )
	umsg.Start( "consolemsg", self )
		umsg.Short( color.r )
		umsg.Short( color.g )
		umsg.Short( color.b )
		umsg.String( text )
	umsg.End()
end

function TellAll(text)
	for k, v in pairs (player.GetAll()) do
		v:SendMsg(Color(255, 0, 0, 255), text)
	end
end
function TellAdmins(text)
	for k, v in pairs (player.GetAll()) do
		if IsAdmin(v) then
			v:SendMsg(Color(255, 0, 0, 255), text)
		end
	end
end

function TellAdminsConsole(text)
	for k, v in pairs (player.GetAll()) do
		if checkAdmin(v) then
			v:SendConsoleMsg(Color(255, 0, 0, 255), text)
		end
	end
end