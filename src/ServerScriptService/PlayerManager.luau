--!strict
-- PlayerManager.luau
-- Manages player data (leaderstats), upgrades structure, and cyber base initialization.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules", 10)

-- Structure for future gadgets and drones configuration per player
local PlayerDataStructure = {}

local function setupLeaderstats(player: Player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	
	local data = Instance.new("IntValue")
	data.Name = "Data"
	data.Value = 0
	data.Parent = leaderstats
	
	local maxData = Instance.new("IntValue")
	maxData.Name = "MaxData"
	maxData.Value = 25
	maxData.Parent = leaderstats
	
	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Value = 0
	coins.Parent = leaderstats
	
	local rank = Instance.new("StringValue")
	rank.Name = "Rank"
	rank.Value = "Script Kiddie"
	rank.Parent = leaderstats
	
	local rebirth = Instance.new("IntValue")
	rebirth.Name = "Rebirth"
	rebirth.Value = 0
	rebirth.Parent = leaderstats
	
	leaderstats.Parent = player
	
	-- Initialize player custom runtime state (gadgets, drones, firewall stats)
	PlayerDataStructure[player.UserId] = {
		EquippedGadget = nil,
		ActiveDrones = {},
		FirewallLevel = 1,
		BandwidthLevel = 1,
	}
	
	print(player.Name .. " leaderstats & data structure initialized.")
end

local function cleanupPlayer(player: Player)
	PlayerDataStructure[player.UserId] = nil
end

Players.PlayerAdded:Connect(setupLeaderstats)
Players.PlayerRemoving:Connect(cleanupPlayer)

-- Handle players already in game if script reloaded
for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(setupLeaderstats, player)
end

return PlayerManager
