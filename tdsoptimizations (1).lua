-- lobby optimizations
getgenv().lobbyoptimizations = true
getgenv().removeplayers = true
-- game optimizations
getgenv().gameoptimizations = true

task.spawn(function()
    while getgenv().lobbyoptimizations and game.PlaceId == 3260590327 do
        task.wait(2)
        for _, folderName in ipairs({
            "Credits", "Announcements", "Paintings",
            "Artboards", "Leaderboards", "Survival", 
            "Hardcore", "CrateArea", "InvisibleBarriers",
            "Environment"
        }) do
            if game.Workspace:FindFirstChild(folderName) then
                for _, item in ipairs(game.Workspace[folderName]:GetChildren()) do
                    item:Destroy()
                end
            end
        end
        
        if getgenv().removeplayers then
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    player:Remove()
                    if game.Workspace:FindFirstChild(player.Name) then
                        game.Workspace[player.Name]:Destroy()
                    end
                end
            end
        end
    end       
end)

task.spawn(function()
    if getgenv().gameoptimizations then
        repeat task.wait() until game:IsLoaded() and game.PlaceId == 5591597781
        game.Workspace.Map.Environment:Destroy()
        for _, item in ipairs(workspace.Terrain:GetChildren()) do
            if string.find(item.Name, "Effect") then -- delete all the effects
                item:Destroy()
            end
        end
        local laser = require(game:GetService("ReplicatedStorage").Client.Modules.Game.Compatibility.Modules.Laser)
        laser.Cast = function(...)
            return
        end
        laser.Bolt = function(...)
            return
        end
        laser.Lightning = function(...)
            return
        end
    end
end)