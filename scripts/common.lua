local M = {}

local function printTable (t) 
	for k,v in pairs(t) do 
		print(k, v)
	end
end

local function readFile(f) 
	local content = {}
	local f = io.open(f, "r")
	if f~=nil then
		for line in f:lines() do
			table.insert(content, line)
		end
		io.close(f)
	end
	return content
end

local function splitString (str, sep) 
   local sep, fields = sep or ":", {}
   local pattern = string.format("([^%s]+)", sep)
   str:gsub(pattern, function(c) fields[#fields+1] = c end)
   return fields
end

local function parseCommandLineArgs(args) 
	local arguments = {}
	for k, v in pairs (args) do
		local res = splitString(v, "=")
		if(#res == 2) then
			arguments[res[1]] = res[2]
		end
	end
	return arguments
end

local function setHeaders(args)
	args = parseCommandLineArgs(args)

	if(args["headers"] ~= nil) then
		local headers = readFile(args["headers"])
		for k, v in pairs(headers) do
			local headerKV = splitString(v, "=")
			if(#headerKV == 2) then
				wrk.headers[headerKV[1]] = headerKV[2]
			end
		end
	end
end

M.printTable = printTable
M.readFile = readFile
M.splitString = splitString
M.parseCommandLineArgs = parseCommandLineArgs
M.setHeaders = setHeaders
return M
