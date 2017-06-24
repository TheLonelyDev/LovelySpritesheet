## LovelySpritesheet for ROBLOX

LovelySpritesheet is a polygonal/Image "progress bar spritesheet" like generator in Love2D (mainly to be used in ROBLOX). The usage of Love2D was because of the use of Lua and making it easy for your average ROBLOX (Lua) developer to understand/tweak this code to their needs. Another version of this might follow with more features and an easier process.



----------
### Usage
The usage is fairly simple, download the latest [Love2D](https://love2d.org/), extract the downloaded ZIP somewhere in a folder (eg 'Love2D' on your Desktop), create a shortcut on eg your Desktop to Desktop/love.exe. After this you need to download this repository, put this in a folder on eg your Desktop and then drag the folder onto the shortcut to Desktop/love.exe. Now check your %APPDATA%/LOVE/CircleSpritesheet (on Windows) for the generated sprite sheet.

### Configuration
Inside the *love.load( )* function you will be able to find some parameters you can modify to your liking.

 - *intShapes*, the amount of shapes you want to generate, please take something that has a round square root (so generally speaking anything that is a second power). This requirement might be removed or tweaked later.
 - *arrPolygon* a table consisting 2 integers *intRadius* and *intThickness* (should be self explanatory).
 - *intPolygonSegments* is the amount of "segments" used to draw the polygons, it is advised to set this higher than 3 and lower than *math.huge( )*. I often use 360 for the best resulsts.
 - *intInnerPolygonSegments* usually the same as *intPolygonSegments*, will be deprecated in future releases.
 - *boolImage* if this is TRUE then the script will check for an image named logo.png inside the folder where the main.lua script is located. This image will then be used as a base/shape instead of making polygons.
 - *intAspectModifier* this integer can be set up "upscale" the result. Keep in mind that this modifier will multiply to the default **1024x1024** so an *intAspectModifier* of 2 makes the end result 2048x2048. This can be used to get slightly better results in the editing afterwards.


### **Notes**
The images still need some sort of editing before they are able to be used in a game due to their "black background". You can do this on various ways, one of my ways is by opening the generated image in eg Paint.Net then use the Magic Wand to select the black and then remove it. However, this method is not the best when using images as a shape as it will leave a black tray around the image, this can be combated by possibly setting *rgbaBg* to another RGB colour that matches eg the colour of the loading screen that will be used. For just polygons this can be combated by using Hue/Saturation in Paint.Net with lightness on 100. (Adjustments>Adjust Hue/Saturation; or Ctrl+Shift+U).

The end result will stay "pixelated" because we are limited to 1024x1024 images on ROBLOX, there is nothing I can do about that.

----------

*The following examples are using an image with the dimension of **1024x1024**, most images that are bigger than this will be down scaled to this.*

### ROBLOX Example (Polygonal)
	
```lua    
--[[ Insert this in a localscript in an ImageLabel/ImageButton ]]--
--[[ Touch this ]]--
local intShapes					=	25 ;
local intShapesPerRow			=	5 ;
local intBox					=	64 * 1.5 ;			--This equals to arrPolygon.intRadius * 2.5
local intBoxOffset				=	64 * 3 ;			--This equals to arrPolygon.intRadius * 3
local intOffset 				=	64 * ( 6 / 4 ) ;	--This equals to arrPolygon.intRadius * ( 3 / 4 )

--[[ Do not touch this ]]--
local intCurrent				=	0 ;
local vec2New					=	Vector2.new ;
local floor						=	math.floor ;

script.Parent.ImageRectSize		=	vec2New( intBox, intBox ) ;

while ( wait( .1 ) ) do
script.Parent.ImageRectOffset=	vec2New( intOffset + ( ( intCurrent % intShapesPerRow ) * intBoxOffset ), intOffset + ( floor( intCurrent / intImagesPerRow ) * intBoxOffset ) ) ; 
intCurrent 					=	( intCurrent >= intShapes ) and 0 or intCurrent + 1 ;
end
```


### ROBLOX Example (Image)

```lua
--[[ Insert this in a localscript in an ImageLabel/ImageButton ]]--
--[[ Touch this ]]--
local intShapes					=	25 ;
local intShapesPerRow			=	5 ;
local intBox					=	64 * 1.5 ;			--This equals to arrPolygon.intRadius * 1.5
local intBoxOffset				=	64 * 3 ;			--This equals to arrPolygon.intRadius * 3
local intOffset 				=	64 * ( 6 / 4 ) ;	--This equals to arrPolygon.intRadius * ( 6 / 4 )

--[[ Do not touch this ]]--
local intCurrent				=	0 ;
local vec2New					=	Vector2.new ;
local floor						=	math.floor ;

script.Parent.ImageRectSize		=	vec2New( intBox, intBox ) ;

while ( wait( .1 ) ) do
script.Parent.ImageRectOffset=	vec2New( intOffset + ( ( intCurrent % intShapesPerRow ) * intBoxOffset ), intOffset + ( floor( intCurrent / intImagesPerRow ) * intBoxOffset ) ) ; 
intCurrent 					=	( intCurrent >= intShapes ) and 0 or intCurrent + 1 ;
end
```

### Random examples
*The gifs are not the best quality...*

![Circular with spinning](https://i.gyazo.com/d664a1721a81749abcc40df780cb4315.gif)
![ROBLOX logo "loading"](https://i.gyazo.com/9f5b124311d13df3405fc5a2f0f338f8.gif)
