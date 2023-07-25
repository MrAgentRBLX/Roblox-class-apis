--[[
    @PlayerModule
]]

local module = {}
module.__index = module

-- // Class Init
function module.Get()
    local self = setmetatable({}, module)

    self.Player = self.Service("Players").LocalPlayer
    self.Character = (self.Player.Character or self.Player.CharacterAdded:Wait())

    task.spawn(function()
        while true do
            if not (self.Character) then
                self.Player = self.Service("Players").LocalPlayer
                self.Character = (self.Player.Character or self.Player.CharacterAdded:Wait())
            end
            task.wait(math.random(0.05, 1))
        end
    end)

    return self
end


-- // Data Value Functions
function module.GetId(self)
    return self:GetPlayer().UserId
end

function module.GetAge(self)
    return self:GetPlayer().AccountAge
end

function module.FakeAge(self, Age)
    self:GetPlayer():SetAccountAge(Age)
end

-- // Class Functions
function module.RespawnCharacter(self)
    self:GetPlayer():LoadCharacter()
end

function module.GetPlayer(self)
    return self.Player
end

function module.GetCharacter(self)
    return self.Character
end

function module.GetHumanoid(self)
    return self:GetCharacter():WaitForChild("Humanoid")
end


-- // Class Fetch
function module.Service(Class)
    return game:GetService(Class)
end



-- EXAMPLE --
--[[
-- // Services
local PlayerService = module.Get()


-- // Player
local Player = PlayerService:GetPlayer()
local UserId = PlayerService:GetId()
local AccountAge = PlayerService:GetAge()

local Character = PlayerService:GetCharacter()
local Humanoid = PlayerService:GetHumanoid()


-- // Fake Age
if AccountAge < 100 then
    print("Account Age:", AccountAge)
    PlayerService:FakeAge(100)
    AccountAge = PlayerService:GetAge()

    print("New Account Age:", AccountAge)
end
]]

return module
