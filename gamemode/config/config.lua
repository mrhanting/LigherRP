-- DON'T TOUCH --
Config = {}

-- IDEAS LIST
--[[

1. Salary
2. Runner Jobs
3. REALISTIC PRICES
4. Bank system. If you die, you lose all on-hand money.
5. Bitcoin mining
6. Cold-War surplus weapons

]]

-- Set the damage done by all SWEPs | Default: 1
Config.normal_damage = 2
-- Set salary system | Default: flase
Config.doSalary = true
-- Set NASDAQ stocks for the server to update
Config.stocks = {
	"AAPL",
	"MSFT",
	"GOOG"
}

-- Set weapons that can't be dropped
Config.nodrop = {

	"weapon_physcannon",
	"gmod_camera",
	"weapon_physgun",
	"gmod_tool"

}