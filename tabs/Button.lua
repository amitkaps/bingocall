Button = class()

function Button:init(displayName, pos, size, col)
    -- you can accept and set parameters here
    self.displayName = displayName
    
    self.pos = pos -- needs to be a vec2(0,0)
    self.size = size
    self.action = nil
    self.color = col
end

function Button:draw()
    -- Codea does not automatically call this method
    pushStyle()
    fill(self.color)
    
    font("ArialRoundedMTBold")
    fontSize(18)
    
    ellipse(self.pos.x, self.pos.y, self.size)
            
    textMode(CENTER)
    fill(250, 250, 250, 255)
    text(self.displayName,self.pos.x,self.pos.y)
        
    popStyle()
end

function Button:hit(p)
    if math.sqrt((p.x - self.pos.x)^2 + (p.y - self.pos.y)^2) < self.size then   
        return true
    end
    return false
end

function Button:touched(touch)
    -- Codea does not automatically call this method
    if touch.state == ENDED and
       self:hit(vec2(touch.x,touch.y)) then
        if self.action then
            self.action()
        end
    end
end
