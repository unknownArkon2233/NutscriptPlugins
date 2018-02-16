PLUGIN.name = "Anti-Bunny Hop"
PLUGIN.author = "Muse"
PLUGIN.desc = "Stop the minges from spam jumping."

nut.config.add("Player Jump Delay", 2, "Player Jump Delay", nil, {
	data = {min = 1, max = 5},
	category = "Anti Mingery"
})

hook.Add("StartCommand", "DRgg345325409-vk,m", function(ply,cmd)
	if cmd:KeyDown(IN_JUMP) then
		if !(ply:InVehicle() or ply:GetMoveType() == MOVETYPE_NOCLIP) then
			if !(ply.LastJump) then ply.LastJump = CurTime() end
			if ply.LastJump <= CurTime() then
				ply.LastJump = CurTime() + 2
			else
				cmd:RemoveKey(IN_JUMP)
			end
		end
	end
end)
