-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

local json = require("json")
local loadsave = require("loadsave")

local randLocX = math.random(display.screenOriginX, display.contentWidth-50)
local randLocY = math.random(display.contentHeight*.2, display.contentHeight-50)
local circleTable = {}
local disappearBox
local addBox
local inc = 0
local r=0
local g=0
local b=1
local settings = loadsave.loadTable("gameSettings.json")
if score == nil then
	score = 0 
end

local gameSettings = {
	score = 0,
	level = 1,
	health = 10
}

local screamTable = {}
local randSoundNo

local scoreText = display.newText("", display.contentCenterX, display.contentHeight*.05, nil,18)

scoreText.anchorY=1
scoreText:setFillColor(0,1,0)
local scoreHud = display.newRect(display.contentCenterX, display.contentHeight*.1, display.contentWidth, display.contentHeight*.2)
scoreHud.anchorY=1
scoreHud:setFillColor(.5,0,0,0.27)

-- load screams 

for i = 1,8 do
	screamTable[i] = audio.loadSound("scream"..i..".wav")
end

-- add button for ending the game


function addBox()
	randLocX1 = math.random(display.screenOriginX, display.contentWidth)
	randLocY1 = math.random(display.contentHeight*.2, display.contentHeight-50)
	randLocX2 = math.random(display.screenOriginX, display.contentWidth)
	randLocY2 = math.random(display.contentHeight*.2, display.contentHeight-50)

	local randSize = math.random(5,50)
	r = math.random()
	g = math.random()
	b = math.random()
 	circleTable[score] = display.newCircle(randLocX1, randLocY1, randSize)
 	circleTable[score]:setFillColor(r,g,b)
 	circleTable[score].alpha = 0
 	circleTable[score].name = "circle"..inc
 	print (circleTable[score].name)
 	transition.to(circleTable[score], {time=1000, alpha =1, x = randLocX2, y=randLocY2})
 	circleTable[score]:addEventListener("touch", disappearBox)
end

function disappearBox(event)
	scoreText:toFront()

	if event.phase == "began" then
		randSoundNo= math.random(1,8)
		audio.play(screamTable[randSoundNo])
	 	event.target:removeSelf()
		score = score+1
		print (score)
		if score == 1 then
			scoreText.text = "You have teased "..score.." person"
		else  
			scoreText.text = "You have teased "..score.." people" 

		end
		
		addBox()

	end

	return true
end

for i = 1,8 do
	scoreText:toFront()
	local randLocX = math.random(display.screenOriginX, display.contentWidth)
	local randLocY = math.random(display.contentHeight*.2, display.contentHeight)
	local randSize = math.random(5,100)
	r = math.random()
	g = math.random()
	b = math.random()
	circleTable[i] = display.newCircle(randLocX, randLocY, randSize)
	circleTable[i]:setFillColor(r,g,b)
	circleTable[i]:addEventListener("touch", disappearBox)

end

saveScoreBtn = display.newText("Save Score", display.contentCenterX, display.contentHeight, nil, 30)
clearScoreBtn = display.newText("Clear Score", display.contentCenterX, display.contentHeight*.9, nil, 30)

function saveScore()
	scoreText.text = "Saved Score"
	--loadsave.saveTable(score, "score.json")
		loadsave.saveTable(gameSettings, "settings.json")

end

function clearScore()
	scoreText.text = "Cleared Score"
	score = 0 
	loadsave.saveTable(score, "score.json")
end
saveScoreBtn:addEventListener("tap", saveScore)
clearScoreBtn:addEventListener("tap", clearScore)