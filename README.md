# MagickWand

This provides a Perl 6 object-oriented [NativeCall](
http://doc.perl6.org/language/nativecall)-based API for ImageMagick's
[MagickWand C API](http://www.imagemagick.org/script/magick-wand.php).

## Build Status

| Operating System  |   Build Status  | CI Provider |
| ----------------- | --------------- | ----------- |
| Linux / Mac OS X  | [![Build Status](https://travis-ci.org/azawawi/perl6-magickwand.svg?branch=master)](https://travis-ci.org/azawawi/perl6-magickwand)  | Travis CI |
| Windows 7 64-bit  | [![Build status](https://ci.appveyor.com/api/projects/status/github/azawawi/perl6-magickwand?svg=true)](https://ci.appveyor.com/project/azawawi/perl6-magickwand/branch/master)  | AppVeyor |

## Example

```Perl6
use v6;
use MagickWand;

# A new magic wand
my $wand = MagickWand.new;

# Read an image
$wand.read("examples/images/aero1.jpg");

# Lighten dark areas
$wand.auto-gamma;

# And then write a new image
$wand.write("output.png");

# And cleanup on exit
LEAVE {
  $wand.cleanup if $wand.defined;
}
```

For more examples, please see the [examples](examples) folder.
For examples of available image effects, please click
[here](http://www.imagemagick.org/script/examples.php).

## Prerequisites

Please follow the instructions below based on your platform:

### Linux (Debian)

- To install ImageMagick libraries, please run:
```
$ sudo apt-get install libmagickwand-dev
```

### MacOSX (Darwin)

- To install ImageMagick libraries via [Homebrew](http://brew.sh/), please run:
```
$ brew update
$ brew install imagemagick
```

- To install ImageMagick libraries via [MacPorts](https://www.macports.org/),
please run:
```
$ sudo port install ImageMagick
```

### Windows

For 64-bit Windows, please install the [`64-bit`](
http://www.imagemagick.org/download/binaries/ImageMagick-6.9.3-2-Q16-x64-dll.exe)
DLL installer. Otherwise, use the [`32-bit`](
http://www.imagemagick.org/download/binaries/ImageMagick-6.9.3-2-Q16-x86-dll.exe)
version.

Also please remember to enable **"Add to PATH"** option.

## Installation

To install it using Panda (a module management tool bundled with Rakudo Star):

```
$ panda update
$ panda install MagickWand
```

## Testing

To run tests:

```
$ prove -ve "perl6 -Ilib"
```

## Author

Ahmad M. Zawawi, azawawi on #perl6, https://github.com/azawawi/

## License

MIT License
