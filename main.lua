-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)
local randLocX = math.random(display.screenOriginX, display.contentWidth-50)
local randLocY = math.random(display.contentHeight*.2, display.contentHeight-50)
local moleTable = {}
local disappearBox
local addBox
local inc = 0
local r=0
local g=0
local b=0
local screamTable = {}
local randSoundNo
local score = display.newText("You haven't tormented anybody...yet", display.contentCenterX, display.contentHeight*.05, nil,18)
score.anchorY=1
score:setFillColor(0,1,0)
local scoreHud = display.newRect(display.contentCenterX, display.contentHeight*.1, display.contentWidth, display.contentHeight*.2)
scoreHud.anchorY=1
scoreHud:setFillColor(.5,0,0,0.27)

for i = 1,8 do
	screamTable[i] = audio.loadSound("scream"..i..".wav")
end

--[[local physics = require( "physics" )
physics.start()

local testParticleSystem = physics.newParticleSystem(
   {
      filename = "particle.png",
      radius = 3,
      imageRadius = 4
   }
)

local testParticleSystem2 = physics.newParticleSystem(
   {
      filename = "particle.png",
      radius = 3,
      imageRadius = 4
   }
)
local function onTimer( event )

testParticleSystem:createGroup(
   {
      flags = { "water", "colorMixing" },
      x = 0,
      y = 0,
      color = { 0, 0.3, 1, 1 },
      halfWidth = 12,
      halfHeight = 12
   }
   )
end

local function onTimer2( event )

testParticleSystem2:createGroup(
   {
      flags = { "water", "colorMixing" },
      x = display.contentWidth,
      y = 0,
      color = { 1, 0, 0, 1 },
      halfWidth = 12,
      halfHeight = 12
   }
   )

end
timer.performWithDelay( 20, onTimer, 0 )
timer.performWithDelay( 20, onTimer2, 0 )
--]]
function addBox()
	randLocX1 = math.random(display.screenOriginX, display.contentWidth)
	randLocY1 = math.random(display.contentHeight*.2, display.contentHeight-50)
	randLocX2 = math.random(display.screenOriginX, display.contentWidth)
	randLocY2 = math.random(display.contentHeight*.2, display.contentHeight-50)
local randSize = math.random(5,50)
		r = math.random()
		g = math.random()
		b = math.random()
 		moleTable[inc] = display.newCircle(randLocX1, randLocY1, randSize)
 		moleTable[inc]:setFillColor(r,g,b)
 		moleTable[inc].alpha = 0
 		transition.to(moleTable[inc], {time=1000, alpha =1, x = randLocX2, y=randLocY2})
 		moleTable[inc]:addEventListener("touch", disappearBox)
end

function disappearBox(event)
	score:toFront()
	if event.phase == "began" then
		randSoundNo= math.random(1,8)
		audio.play(screamTable[randSoundNo])
	 	event.target:removeSelf()
		inc = inc+1
		if inc == 1 then
			score.text = "You have tormented "..inc.." person"
		else  
			score.text = "You have tormented "..inc.." people" 
		end
		addBox()
	end
	return true
end

for i = 1,8 do
score:toFront()
local randLocX = math.random(display.screenOriginX, display.contentWidth)
local randLocY = math.random(display.contentHeight*.2, display.contentHeight)
local randSize = math.random(5,100)
		r = math.random()
		g = math.random()
		b = math.random()
	 	moleTable[i] = display.newCircle(randLocX, randLocY, randSize)
	 	moleTable[i]:setFillColor(r,g,b)
	 	moleTable[i]:addEventListener("touch", disappearBox)
--	 	physics.add(moleTable[i], {density=1, friction=.3})

end

--button = display.newText("Click me", display.contentCenterX, display.contentHeight*.9, nil,24)
