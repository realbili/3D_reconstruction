function [pp] = wavelet(d0,str)
%WAVELET 
[Img(:,:), ~] = imread(str);
I=Img;
f=double(I);
f=fft2(f);
f=fftshift(f);
[m,n]=size(f);  %
m1=fix(m/2);
n1=fix(n/2);
for M=1:m
   for N=1:n
      d=sqrt((M-m1)^2+(N-n1)^2);
      h(M,N)=exp(-d^2/2/d0^2);
   end
end
g=f.*h;
g=ifftshift(g);
g=ifft2(g);
g=real(g);
width_F = 7;
Radiu=floor(width_F/2);
pp=double((g(Radiu:end-Radiu+1,Radiu:end-Radiu+1))); 
end

