local M = {}

M.hex2rgb = function(hex)
	-- remove leading #
	hex = hex:gsub("#", "")
	local r = tonumber(hex:sub(1, 2), 16)
	local g = tonumber(hex:sub(3, 4), 16)
	local b = tonumber(hex:sub(5, 6), 16)
	return r, g, b
end

M.blend = function(color1, color2, percent)
	local r1, g1, b1 = M.hex2rgb(color1)
	local r2, g2, b2 = M.hex2rgb(color2)
	local r = math.floor(r1 + (r2 - r1) * percent)
	local g = math.floor(g1 + (g2 - g1) * percent)
	local b = math.floor(b1 + (b2 - b1) * percent)
	return string.format("#%02x%02x%02x", r, g, b)
end

return M
