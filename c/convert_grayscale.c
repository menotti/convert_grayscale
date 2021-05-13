void convert_grayscale(int width, int height, unsigned char *image) {
  for (int j=0; j<height; j++)
    for (int i=0; i<width; i++) {
      unsigned char red = image[(i+j*width)*3];
      unsigned char green = image[(i+j*width)*3+1];
      unsigned char blue =  image[(i+j*width)*3+2];
      unsigned int gray = (red+(green<<1)+blue)>>2;
      image[(i+j*width)*3  ] = (unsigned char)gray;
      image[(i+j*width)*3+1] = (unsigned char)gray;
      image[(i+j*width)*3+2] = (unsigned char)gray;
    }
  return;
}
