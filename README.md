## LovelySpritesheet for ROBLOX

LovelySpritesheet is a polygonal/Image "progress bar spritesheet" like generator in Love2D (mainly to be used in ROBLOX). The usage of Love2D was because of the use of Lua and making it easy for your average ROBLOX (Lua) developer to understand/tweak this code to their needs. Another version of this might follow with more features and an easier process.



----------
### Usage
The usage is fairly simple, download the latest [Love2D](https://love2d.org/), extract the downloaded ZIP somewhere in a folder (eg 'Love2D' on your Desktop), create a shortcut on eg your Desktop to Desktop/love.exe. After this you need to download this repository, put this in a folder on eg your Desktop and then drag the folder onto the shortcut to Desktop/love.exe. Now check  `%APPDATA%/LOVE/CircleSpritesheet` in File Explorer (on Windows) for the generated sprite sheet image, lua sprite sheet info file, and json sprite sheet info file.

### Configuration
Inside the *love.load( )* function you will be able to find some parameters you can modify to your liking.

 - *intShapes*, the amount of shapes you want to generate, please take something that has a round square root (so generally speaking anything that is a second power). This requirement might be removed or tweaked later.
 - *intPadding*, the amount of space between each image/polygon. `intPadding + intDiameter = tileSize`
 - *arrPolygon* a table consisting 2 integers *intDiameter* and *intThickness* (should be self explanatory).
 - *intPolygonSegments* is the amount of "segments" used to draw the polygons, it is advised to set this higher than 3 and lower than *math.huge( )*. I often use 360 for the best resulsts.
 - *intInnerPolygonSegments* usually the same as *intPolygonSegments*, will be deprecated in future releases.
 - *boolImage* if this is TRUE then the script will check for an image named logo.png inside the folder where the main.lua script is located. This image will then be used as a base/shape instead of making polygons.
 - *intAspectModifier* this integer can be set up "upscale" the result. Keep in mind that this modifier will multiply to the default **1024x1024** so an *intAspectModifier* of 2 makes the end result 2048x2048. This can be used to get slightly better results if editing afterwards. Note that the generated config files will follow this value and are not automatically scaled down to 1024x1024. You may need to tweak their values after uploading to Roblox.


### **Notes**
This supports transparent backgrounds and transparent images. The generated images will have transparent backgrounds, and image transparency will show.

This uses anti-aliasing to keep edges smooth, but the end result will stay "pixelated" because we are limited to 1024x1024 images on ROBLOX.

----------

*The following example is using an image with the dimension of **1024x1024**, most images that are bigger than this will be down scaled to this.*

### ROBLOX Example
*Works with both image mode and polygon mode*

```lua
--[[ Insert this in a LocalScript in an ImageLabel/ImageButton. Insert ConfigReader into the LocalScript as a ModuleScript. ]]--
--[[ Touch this ]]--
local ConfigReader				=	require(script.ConfigReader) ;

local config					=	{diameter=120,padding=4,count=64,size=1024} ; -- The generated lua export file contents

--[[ Do not touch this ]]--
local intCurrent				=	0 ;
local vec2New					=	Vector2.new ;

script.Parent.ImageRectSize		=	vec2New( ConfigReader.GetSize( config ) ) ;

while ( wait( .1 ) ) do
script.Parent.ImageRectOffset	=	vec2New( ConfigReader.GetOffset( config, intCurrent ) ) ;
intCurrent 						=	intCurrent + 1 ;
end
```

### Random examples
*The gifs are not the best quality...*

![Circular with spinning](https://i.gyazo.com/d664a1721a81749abcc40df780cb4315.gif)
![ROBLOX logo "loading"](https://i.gyazo.com/9f5b124311d13df3405fc5a2f0f338f8.gif)
