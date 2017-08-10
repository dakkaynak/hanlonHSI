function [linearRGB,sRGB] = hanlonHSI_synthesizeRGBImg(dataCube,WL)

% sample the spectrun more densely
newWL = 400:1:660;

s = size(dataCube);
dataCube = reshape(dataCube,[s(1)*s(2) s(3)]);
dataCube(isnan(dataCube)) = 0;
[x,dataCube] = cropTo400_700nm(WL,dataCube',400,660);
dataCube = interp1(x,dataCube,newWL);
dataCube(isnan(dataCube)) = 0;
dataCube = reshape(dataCube',[s(1) s(2) numel(newWL)]);


% CIE standard observer peak wavelengths 445, 550, 600 but here we are
% using Leif's peak wavelengths.

rind = find(abs(newWL - 640)==min(abs(newWL-640)));
gind = find(abs(newWL - 540)==min(abs(newWL-540)));
bind = find(abs(newWL - 460)==min(abs(newWL-460)));

linearRGB(:,:,1) = medfilt2(dataCube(:,:,rind));
linearRGB(:,:,2) = medfilt2(dataCube(:,:,gind));
linearRGB(:,:,3) = medfilt2(dataCube(:,:,bind));

% Apply white balancing for appearance
sRGB = linearRGB2sRGB(mat2gray(linearRGB));



function sRGB = linearRGB2sRGB(inImg)
%for details: http://brucelindbloom.com/index.html?Eqn_RGB_XYZ_Matrix.html

% sRGB companding
linearRGB = inImg;
mask = linearRGB > 0.0031308;
linearRGB(mask) = 1.055*(linearRGB(mask).^(1.0/2.4)) - 0.055;
linearRGB(~mask) = 12.92*linearRGB(~mask);

% Normally this should be done with gamut mapping, but since we're only
% using this RGB image for visualization, it's ok.
linearRGB(linearRGB<0)=0;
linearRGB(linearRGB>1)=1;
sRGB = linearRGB;


function [xLP,yLP] = cropTo400_700nm(xLP,yLP,s1,s2)

ind = find(xLP>s2,1,'first');
xLP(ind:end,:) = [];
yLP(ind:end,:) = [];

ind = find(xLP<s1,1,'last');
xLP(1:ind,:) = [];
yLP(1:ind,:) = [];

