// >----------------------------------------------------------------------------<
// >> Button Manager v1.8.2 readme file (English version)
// >----------------------------------------------------------------------------<

[ WARNING ]
THIS PROGRAM IS DISTRIBUTED "AS IS". NO WARRANTY OF ANY KIND IS EXPRESSED OR IMPLIED. YOU USE IT AT YOUR OWN RISK. THE AUTHOR WILL NOT BE LIABLE FOR DATA LOSS, DAMAGES, LOSS OF PROFITS OR ANY OTHER KIND OF LOSS WHILE USING OR MISUSING THIS SOFTWARE.



[ CONTENTS ]
- Description
- Work with icon wizard
- Settings window
- User borders
- About & credits
- Version history



[ DESCRIPTION ]
Button Manager can create borders in wc3 style for specified file (files). Features:
- Supported file formats: *.bmp, *.jpg, *.tga, *.psd, *.blp, *.png;
- Processing multiple files;
- Importing multiple files in archive;
- Resizing images to 64x64;
- Support of non-standard borders.



[ WORK WITH ICON WIZARD ]
Icon wizard allows you to apply borders to all images in specified folder. Select source folder and destination folder (where created icons will be copied), then choose border types you want to apply (hold Ctrl on Shift for multiple choice) and press "Create icons" button.

You can import just created icons to the map or archive. To do this, press "Import to..." button, then select source map or archive.
Hint: "Destination folder" field stores the path to place with files needed to be imported.



[ SETTINGS WINDOW ]
==== "General" tab:

- Automatically apply specified border -
When opening an image, it automatically applies specified border.

- ...and save icon to file -
In addition of previous option, it will save result icon, according to deafult image format.

- Automatically create disabled icon -
When saving icon with Button, Autocast or Passive border, program would create disabled pair icon for it.

- Automatically resize image to 64x64 -
When opening an image, it automatically resizes to 64x64 .

- User borders folder -
Folder with non-standard or user borders.

- Use manifest -
If enabled, the program window and controls will look like in a OS theme.

- Language file -
List of available languages for program.

==== "Image" tab:

- Border name (file) -
Provides list of available borders and its settings.

- Border prefix -
String that will be added in the file name for image with specified border.

- Import path -
Specifies where icon with current border should be placed in map or archive.

- Shading amplifier -
Changes the shading in special areas when applying border to image.

- Scale image to bounds -
Allows to fit image into rectangle, specified by coordinates. Using with specific borders.

- Use smooth draw when scaling -
If previous option is enabled, program will use smooth image resizing algorithm.

==== "Image Formats" tab:

- Default format -
File format, which will be used to save icons with icon wizard and "Save" command.

- Border name (file) -
Provides list of available borders and its settings.

- Mipmap count -
Ñount of generated mipmaps for image (http://en.wikipedia.org/wiki/Mipmap).

- Compressed -
Image will be saved in jpeg format. It is most applicable for images with a huge number of unique colours. Such BLP images have minimal size reduction, when packed to MPQ (or any other archive). Therefore this format is called "compressed". Can be saved with 1-100% quality. Spec recommends to use 60-80%, which is both decent quality and size.

- Merge headers -
BLP format allows to have one header for all jpeg images (mipmaps) in file, so file size can be reduced a bit. This option generates such header. Also, it has no effect, when you have "1" in "Mipmap count".

- Progressive encoding -
Output jpeg image will be in progressive format. File size can vary (both bigger or smaller in compare with standard encoding), but it is compressed a lot better in MPQ.

- Paletted -
Image will be saved in paletted format. Palette is located right after BLP header, and has limited count of entries (256). During image process, if current colour could not be found in palette, it is replaced with most approximate colour from palette.

- Compress palette -
Basically, palette size is fixed and equal to 1024 bytes. This option will reduce palette entries to number of colours in image. Example: you want to convert image with white text and black background. So when this option is checked, palette size wil be just only 8 bytes (2 colors * 4 bytes entry). This option as well as "Merge headers" reduces output file size.

- Error diffusion -
Implies Floyd-Steinberg dithering algoritm (http://en.wikipedia.org/wiki/Floyd-Steinberg_dithering). Usually high-colour image have noticeable artifacts and overall looks ugly after paletting. This option can reduce those artifacts, so image will look better. Image processed with this option have bigger size in archive, than image processed without it.

- Automatic quality definition -
Applies BLP quality settings according to current image's colour count.

- For all borders -
Applies current BLP quality settings for all borders in program.

==== "Icon wizard" tab:

- Process files with extensions -
Allows to select files of which extensions program should process.

- Don't process files with prefixes -
If there are some files with border prefixes (such as BTN), program would not process them.

- Process files in subfolders -
Allows to process all files (not only in the root of folder) in specified source folder.

- Use import path when saving icons -
Automatically creates folders for icons specified in "Import path" field of border settings.



[ USER BORDERS ]
When making non-standard border you should notice that pixels with identical color channels intensity (e.g. red is 255, green is 255, blue is 255) will be treated as shading pixels. They will darken the image in appropriate pixels. Darkening intensity depends on color channels intensity (e.g. 255 is no changes, 128 is 50% darken, 0 is solid black pixel)

Non-standard border may have alpha channel. So, when applying a border to the image, the alpha channel will be applied too.



[ CREDITS ]
Author: Shadow Daemon (also known as Spec).
Program uses SFMPQ.DLL by ShadowFlare

- ScorpioN - old program icon & test materials;
- Mastro - a lot of interesting ideas and older versions testing;
- Krol, ADOLF - few advices about improving program interface;
- NETRAT - main tester and bug finder;
- FellGuard, Hunter, MartyrOfSorrow, ScorpioT1000, Paladon, Enein - ideas and bug finding;
- unknown author - PSD decoder;
- Magos - BLP file format description;
- Markus F. X. J. Oberhumer & Laszlo Molnar - UPX;
- and others for helping me.

If you found bugs or you have some ideas, you can post about them here: http://wc3campaigns.net/showthread.php?t=102135 or here: http://www.hiveworkshop.com/forums/tools.php?id=88kxc5



[ VERSION HISTORY ]
>> v1.8.2.493 - 8th July, 2010
[ # ] Extended PNG support
[ ~ ] Fixed bug when saving icon with enabled transparency view
[ ~ ] Fixed bug with incorrent saving in JPEG format

>> v1.8.1.485 - 1st May, 2010
[ + ] Added TGA formats (RLE and color-mapped) support for opening
[ + ] Added transparency displaying
[ # ] Modified background application method
[ # ] Changed auto-quality settings
[ ~ ] Fixed recognition of non-lower case extensions in icon wizard

>> v1.8.0.468 - 20th October, 2009
[ + ] Added BLP2 format support (opening).
[ + ] Added BLP progressive saving option.
[ + ] Added BLP error diffusion option.
[ + ] Added automatic quality definition.
[ + ] Added "For all borders" button to "Image formats" tab.
[ + ] Added generation of disabled version of autocast icon.
[ + ] Added subfolders processing option.
[ + ] Added option to use import path as folder for icons.
[ # ] Extended PNG support.
[ # ] Refined autocast, upgrade borders.
[ # ] Improved image resizing method.
[ ~ ] Fixed bug with default formats list.
[ ~ ] Fixed bug with opening bitmaps that were saved in Photoshop.
[ ~ ] Fixed bug with processing files of all available formats in icon wizard.
[ ~ ] Fixed bug with opening files, that have .jpeg extension.

>> v1.7.0.410 - 03rd February, 2009
[ + ] Added compressed BLP support (saving).
[ + ] Added mipmap setting for BLP.
[ + ] Added quality settings for BLP.
[ + ] Added advanced optons for BLP (headers merge and palette compression).
[ + ] Added possibility to open images from command line.
[ + ] Added specific tags (prefixes) for each border.
[ + ] Added red and blue channel swapping feature.
[ + ] Added full file name hint to "File information" (useful if file name doesn't fit in window).
[ # ] Extended mass import with campaign files (*.w3n).
[ # ] When resizing image to 64x64, current border is applied automatically.
[ - ] Removed "Add border tags to file name" due to prefixes for each border.

>> v1.6.1.366 - 25th August, 2008
[ + ] Added some information messages and hints.
[ + ] Added PNG format processing for icon wizard (and also added to "Settings" window).
[ + ] Added hotkeys for switching between standard and user borders.
[ # ] Changed scale bounds for Scorescreen borders.
[ ~ ] Fixed mistypes in dialog windows.
[ ~ ] Fixed bug with import to MPQ (program added map header to archive).
[ ~ ] Fixed bug with import (file list and import file were not removed after finishing import process).
[ ~ ] Fixed bug with saving to other format impossibility.
[ ~ ] Fixed bug with manual image fitting.
[ ~ ] Fixed bugs with incorrect files opening.

>> v1.6.0.331 - 17th August, 2008
[ + ] Added BLP support (opening and saving) without external programs.
[ + ] Added 32 bit icon support.
[ + ] Added new border templates (Scorescreen-Hero, Scorescreen-Player).
[ + ] Added mass import feature.
[ + ] Added smoothing option when resizing image.
[ + ] Added option to skip files with icon prefixes.
[ + ] Added option to process files of specified types.
[ + ] Added preview in dialog window for PSD, TGA and BLP formats.
[ + ] Added multilanguage interface.
[ + ] Added option to enable/disable OS style in program.
[ # ] Improved Button, Autocast, Passive and Disabled border templates.
[ # ] Custom borders interface is integrated into Image tab.
[ # ] Fixed screen orientation for TGA format.
[ # ] Border shading amplifier is now individual for each border type.
[ # ] Improved image scaling.
[ # ] Improved Disabled border creating method.
[ # ] Improved border applying algorithm.
[ # ] Improved image resizing to 64õ64.
[ # ] Maximal value for shading amplifier changed 200 => 255.
[ # ] Disabled border is now standalone template.
[ ~ ] Fixed bug with saving Disabled pair icon with resizing.
[ ~ ] Fixed bug with incorrect prefix for Disabled border.
[ ~ ] Fixed bug with nullifying settings.
[ ~ ] Fixed specific bug when saving icon to TGA or BLP format.
[ ~ ] Fixed icon wizard progress.
[ ~ ] Removed BLP saving options.

>> v1.5.0.243 - 1st May, 2008
[ + ] Added saving image to BLP.
[ + ] Added user borders support.
[ + ] Added limited image scaling support.
[ + ] Added option to automatically fit image to 64õ64.
[ + ] Added border shading amplifier as changeable value.
[ + ] Added destination folder selection in icon wizard.
[ # ] Improved interface.
[ ~ ] Fixed incorrect file counting.
[ ~ ] Fixed image artifacts when applying disabled border.
[ ~ ] Fixed bug with saving just opened image.

>> v1.4.1.202 - 18th November, 2007
[ ~ ] Fixed bug with adding extensions to file name in dialog window.
[ ~ ] Fixed bug with automatical saving disabled pair icon in TGA format (even if another format was chosen).
[ ~ ] Fixed bug with opening image smaller than 64x64.
[ ~ ] Fixed bug with saving unresized image as icon.
[ ~ ] Some fixes with shading algorithm.

>> v1.4.0.187 - 20th October, 2007
[ + ] Added option to fit image into 64õ64.
[ + ] Added "automatically create disabled pair icon" option.
[ + ] Added new border templates (Infocard Basic and Infocard Upgrade).
[ + ] Added Drag-n-Drop support.
[ # ] Changed border drawing method.
[ ~ ] Fixed bug with saving settings.
[ ~ ] Fixed bug with displaying incorrect image size.
[ ~ ] Fixed bug with adding extensions to file name when saving.
[ ~ ] Fixed bug with saving 32 bit images.
[ ~ ] Fixed bug with applying the same border to different images.

>> v1.3.0.150 - 13th November, 2006
[ + ] Added progress bar and file counter to icon wizard.
[ # ] Improved icon wizard processing algorithm.

>> v1.2.0.143 - 10th October, 2006
[ + ] Added PSD file format support.
[ + ] Added some settings.
[ + ] Added settings saving.
[ # ] Changed interface.
[ # ] Default extension is changed to TGA.
[ ~ ] Fixed incorrect border applying.
[ ~ ] Fixed bug with wrong extensions.
[ ~ ] Fixed bug with saving BMP with JPG extension.

>> v1.1.0.110 - 20th September, 2006
[ + ] Added icon wizard.
[ # ] Changed border drawing method.
[ ~ ] Fixed bug with multiple applies of dark to images.

>> v1.0.0.100 - 3rd September, 2006
[ # ] First release.

______________________________________________
"/quit Shadow_Daemon" not supported by kernel.