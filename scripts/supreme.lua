local util = require("scripts/common")

local method = "GET"
local bodies = {}
local bodiesCounter = 1
local headers = {}
local randomHeaders = {}
local randomHeadersCounter = 1

init = function(args)
    local parsedArgs = util.parseCommandLineArgs(args)
    print("parsedArgs are")
    print ("===============")
    util.printTable(parsedArgs)

    if(parsedArgs["method"] ~= nil) then
    	method = parsedArgs["method"]
    end

    local _h = util.readFileLines(parsedArgs["headers"])
	for k, v in pairs(_h) do
        local headerKV = util.splitString(v, "=")
        if(#headerKV == 2) then
            headers[headerKV[1]] = headerKV[2]
        end
    end
    print("headers are")
    print ("===============")
    util.printTable(headers)

    print("checking random-headers are")

    if(parsedArgs["random-headers"] ~= nil) then
	    print("inside random-headers")
    	randomHeaders = util.readFileLines(parsedArgs["random-headers"])
    end
    print("random-headers are")
    print ("===============")
    util.printTable(randomHeaders)

    if(parsedArgs["bodies"] ~= nil) then
	    bodies = util.readFileLines(parsedArgs["bodies"])
    end 
    print("bodies are")
    print ("===============")
    util.printTable(bodies)
end

request = function()
    local body = bodies[bodiesCounter]
    bodiesCounter = bodiesCounter + 1
    if bodiesCounter > #bodies then
        counter = 1
    end

    local localHeaders = {}
    for k, v in pairs(headers) do
    	localHeaders[k] = v
	end

	if(#randomHeaders > 0) then
		local line = randomHeaders[randomHeadersCounter]
		local kv = util.splitString(line, "=")
		localHeaders[kv[1]] = kv[2]

		randomHeadersCounter = randomHeadersCounter + 1
		if randomHeadersCounter > #randomHeaders then
			randomHeadersCounter = 1
		end
	end
	
    local req = wrk.format(method, wrk.path, localHeaders, body)
    return req
end