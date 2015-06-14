-- Bingo Caller

    supportedOrientations(PORTRAIT_ANY)
    -- displayMode(FULLSCREEN_NO_BUTTONS)
    
-- Use this function to perform your initial setup
function setup()
    
    -- Setup an array to store all the numbers
    n = 90
    newNum = 0
    numbers = {}
    for i = 1,n do
        numbers[i] = 0 
    end
    
    -- Setup the bingo caller slang
    calls = {"Kelly's Eye, Number",
            "One Little Duck, Number",
            "Cup of Tea, Number",
            "Knock at the Door, Number",
            "Man Alive, Number",
            "Half a Dozen, Number",
            "Lucky Seven, Number",
            "Garden gate, Number",
            "Doctor's Orders, Number",
            "David's Den, One and Zero",
            "Pair of Legs, One and One",
            "One Dozen, One and Two",
            "Unlucky for Some, One and Three",
            "The Lawnmower, One and Four",
            "Young and Keen, One and Five",
            "Never been kissed, One and Six",
            "Dancing Queen, One and Seven",
            "Coming of Age, One and Eight",
            "Goodbye Teens, One and Nine",
            "One Score, Two and Zero",
            "Key of the Door, Two and One",
            "Two Little Ducks, Two and Two",
            "The Lord is My Shepherd, Two and Three",
            "Knock at the Door, Two and Four",
            "Duck and Dive, Two and Five",
            "Half a Crown, Two and Six",
            "Duck and a Crutch. Two and Seven",
            "Overweight, Two and Eight",
            "Rise and Shine, Two and Nine",
            "Dirty Gertie, Three and Zero",
            "Get Up and Run, Three and One",
            "Buckle My Shoe, Three and Two",
            "All the Threes, Three and Three",
            "Ask for More, Three and Four",
            "Jump and Jive, Three and Five",
            "Three Dozen, Three and Six",
            "More than Eleven, Three and Seven",
            "Christmas Cake, Three and Eight",
            "Steps, Three and Nine",
            "Naughty Fourty, Four and Zero",
            "Time for Fun, Four and One",
            "Winnie the Pooh, Four and Two",
            "Down on your knees, Four and Three",
            "Droopy Drawers, Four and Four",
            "Halfway There, Four and Five",
            "Up to Tricks, Four and Six",
            "Four and Seven",
            "Four Dozen, Four and Eight",
            "PC, Four and Nine",
            "Half a Century, Five and Zero",
            "Tweak of the Thumb, Five and One",
            "Chicken Vindaloo, Five and Two",
            "Stuck in a Tree, Five and Three",
            "Clean the Floor, Five and Four",
            "Musty Hive, Five and Five",
            "Was She Worth It, Five and Six",
            "Heinz Beanz, Five and Seven",
            "Make them wait, Five and Eight",
            "The Brighton Line, Five and Nine",
            "Grandma's Getting Frisky, Six and Zero",
            "Baker's Bun, Six and One",
            "Turn on the Screw, Six and Two",
            "Tickle Me, Six and Three",
            "Red Road, Six and Four",
            "Stop Work, Six and Five",
            "Clickety click, Six and Six",
            "Made in Heaven, Six and Seven",
            "Saving Grace, Six and Eight",
            "Either Way Up. Six and Nine",
            "Three Score and Ten, Seven and Zero",
            "Bang on the Drum, Seven and One",
            "Danny La Rue, Seven and Two",
            "Queen Bee, Seven and Three",
            "Candy Store, Seven and Four",
            "Strive and Strive, Seven and Five",
            "Trombones, Seven and Six",
            "Two little crutches, Seven and Seven",
            "Heaven's Gate, Seven and Eight",
            "One More Time, Seven and Nine",
            "Gandhi's Breakfast, Eight and Zero",
            "Stop and Run, Eight and One",
            "Straight on Through, Eight and Two",
            "Time for Tea,	Eight and Three",
            "Seven Dozen, Eight and Four",
            "Staying Alive, Eight and Five",
            "Between the sticks, Eight and Six",
            "Torquay in Devon, Eight and Seven",
            "Two Fat Ladies, Eight and Eight",
            "Almost there, Eight and Nine",
            "Top of the Shop, Nine and Zero"
        }
        
        
    -- Setup the colors for marked and ummarked numbers
    unmarkedColor = color(255,255,255,125)
    markedColor = color(255, 0, 7, 142)
    
    -- Setup the colors for marked and ummarked numbers
    resetColor = color(255,0,0,125)
    nextColor = color(0,255,0,125)

    
end

-- This function gets called whenever a touch
--  begins or changes state
function touched(touch)
    resetButton:touched(touch)
    nextButton:touched(touch)
end


-- This function gets called once every frame
function draw()
 
    if deviceIsIpad() then
        f = 20
    else
        f = 15
    end
 
    w = WIDTH
    h = HEIGHT
    p = w / 12
    d = (w - 2*p) / 11
    r = d / 2 
    
    print(f)

     -- Set the background color to blueish
    background(100,120,180)

    -- Set a wide outline
    strokeWidth(1)

    -- Set the outline color to white
    stroke(255)
    
    -- Set the fontSize
    fontSize(f)
    
    for i,v in ipairs(numbers) do
        t = math.floor((i-1)/10)
        u = i - t * 10
        x = u * d + p 
        y = t * d + p
        
        -- Set the fill color and draw an ellipse
        if v == 0 then fill(unmarkedColor) else fill(markedColor) end
        ellipse( x, y, d, d)
        
        -- Set the fill color to white and write the numbers
        fill(255)
        text( i, x, y)
    end
    
    
    resetX = p + d * 1.5
    resetY = 12*d              
    resetR = d*2              
    nextX  = p + d * 9         
    nextY  = 12*d              
    nextR  = d*3               
    
    resetButton = Button("Reset"..f, vec2(resetX,resetY), resetR, resetColor)
    nextButton = Button("Next Number", vec2(nextX,nextY), nextR, nextColor)
    
    resetButton.action = function () resetNumber() end
    nextButton.action = function () nextNumber() end
   
     
    -- Create a button for getting next number     
    nextButton:draw()
    
    -- Create a reset button
    resetButton:draw()

    
    -- Show the last number on the slide
    numX = p + d*5
    numY = 12*d
    lastX = numX - d * 1.5
    lastY = numY - d * 1.5
    lastR = d * 3
    
    stroke(255)
    fill(unmarkedColor)
    rect(lastX, lastY, lastR, lastR)
    fill(255)
    fontSize(f*6)
    text(newNum, numX, numY)

end

function nextNumber()
    
    -- Check is all numbers are done
    sum = 0
    for i,v in ipairs(numbers) do sum = sum + v end
    if sum < n then    
        -- Create an action for getting next number   
        newNum = 0
        while newNum == 0 do
            x = math.random(n)
            if numbers[x] == 0 then
                newNum = x
                numbers[x] = 1
                print(newNum)
                speech.say(calls[newNum])
                speech.say(newNum)
            end
        end
    end   
end 
        
function resetNumber ()
    -- Do the reset action
    for i,v in ipairs(numbers) do
                numbers[i] = 0
    end
    newNum = 0
end


function deviceIsIpad()

    if CurrentOrientation == LANDSCAPE_LEFT 
      or CurrentOrientation == LANDSCAPE_RIGHT then
        if WIDTH == 1024 then
            return true
        else
            return false
        end
    else
        if WIDTH == 768 then
            return true
        else
            return false
        end
    end
    
end


