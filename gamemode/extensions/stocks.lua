function StockPrice(symbol)
	
	http.Fetch( "http://imperialgmod.com/stock/index.php?stock=" .. symbol,
	function( body, len, headers, code )
		-- The first argument is the HTML we asked for.
		price = body
		table.insert(stock_table, symbol .. "," .. body)
	end,
	function( error )
		stockprice = -1
	end
    )	
	
end

function UpdateStocks()
	if (timer.Exists( "stock_update_timer")) then
		timer.Remove("stock_update_timer")
	end
	
	local count = table.Count(Config.stocks)
	print("Getting stock values for " .. tostring(count) .. " stocks...")
	for k, v in pairs (Config.stocks) do
		stock_table = {}
		StockPrice(v)
	end
	timer.Create("stock_update_timer", 30, 0, function() UpdateStocks() end )
end

hook.Add("InitPostEntity", "updatedastocks", function()

	timer.Create("stock_update_timer_init", 10, 1, function() UpdateStocks() end )

end )
