local floor, sqrt = math.floor, math.sqrt ;

--[[ Returns ImageRectOffset (top left of sprite) starting from 0 as x, y ]]--
function GetOffset( config, number )
	local intRows = sqrt( config.count ) ;
	number = floor(number) % config.count ;
	return ( ( config.diameter + config.padding * 2 ) * ( floor( number % intRows ) ) ) + config.padding, ( ( config.diameter + config.padding * 2 ) * floor( number / intRows ) ) + config.padding  ;
end

--[[ Returns ImageRectSize (size of sprite) as x, y ]]--
function GetSize( config )
	return config.diameter, config.diameter
end

return {
	GetOffset = GetOffset,
	GetSize = GetSize
} ;
