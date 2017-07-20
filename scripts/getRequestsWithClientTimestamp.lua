--
-- Created by IntelliJ IDEA.
-- User: robinchugh
-- Date: 12/07/17
-- Time: 10:37 AM
-- To change this template use File | Settings | File Templates.
--
require("os")

request = function()
    local path = wrk.path .. "&time=" .. os.date("%m/%d/%Y:%H:%M:%S")
    print(path)
    return wrk.format(nil, path)
end