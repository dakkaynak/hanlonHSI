function dataCube = hanlonHSI_badPixelCalibration(dataCube,calFile)

% Even though it's called BadPixelMask, it's actually a GoodPixelMask
% ie good pixels are marked with 1, and bad ones with 0
load(fullfile('Hanlon Lab HSI calibration files',calFile))

BadPixelMask = double(BadPixelMask);
BadPixelMask(BadPixelMask==0) = NaN;
% Note that this only works on the 512x512 demosaicked image

s = size(dataCube);
dataCube = reshape(dataCube,[s(1)*s(2) s(3)]);
BadPixelMask = repmat(reshape(BadPixelMask,[s(1)*s(2) 1]),[1 s(3)]);
dataCube = dataCube.*BadPixelMask;
dataCube = reshape(dataCube,[s(1) s(2) s(3)]);
