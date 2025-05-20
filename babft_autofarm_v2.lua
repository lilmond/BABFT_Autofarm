getgenv().AUTOFARM_ACTIVE = true -- Set to false to stop the script.

local player = game:GetService("Players").LocalPlayer
local virtualuser = game:GetService("VirtualUser")
local normalStages = workspace.BoatStages.NormalStages

local function characterAdded(character)
    local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildWhichIsA("Humanoid") or character:WaitForChild("Humanoid")

    local bp = Instance.new("BodyPosition")
    bp.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bp.P = 100000
    bp.D = 1000
    bp.Position = hrp.Position
    bp.Parent = hrp

    for i, stage in pairs(normalStages:GetChildren()) do
        local darkness_part = stage:FindFirstChild("DarknessPart")
        if darkness_part then
            bp.Position = darkness_part.Position
            wait(2.5)
        end
    end

    bp.Position = normalStages.TheEnd.GoldenChest.Trigger.Position
end

local function loopAutoWin()
    local con = nil
    con = player.CharacterAdded:Connect(function(character)
        if not getgenv().AUTOFARM_ACTIVE then
            con:Disconnect()
            return
        end
        wait(8)
        characterAdded(character)
    end)

    if player.Character then
        characterAdded(player.Character)
    end
end

coroutine.wrap(function()
    while getgenv().AUTOFARM_ACTIVE do
        virtualuser:CaptureController()
        virtualuser:ClickButton2(Vector2.new())
        wait(1)
    end
end)()

loopAutoWin()
