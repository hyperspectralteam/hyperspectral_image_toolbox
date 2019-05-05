clear all;
close;
I=checkerboard(40);
F=fft2(I);
figure,imshow(I);
figure,imshow(F);