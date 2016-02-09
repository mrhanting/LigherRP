local show_players = false

	surface.CreateFont("DarkRPHUD1", {
        size = 16,
        weight = 600,
        antialias = true,
        shadow = true,
        font = tahoma
	})

    surface.CreateFont("DarkRPHUD2", {
        size = 23,
        weight = 400,
        antialias = true,
        shadow = false,
        font = "Coolvetica"
	})
	
	
	
function GM:ScoreboardShow()
	show_players = true
end

function GM:ScoreboardHide()
	show_players = false
end

function GM:HUDDrawScoreBoard()	
	if show_players then
		
		local players = player.GetAll()
		draw.RoundedBox( 0, (ScrW() / 2) - 500, 25, 1000, 600, Color(20,20,20,100))
		draw.RoundedBox( 0, (ScrW() / 2) - 498, 27, 996, 596, Color(40,40,40,125))
		
		draw.DrawText( "Player Name", "Trebuchet24", (ScrW() / 2) - 490, 30, Color(255,255,255,255))
		draw.DrawText( "Player Value", "Trebuchet24", (ScrW() / 2) - 100, 30, Color(255,255,255,255))
		draw.DrawText( "Player Job", "Trebuchet24", (ScrW() / 2) + 100, 30, Color(255,255,255,255))
		
		local cur_y = 65
		for k, v in pairs (players) do
		
			local plyMoney = v:GetNWInt("tingrp_money")
			local plyJob = v:GetNWString("tingrp_jobname")
			local plyNick = v:GetNWString("tingrp_rpname") or v:Nick()
			local r = v:GetNWInt("tingrp_r")
			local g = v:GetNWInt("tingrp_g")
			local b = v:GetNWInt("tingrp_b")
			
			draw.DrawText( plyNick, "Trebuchet24", (ScrW() / 2) - 490, cur_y, Color(255,255,255,255))
			draw.DrawText( "$ " .. string.Comma(plyMoney), "Trebuchet24", (ScrW() / 2) - 100, cur_y, Color(255,255,255,255))
			draw.DrawText( plyJob, "Trebuchet24", (ScrW() / 2) + 100, cur_y, Color(r, g, b, 255))
			cur_y = cur_y + 30		
			
		end				
	end	
end



function GM:SpawnMenuEnabled()
	return false;
end