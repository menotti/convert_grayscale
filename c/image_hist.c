/**
* @file image_bw.c
* @brief C program to convert an image to bw
* @author Ricardo Menotti
* @version v1
* @date 2021-05-12
*/
#include <stdio.h>
#include <time.h>

int main()
{
  clock_t start, stop;

  start = clock();            // Note the start time for profiling purposes.

  FILE *fIn = fopen("lena_color.bmp","r");      // Input File name
  FILE *fOut = fopen("lena_hist.bmp","w+");     // Output File name
  FILE *fHist = fopen("histogram.bmp","r");    // Temaplate File name

  int i,j,y,x;
  unsigned char byte[54], hist_byte[54];
  unsigned int hist_data[256];

  if(fIn==NULL || fHist==NULL)              // check if the input file has not been opened succesfully.
  {                      
    printf("File does not exist.\n");
  }

  for(i=0;i<54;i++)            // read the 54 byte header from fIn
  {                  
    byte[i] = getc(fIn);                
    hist_byte[i] = getc(fHist);                
  }

  for(i=0;i<256;i++)
  {
    hist_data[i]=0;
  }

  fwrite(hist_byte,sizeof(unsigned char),54,fOut);      // write the header back

  // extract image height, width and bitDepth from imageHeader 
  int height = *(int*)&byte[18];
  int width = *(int*)&byte[22];
  int bitDepth = *(int*)&byte[28];

  printf("width: %d\n",width);
  printf("height: %d\n",height );

  int size = height*width;          // calculate the image size
  int hist_size = 256*100; 

  unsigned char buffer[size][3];          // store the input image data
  unsigned char out[hist_size][3];          // store the output image data
  unsigned char r, g, b;
  unsigned int gray;

  for(i=0;i<size;i++)            // read image data character by character
  {
    buffer[i][2]=getc(fIn);          // blue
    buffer[i][1]=getc(fIn);          // green
    buffer[i][0]=getc(fIn);          // red
  }

  for(i=0;i<size;i++)           // convert image data character by character
  {
    b=buffer[i][2];          // blue
    g=buffer[i][1];          // green
    r=buffer[i][0];          // red
    gray=(r+(g<<1)+b)>>2;
    hist_data[gray]++;
  }

  for(i=0;i<256;i++)
  {
    for(j=0;j<100;j++)
    {
        out[i*100+j][2] = j < hist_data[i] ? 0 : 255;
        out[i*100+j][1] = j < hist_data[i] ? 0 : 255;
        out[i*100+j][0] = j < hist_data[i] ? 0 : 255;
    }
  }

  for(i=0;i<size;i++)            //write image data back to the file
  {
    putc(out[i][2],fOut);
    putc(out[i][1],fOut);
    putc(out[i][0],fOut);
  }
    
  fclose(fHist);
  fclose(fOut);
  fclose(fIn);

  stop = clock();
  printf("\nCLOCKS_PER_SEC = %ld\n",stop-start); //1000000
  printf("%lf ms\n",((double)(stop-start) * 1000.0)/CLOCKS_PER_SEC );
  return 0;
}
