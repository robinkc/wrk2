local util = require("scripts/common")

wrk.method = "POST"
wrk.body   = "foo=bar&baz=quux"

local counter = 1
local bodyContent = ""

init = function(args)
    local parsedArgs = util.parseCommandLineArgs(args)
    util.setHeaders(args)
    print("headers are")
    print ("===============")
    util.printTable(wrk.headers)

    bodyContent = util.readFile(parsedArgs["file"])
    print("body is")
    print ("===============")
    util.printTable(bodies)
end

request = function()
    local req = wrk.format(wrk.method, nil, nil, bodyContent)
    return req
end