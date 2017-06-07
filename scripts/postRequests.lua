local util = require("scripts/common")

wrk.method = "POST"
wrk.body   = "foo=bar&baz=quux"

local counter = 1
local bodies = {}

init = function(args)
    local parsedArgs = util.parseCommandLineArgs(args)
    util.setHeaders(args)
    print("headers are")
    print ("===============")
    util.printTable(wrk.headers)

    bodies = util.readFile(parsedArgs["file"])
    print("bodies are")
    print ("===============")
    util.printTable(bodies)
end

request = function()
    local body = bodies[counter]
    counter = counter + 1
    if counter > #bodies then
        counter = 1
    end
    local req = wrk.format(wrk.method, nil, nil, body)
    return req
end