-- Runs Hello.hello_world from the Hello module in ReplicatedStorage

local require = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"))
local Hello = require("MyProject:Hello")

Hello.hello_world()
