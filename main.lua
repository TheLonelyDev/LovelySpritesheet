local Graphics 				=	love.graphics ;
local pi, floor, sin, cos	=	math.pi, math.floor, math.sin, math.cos ;

local rgbaI					=	{ 255, 255, 255 } ;
local rgbaBg 				=	{ 0, 0, 0 } ;

function love.load( )
	--[[ Touch this ]]--
	intShapes				=	25 ; -- Please take a number that is a second power of something, eg 10 ^ 2 = 100
	arrPolygon 				= 
	{
		intRadius			= 	64 , -- The radius of the circle
		intThickness 		= 	12 , -- Something between lower than the radius works best (according to my testing)
	} ;

	intPolygonSegments		=	360 ; -- Amount of segments, this can be anywhere from 3 to math.huge (AFAIK)
	intInnerPolygonSegments	=	360 ; -- Usually the same as intCircleSegments

	boolImage				=	true ; -- If set to true it will use the image logo.png inside the directory instead of drawing polygons. (This is only tested with square images eg 64x64 and not 64x32). This will also override some settings from above.

	--[[ Note: yes, you can make a triangle loading bar, or hexagonal, go crazy :) ]]--

	--[[ The size of the image, keep it under 1024x1024 because else ROBLOX may downscale it; edit this at your own risk! (You can eg use intAspectModifier to get 4k x 4k and then shrink it later onwards) ]]
	intAspectModifier		=	1 ;
	love.window.setMode( 1024 * intAspectModifier, 1024 * intAspectModifier ) ;

	--[[ Do not touch this ]]--
	arrPolygon.intRadius	=	arrPolygon.intRadius * intAspectModifier ;
	arrPolygon.intThickness =	arrPolygon.intThickness * intAspectModifier ;

	intRows 				=  	math.sqrt( intShapes ) ;
	arrPolygon.x 			=	arrPolygon.intRadius * 2 ;
	arrPolygon.y 			=	arrPolygon.x ;
	
	love.filesystem.setIdentity( 'CircleSpritesheet' ) ;

	Graphics.setBackgroundColor( rgbaBg ) ;
	Graphics.setColor( rgbaI ) ;

	intShapes 			=	intShapes - 1 ;

	if ( boolImage ) then
		Image 				=	Graphics.newImage( 'logo.png' ) ;

		intRadius 			=	arrPolygon.intRadius / 1 ;

		intImageWidth		=	intRadius * 1.5 ;
		intImageHeight		=	intRadius * 1.5 --* ( Image:getHeight( ) / Image:getWidth( ) ) ;

		intImageXScale		=	intImageHeight / Image:getWidth( ) ;
		intImageYScale		=	intImageWidth / Image:getHeight( ) ;

		arrPolygon.intRadius=	math.max( intImageWidth, intImageHeight ) * 1 ;

		arrPolygon.x 		=	arrPolygon.intRadius * 2 ;
		arrPolygon.y 		=	arrPolygon.x ;

		i 					=	arrPolygon.intRadius / 2 ;
		i2, i3, i4, i5		=	i * 2, i * 3, i * 4, i * 5 ;
		q 					= 	arrPolygon.intRadius * 1.5 ;
	else
		i 					=	arrPolygon.intRadius / 2 ;
		i2, i3, i4, i5		=	i * 2, i * 3, i * 4, i * 5 ;
		q 					= 	arrPolygon.intRadius * 1.5 ;		
	end
end

--[[ Using this for smoother drawing ]]--
function love.conf( t )
    t.window.fsaa 			= 	8 ;
end

--[[ Do not touch ]]--
function love.draw( )
	if ( boolImage ) then
		for i = 1, intShapes do
			DrawImage( ( ( intImageWidth * 2 ) * ( floor( i % intRows ) ) ) + intImageWidth , ( ( intImageHeight * 2 ) * floor( i / intRows ) ) + intImageHeight, i ) ;	
		end

		local gpScreeenshot 	= 	Graphics.newScreenshot( ) ;

		gpScreeenshot:encode( 'png', 'Image export of logo (' .. intAspectModifier .. 'x aspect).png' ) ;	
	else
		for i = 1, intShapes do
			DrawPolygon( ( ( arrPolygon.x * 1.5 ) * ( floor( i % intRows ) ) ) + arrPolygon.x , ( ( arrPolygon.y * 1.5 ) * floor( i / intRows ) ) + arrPolygon.y, i ) ;	
		end

		local gpScreeenshot 	= 	Graphics.newScreenshot( ) ;

		gpScreeenshot:encode( 'png', 'Image export of ' .. intShapes + 1 .. ' polygons with radius ' .. arrPolygon.intRadius .. ' and a thickness off ' .. arrPolygon.intThickness .. ' (' .. intAspectModifier .. 'x aspect).png' ) ;
	end

	love.event.quit( 0 ) ;
end


local r1, r2, r3 			=	math.rad( 90 ), math.rad( 180 ), math.rad( 270 ) ;
local pih 					=	pi / 2 ;
local pi2					=	2 * pi ;

function DrawPolygon( x, y, intVal )
	local intMaxAngle 		= 	( pi2 * ( intVal / intShapes ) ) ;

	--[[ Old drawing method ahead, this is not very recommended.

	for i = 0, intMaxAngle, .01 do
		local x1 			= 	arrPolygon.intRadius * cos( i - pi/2 ) + x ;
		local y1 			= 	arrPolygon.intRadius * sin( i - pi/2 ) + y ;

		Graphics.circle( 'line', x1, y1, arrPolygon.intThickness ) ;
		Graphics.circle( 'fill', x1, y1, arrPolygon.intThickness ) ;

	end
	]]--

	--[[ Set the circle colour to white ]]--
	Graphics.setColor( rgbaI ) ;

	Graphics.circle( 'line', x, y, arrPolygon.intRadius, intPolygonSegments ) ;
	Graphics.circle( 'fill', x, y, arrPolygon.intRadius, intPolygonSegments ) ;

	--[[ Set the inner circle colour to black so it looks like that we only have a ring ]]--
	Graphics.setColor( rgbaBg ) ;

	Graphics.circle( 'line', x, y, arrPolygon.intRadius - arrPolygon.intThickness, intInnerPolygonSegments ) ;
	Graphics.circle( 'fill', x, y, arrPolygon.intRadius - arrPolygon.intThickness, intInnerPolygonSegments ) ;	

	Draw( x, y, intMaxAngle ) ;
end

function  DrawImage( x, y, intVal )
	local intMaxAngle 		= 	( pi2 * ( intVal / intShapes ) ) ;

	Graphics.setColor( 255, 255, 255 ) ;
	Graphics.draw( Image, x, y, nil, intImageXScale, intImageYScale ) ;

	Draw( x + i, y + i, intMaxAngle ) ;
end

function Draw( x, y, intMaxAngle )
	Graphics.setColor( rgbaBg ) ;

	local x1, y1 ;

	local x2 				= 	arrPolygon.intRadius * cos( 0 - pih ) + x ;
	local y2 				= 	arrPolygon.intRadius * sin( 0 - pih ) + y ;

	--[[ Generate the upper left triangle ]]--
	if ( intMaxAngle > r3 ) then
		x1 					= 	q * cos( intMaxAngle - pih ) + x ;
		y1 					= 	q * sin( intMaxAngle - pih ) + y ;

		Graphics.polygon( 'line', x, y, x1, y1, x2, y2 - i ) ;			
		Graphics.polygon( 'fill', x, y, x1, y1, x2, y2 - i ) ;

		return ;
	end
	
	x1 						= 	q * cos( r3 - pih ) + x ;
	y1 						= 	q * sin( r3 - pih ) + y ;
	
	Graphics.polygon( 'line', x, y, x1, y1, x2, y2 - i  ) ;
	Graphics.polygon( 'fill', x, y, x1, y1, x2, y2 - i  ) ;


	--[[ Generate the lower left triangle ]]--
	if ( intMaxAngle > r2 ) then
		x1 					= 	q * cos( intMaxAngle - pih ) + x ;
		y1 					= 	q * sin( intMaxAngle - pih ) + y ;	
	
		Graphics.polygon( 'line', x, y, x1 , y1, x2 - i3, y2 + i2 ) ;
		Graphics.polygon( 'fill', x, y, x1 , y1, x2 - i3, y2 + i2 ) ;

		return ;
	end

	x1 						= 	q * cos( r2 - pih ) + x ;
	y1 						= 	q * sin( r2 - pih ) + y ;	

	Graphics.polygon( 'line', x, y, x1 , y1, x2 - i3, y2 + i2 ) ;
	Graphics.polygon( 'fill', x, y, x1 , y1, x2 - i3, y2 + i2 ) ;


	--[[ Generate the lower right triangle ]]--
	if ( intMaxAngle > r1 ) then
		x1 					= 	q * cos( intMaxAngle - pih ) + x ;
		y1 					= 	q * sin( intMaxAngle - pih ) + y ;	

		Graphics.polygon( 'line', x, y, x1, y1, x2, y2 + i5 ) ;
		Graphics.polygon( 'fill', x, y, x1, y1, x2, y2 + i5 ) ;

		return ;
	end

	x1 						= 	q * cos( r1 - pih ) + x ;
	y1 						= 	q * sin( r1 - pih ) + y ;	
	
	Graphics.polygon( 'line', x, y, x1, y1, x2, y2 + i5 ) ;
	Graphics.polygon( 'fill', x, y, x1, y1, x2, y2 + i5 ) ;


	--[[ Generate the upper right triangle ]]--
	x1 						= 	q * cos( intMaxAngle - pih ) + x ;
	y1 						= 	q * sin( intMaxAngle - pih ) + y ;	
	
	Graphics.polygon( 'line', x, y, x1, y1, x2 + i3, y2 + i2 ) ;
	Graphics.polygon( 'fill', x, y, x1, y1, x2 + i3, y2 + i2 ) ;
end
