# Stickers for some Bioconductor packages

This repository contains stickers for some Bioconductor packages. Fork
this repo and create a pull request if you would like to add a sticker
for your package too. If you would like to modify existing ones,
please open an issue and discuss changes with the sticker maintainer.

## Stickers:

<img src="ensembldb/ensembldb.png" height="100">
<img src="FamAgg/FamAgg.png" height="100">
<img src="ggtree/ggtree.png" height="100">
<img src="MSnbase/MSnbase.png" height="100">
<img src="mzR/mzR.png" height="100">
<img src="pRoloc/pRoloc.png" height="100">
<img src="pRoloc/pRolocdata.png" height="100">
<img src="pRoloc/pRolocGUI.png" height="100">
<img src="treeio/treeio.png" height="100">
<img src="xcms/xcms.png" height="100">


# Sticker development guidelines

To start with a new sticker you might want to use the
template [template.xcf](template/template.xcf) (gimp format) or you might want
to use the `make_sticker` function from
the [`sticker`](https://github.com/lgatto/sticker) package to produce the
sticker entirely in `R`.

+ Each sticker should be put into a folder named according to the package.
+ Each folder should also contain a *README.md* providing at least the name of
  the package and the designer/maintainer of the sticker (which is not
  necessarily the maintainer of the package).
+ The height of the final png should be 5cm, resolution should be at least
  300dpi.
+ While it is not mandatory, it is suggested to use the *Aller* font for the
  text (available in folder *fonts/Aller*.
+ Ideally, the position of the package name text (bottom line) should be 18mm
  from the top of the image.
+ Some suggestions for color definitions:
  http://www.flatuicolorpicker.com/category/all .
