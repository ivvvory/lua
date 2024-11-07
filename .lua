-- Define the window size and the calculator buttons
local buttons = {
    {"7", "8", "9", "/"},
    {"4", "5", "6", "*"},
    {"1", "2", "3", "-"},
    {"0", ".", "=", "+"}
}

local input = ""   -- Holds the current input and expression
local result = nil -- Stores the result after pressing "="

function love.load()
    love.window.setMode(300, 400)         -- Set window size
    love.window.setTitle("Calculator")    -- Set window title
end

function love.draw()
    -- Draw the input/output box
    love.graphics.rectangle("line", 10, 10, 280, 50)
    love.graphics.printf(input, 15, 20, 270, "right")
    
    if result then
        love.graphics.printf("= " .. result, 15, 60, 270, "right")
    end

    -- Draw calculator buttons
    local buttonWidth = 70
    local buttonHeight = 70
    for i, row in ipairs(buttons) do
        for j, label in ipairs(row) do
            local x = 10 + (j - 1) * buttonWidth
            local y = 90 + (i - 1) * buttonHeight
            love.graphics.rectangle("line", x, y, buttonWidth - 5, buttonHeight - 5)
            love.graphics.printf(label, x, y + 20, buttonWidth - 5, "center")
        end
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then -- Left mouse click
        local buttonWidth = 70
        local buttonHeight = 70

        -- Check which button was clicked
        for i, row in ipairs(buttons) do
            for j, label in ipairs(row) do
                local bx = 10 + (j - 1) * buttonWidth
                local by = 90 + (i - 1) * buttonHeight
                if x > bx and x < bx + buttonWidth - 5 and y > by and y < by + buttonHeight - 5 then
                    handleInput(label)
                end
            end
        end
    end
end

-- Function to handle button input
function handleInput(label)
    if label == "=" then
        -- Evaluate the expression
        local func, err = load("return " .. input)
        if func and not err then
            result = func()
        else
            result = "Error"
        end
    elseif label == "C" then
        -- Clear the input and result
        input = ""
        result = nil
    else
        -- Append to input if not '=' or 'C'
        input = input .. label
    end
end

