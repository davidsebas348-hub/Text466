--// TOGGLE TARGET BATON

_G.TargetBaton = not _G.TargetBaton

if not _G.TargetBaton then
    return
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local remote = ReplicatedStorage
    .ShopAssetsFolder
    .AssetRemotes
    .BatonRemotes
    .HitRemote

getgenv().TargetPlayer = getgenv().TargetPlayer or nil

local function getTargetCharacter()
    local name = getgenv().TargetPlayer
    if not name then return nil end

    local player = Players:FindFirstChild(name)
    if player and player.Character then
        return player.Character
    end

    return nil
end

local function getArgs(targetCharacter)
    return {
        "BoltBaton",
        Vector3.new(-42.649593353271484, 133.2579345703125, -9.06042194366455),
        {
            SwingSound = "rbxassetid://9116278972",
            SpecialCooldown = 5,
            HasIdleVFX = true,
            PassiveChance = 0,
            PassiveAbility = true,
            DefaultDamage = 0,
            BlockDamage = 13,
            LoopSound = true,
            AnimationName = "WeaponAnimation",
            Name = "BoltBaton",
            TargetSound = {"rbxassetid://5507336814"},
            ImpactSound = {"rbxassetid://5507336814"},
            Force = 200000,
            SpecialBuildup = 14,
            Damage = 0
        },
        targetCharacter,
        false,
        false,
        false
    }
end

task.spawn(function()

    while _G.TargetBaton do

        local targetChar = getTargetCharacter()

        if not targetChar then
            task.wait(0.5)
            continue
        end

        pcall(function()
            remote:FireServer(unpack(getArgs(targetChar)))
        end)

        task.wait(0.2)
    end

end)
