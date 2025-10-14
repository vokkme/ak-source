-- Anti-Lag Script (No GUI) - Automatically removes aura items from all players + FPS Boost
getgenv().boostFPS = true 

repeat task.wait() until game:IsLoaded();

local vim = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

setfpscap(5000)

CoreGui.DescendantAdded:Connect(function(d)
   if d.Name == "MainView" and d.Parent.Name == "DevConsoleUI" and boostFPS then
       task.wait()
       local screen = d.Parent.Parent.Parent
       screen.Enabled = false;
   end
end)

vim:SendKeyEvent(true, "F9", 0, game)    
wait()
vim:SendKeyEvent(false, "F9", 0, game)  

setfpscap(5000)

task.spawn(function()
	while true do task.wait()

        if not getgenv().boostFPS then
            local panel = CoreGui:FindFirstChild("DevConsoleMaster", true);

            if panel then
                panel.Enabled = true;
                vim:SendKeyEvent(true, "F9", 0, game)    
                vim:SendKeyEvent(false, "F9", 0, game)  
                repeat task.wait() until boostFPS
            end

            continue;
        end


		warn("")

		if not CoreGui:FindFirstChild("DevConsoleUI", true):FindFirstChild("MainView") then
			vim:SendKeyEvent(true, "F9", 0, game)    
			wait()
			vim:SendKeyEvent(false, "F9", 0, game)  
			continue
		end
	end
end)

local antiLagEnabled = true
local auraRemovalConnection

-- Function to remove aura items from all players
local function removeAuraItems()
    if not antiLagEnabled then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            for _, item in pairs(player.Character:GetChildren()) do
                if item:IsA("Accessory") or item:IsA("Tool") or item:IsA("BasePart") or item:IsA("Shirt") or item:IsA("Pants") then
                    if string.find(string.lower(item.Name), "aura") then
                        item:Destroy()
                    end
                end
            end
        end
    end
end

-- Start the anti-lag system
local function startAntiLag()
    if auraRemovalConnection then
        auraRemovalConnection:Disconnect()
    end
    
    auraRemovalConnection = RunService.Heartbeat:Connect(function()
        if antiLagEnabled then
            removeAuraItems()
        end
    end)
    
    print("Anti-Lag system started - Automatically removing aura items")
end

-- Stop the anti-lag system
local function stopAntiLag()
    antiLagEnabled = false
    if auraRemovalConnection then
        auraRemovalConnection:Disconnect()
        auraRemovalConnection = nil
    end
    print("Anti-Lag system stopped")
end

-- Start the anti-lag system immediately
startAntiLag()

-- Optional: Add a way to toggle the system on/off
-- You can call these functions in the console if needed:
-- To stop: stopAntiLag()
-- To start: startAntiLag()

-- Clean up when the script is destroyed
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == game:GetService("Players").LocalPlayer then
        stopAntiLag()
    end
end)
