net.Receive("bb_client_request_player_list", function(len)

	local flag = net.ReadInt()
		
	if flag == 0 then -- server could not process request
		local error_message = net.ReadString()
		return
	end 
		
	local t = net.ReadTable()
		
	for k, v in pairs(t) do
		PrintTable(v)
	end
		
	print(len)
		
end)