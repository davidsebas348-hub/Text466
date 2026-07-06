--// TOGGLE TARGET BATON (MATCH PARCIAL)

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

    name = string.lower(name)

    for _, player in ipairs(Players:GetPlayers()) do

        local playerName = string.lower(player.Name)

        -- MATCH PARCIAL (ej: "seb" = "sebas")
        if string.find(playerName, name, 1, true) then

            if player.Character then
                return player.Character
            end
        end
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
            Force = 2000000000,
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
