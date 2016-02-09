DeriveGamemode( "sandbox" )
include("shared.lua")

include("player/hud.lua")
include("player/menus.lua")
include("player/scoreboard.lua")
include("player/worldinfo.lua")

function GM:PostDrawViewModel( vm, ply, weapon )
  if ( weapon.UseHands || !weapon:IsScripted() ) then
    local hands = LocalPlayer():GetHands()
    if ( IsValid( hands ) ) then hands:DrawModel() end
  end
end

function GM:HUDDrawTargetID()
end

function RecieveChatText( um )
	local r = um:ReadShort()
	local g = um:ReadShort()
	local b = um:ReadShort()
	local color = Color( r, g, b )
	local text = um:ReadString()
	
	chat.AddText( color, text )
end
usermessage.Hook( "chatmsg", RecieveChatText )

function RecieveConsoleText( um )
	local r = um:ReadShort()
	local g = um:ReadShort()
	local b = um:ReadShort()
	local color = Color( r, g, b )
	local text = um:ReadString()
	
	MsgC( color, text )
end
usermessage.Hook( "consolemsg", RecieveConsoleText )

net.Receive( "job_amount", function()

	job_amount = net.ReadUInt( 8 )
	job_table = net.ReadTable()
	
end )

net.Receive( "stock_table", function()

	stock_table = {}
	stock_table = net.ReadTable()
	
end )

net.Receive( "gun_table", function()

	gun_table = {}
	gun_table = net.ReadTable()
	
end )


