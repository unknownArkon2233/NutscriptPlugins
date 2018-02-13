PLUGIN.name = "Donation Panel Support"
PLUGIN.author = "Muse"
PLUGIN.desc = "Adds support for various donation panels."

// Use this command on your servers donation panel.
// ns_donation {SteamID} "item_name"
// You will need to set up a claim command for each item you want rewarded.

if SERVER then
	concommand.Add( "ns_donation", function( ply, cmd, args )
		if !IsValid(ply) then
			local steamid = args[1]
			local key = args[2]
			local value = args[3]
			util.SetPData(steamid, key, tonumber(util.GetPData(steamid, key, 0)) + tonumber(value))
		end
	end )
end


nut.command.add("claimsmg", {
	adminOnly = false,
	syntax = "",
	onRun = function(client, arg)
		local rewardID = "reward_smg" 	// make this unique, this is the second argument in the donation panel
										// for example, if your command is ns_donation {SteamID} "reward_smg" it's the "reward_smg" bit
		local val = tonumber(util.GetPData(client:SteamID(), rewardID, 0))
		if val >= 1 then
			local uniqueID = "weapon_smg" // An item you want to give.

			if (!nut.item.list[uniqueID]) then
				for k, v in SortedPairs(nut.item.list) do
					if (nut.util.stringMatches(v.name, uniqueID)) then
						uniqueID = k

						break
					end
				end
			end

			local inv = client:getChar():getInv()
			local succ, err = client:getChar():getInv():add(uniqueID)

			if (succ) then
				client:notifyLocalized("You have been rewarded your item.")
				for k,v in pairs(player.GetAll()) do
					v:ChatPrint(client:Nick().." has redeemed a reward for donating in the !store")
				end
				
				util.SetPData(client:SteamID(), rewardID, tonumber(util.GetPData(client:SteamID(), rewardID, 0)) - 1)
			else
				client:notifyLocalized("Woops, your inventory is full, no credits taken.")
			end
		else
			client:notifyLocalized("Woops, you do not have enough credits to recieve this.")
			client:notifyLocalized("You may purchase this at !store")
		end
	end
})
