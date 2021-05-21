#!/usr/bin/env python3
'''This Example opens an Image and transform the image into grayscale, halftone, dithering, and primary colors.
You need PILLOW (Python Imaging Library fork) and Python 3.5
    -Isai B. Cicourel'''

# Imported PIL Library 
from PIL import Image
import sys

# Open an Image
def open_image(path):
  try:
    newImage = Image.open(path)
  except:
    print("Error: file not found!")
    exit(1);
  return newImage

def print_image_hex(image, pformat, arch):
  width, height = image.size
  if pformat == "raw":
    # Print header for https://studio.code.org/s/pixelation/lessons/3/levels/1
    print(format(width, "02X"), format(height, "02X"), format(24, "02X")) 
  else:
    if arch == "riscv":
      if pformat == "byte":
        print("\nimage:\t.byte\t", end="")
      else:
        print("\nimage:\t.word\t", end="")
    else:
      if pformat == "byte":
        print("\nimage\tdcb\t", end="")
      else:
        print("\nimage\tdcd\t", end="")
  
  for j in range(height):
    for i in range(width):
      # Get Pixel
      pixel = image.getpixel((i, j))
      # Get R, G, B values (This are int from 0 to 255)
      red =   pixel[0]
      green = pixel[1]
      blue =  pixel[2]
      if pformat == "raw":
        print(format(pixel[0],"02X"), format(pixel[1], "02X"), format(pixel[2], "02X") , end="", sep="")
      elif pformat == "word":
        print("0x", format(pixel[0],"02X"), format(pixel[1], "02X"), format(pixel[2], "02X"), end=", ", sep="")
      else:
        print("0x", format(pixel[0],"02X"), ", 0x", format(pixel[1], "02X"), ", 0x", format(pixel[2], "02X"), end=", ", sep="")
    if pformat == "raw":
      print("") 

# Create a new image with the given size
def create_image(i, j):
  image = Image.new("RGB", (i, j), "white")
  return image

# Create a Grayscale version of the image
def convert_grayscale(image):
  # Get size
  width, height = image.size

  # Create new Image and a Pixel Map
  new = create_image(width, height)
  pixels = new.load()

  # Transform to grayscale
  for i in range(width):
    for j in range(height):
      # Get Pixel
      pixel = image.getpixel((i, j))

      # Get R, G, B values (This are int from 0 to 255)
      red =   pixel[0]
      green = pixel[1]
      blue =  pixel[2]

      # Transform to grayscale
      gray = (red+(green<<1)+blue)>>2

      # Set Pixel in new image
      pixels[i, j] = (int(gray), int(gray), int(gray))

  # Return new image
  return new

# Main
if __name__ == "__main__":
  if len(sys.argv) < 2:
    print("Usage:\n", sys.argv[0], "[OPTIONS] [FILE]");
    print("    \t Raw (default)");
    print("  -w\t Word");
    print("  -b\t Byte");
    print("  -a\t ARM (default)");
    print("  -r\t RISCV");
    exit(1);
  opts = [opt for opt in sys.argv[1:] if opt.startswith("-")]
  file = [arg for arg in sys.argv[1:] if not arg.startswith("-")]
  # Load Image (JPEG/JPG needs libjpeg to load)
  original = open_image(file[0])
  pformat = "raw"
  if ("-w" in opts):
    pformat = "word"
  elif ("-b" in opts):
    pformat = "byte"
  arch = "arm"
  if ("-r" in opts):
    arch = "riscv"
  # Print Imagem in Hex
  print_image_hex(original, pformat, arch) 
  new = convert_grayscale(original)
  width, height = new.size
  if pformat != "raw":
    if arch == "riscv":
      print("\nbuffer:\t.space\t", width*height*4)
    else:
      print("\nbuffer\tfill\t", width*height*4)
  print_image_hex(new, pformat, arch)
