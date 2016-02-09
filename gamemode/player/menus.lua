job_amount = 0

local function F4Menu()
    local Menu = vgui.Create("DFrame")
    Menu:SetPos(ScrW() / 2 - 400, ScrH() / 2 - 400)
    Menu:SetSize(800, 700)
	Menu:SetBackgroundBlur(true)
	Menu:SetTitle("Job Selection")
    Menu:SetDraggable(false)
    Menu:ShowCloseButton(true)
    Menu:MakePopup()
 
	local offset = 50
	local offset_x = 25
	for k, v in pairs (job_table) do 
		local DermaButton = vgui.Create( "DButton" )	
		DermaButton:SetParent( Menu )	
		DermaButton:SetText( v["Name"] )				
		DermaButton:SetPos( offset_x, offset )					
		DermaButton:SetSize( 250, 50 )				
		DermaButton.DoClick = function()			
			RunConsoleCommand( "say", "/team " .. v["Command"] )
			Menu:Remove()
		end
		offset = offset + 100
		if offset >= 625 then
			offset_x = offset_x + 275
			offset = 50
		end
	end

end
usermessage.Hook("f4menu", F4Menu)

local function F3Menu()
    local Menu = vgui.Create("DFrame")
    Menu:SetPos(ScrW() / 2 - 400, ScrH() / 2 - 400)
    Menu:SetSize(800, 700)
	Menu:SetBackgroundBlur(true)
	Menu:SetTitle("Merchant Menu")
    Menu:SetDraggable(false)
    Menu:ShowCloseButton(true)
    Menu:MakePopup()
	
	local offset = 50
	local offset_x = 25
	for k, v in pairs (gun_table) do 
		local DermaButton = vgui.Create( "DButton" )	
		DermaButton:SetParent( Menu )	
		DermaButton:SetText( v["Name"] .. " ($" .. v["Cost"] .. ")")				
		DermaButton:SetPos( offset_x, offset )					
		DermaButton:SetSize( 250, 50 )				
		DermaButton.DoClick = function()			
			RunConsoleCommand( "say", "/buygun " .. v["Command"] )
			Menu:Remove()
		end
		offset = offset + 100
		if offset >= 625 then
			offset_x = offset_x + 275
			offset = 50
		end
	end
	
end
usermessage.Hook("f3menu", F3Menu)