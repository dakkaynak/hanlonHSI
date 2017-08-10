function dataCube = hanlonHSI_deconvolution(dataCube,inds,calFile)

load(fullfile('Hanlon Lab HSI calibration files',calFile))

s = size(dataCube);

dataCube = reshape(dataCube,[s(1)*s(2) s(3)]);
deconv_unscramble = deconvolution(:,inds);
dataCube = reshape(dataCube*deconv_unscramble',[s(1) s(2) 16]);







