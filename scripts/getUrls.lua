local util = require("scripts/common")
counter = 1
args = {}
init = function (args)
	util.setHeaders(args)

    args = util.parseCommandLineArgs(args)

	print("Arguments are ")
	util.printTable(args)

	print ("file is ")
	print(args["file"])
	paths = util.readFileLines(args["file"])

	print("paths are")
	util.printTable(paths)
end

request = function()
	local path = paths[counter]
	counter = counter + 1
	if counter > #paths then
		counter = 1
	end
	return wrk.format(nil, path)
end
