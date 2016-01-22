use v6;

unit class MagickWand;

use NativeCall;
use MagickWand::NativeCall;

# Wand native handle
has Pointer $.handle is rw;

method read-image(Str $file-name) returns Bool {
  $.handle = NewMagickWand unless $.handle.defined;
  return MagickReadImage( $.handle, $file-name ) == MagickTrue;
}

method get-image-gamma returns Num {
  die "No wand handle defined!" unless $.handle.defined;
  return MagickGetImageGamma( $.handle );
}

method auto-gamma returns Bool {
  die "No wand handle defined!" unless $.handle.defined;
  return MagickAutoGammaImage( $.handle ) == MagickTrue;
}

method auto-level returns Bool {
  die "No wand handle defined!" unless $.handle.defined;
  return MagickAutoLevelImage( $.handle ) == MagickTrue;
}

method negate returns Bool {
  die "No wand handle defined!" unless $.handle.defined;
  return MagickNegateImage( $.handle ) == MagickTrue;
}

method charcoal(Rat $radius, Rat $sigma) returns Bool {
  die "No wand handle defined!" unless $.handle.defined;
  return MagickCharcoalImage( $.handle, $radius.Num, $sigma.Num ) == MagickTrue;
}

method write-image(Str $file-name) returns Bool {
  die "No wand handle defined!" unless $.handle.defined;
  return MagickWriteImage( $.handle, $file-name ) == MagickTrue;
}

method crop(Int $x, Int $y, Int $width, Int $height) returns Bool {
  die "No wand handle defined!" unless $.handle.defined;
  return MagickCropImage($.handle, $width, $height, $x, $y) == MagickTrue;
}

method chop(Int $x, Int $y, Int $width, Int $height) returns Bool {
  die "No wand handle defined!" unless $.handle.defined;
  return MagickChopImage($.handle, $width, $height, $x, $y) == MagickTrue;
}

method clone returns MagickWand {
  die "No wand handle defined!" unless $.handle.defined;
  my $cloned-wand = CloneMagickWand($.handle);
  return MagickWand.new( handle => $cloned-wand );
}

submethod append-wands(+@wands) returns MagickWand {
  my $temp-wand = NewMagickWand;
  MagickSetLastIterator($temp-wand);

  # Add wands
  for @wands -> $wand {
    MagickAddImage($temp-wand, $wand.handle);
    MagickSetLastIterator($temp-wand);
  }

  # Append them side-by-side horizontallly
  MagickSetFirstIterator($temp-wand);
  my $cloned-wand = MagickAppendImages($temp-wand, MagickFalse);

  # Cleanup
  DestroyMagickWand( $temp-wand );

  return MagickWand.new( handle => $cloned-wand );
}

method cleanup {
  DestroyMagickWand($.handle) if $.handle.defined;
}
