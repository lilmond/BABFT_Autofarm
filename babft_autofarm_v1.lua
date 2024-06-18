-- Credits: github@lilmond
-- Showcase: https://www.youtube.com/watch?v=WZfTP-VbLsM

local VirtualUser = game:GetService("VirtualUser")
local player = game:GetService("Players").LocalPlayer
local stages = game:GetService("Workspace").BoatStages.NormalStages
local goldenChest = game:GetService("Workspace").BoatStages.NormalStages.TheEnd.GoldenChest.Trigger

local function win()
    repeat wait() until player.Character
    local character = player.Character or player:WaitForChild("Character")
    repeat wait() until character:FindFirstChild("HumanoidRootPart")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    repeat wait() until character:FindFirstChild("Humanoid")
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    
    for i = 1, 10 do
        local stage = stages:FindFirstChild("CaveStage" .. tostring(i))
        local blackPart = stage:FindFirstChild("DarknessPart")
        if not blackPart then continue end
        
        for _ = 1, 20 do
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            rootPart.CFrame = blackPart.CFrame -- * CFrame.new(0, Random.new():NextNumber(-50, 50), 0)
            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            wait(0.1)
        end
         
    end

    for i = 1, 300 do
        rootPart.CFrame = goldenChest.CFrame
        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)

        wait(0.1)

        if not (string.sub(rootPart:GetFullName():lower(), 1, 9) == "workspace") then break end

        if i >= 200 then
            humanoid.Health = 0
        end
    end
end

local farms = 0

while wait() do
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
    win()

    farms += 1
    print("Farms: " .. tostring(farms))

    -- player.CharacterAdded:Wait()

    wait(1)
end
