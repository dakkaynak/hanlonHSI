function dataCube = hanlonHSI_radianceConversion(dataCube,IT,calFile)

load(fullfile('Hanlon Lab HSI calibration files',calFile))

conv_t = radiancecalibration(1,1)./IT;
rad_conv = radiancecalibration(2:17,1)./radiancecalibration(2:17,2).*conv_t;
s = size(dataCube);
dataCube = reshape(dataCube,[s(1)*s(2) 16]);
dataCube = dataCube.*repmat(rad_conv',[s(1)*s(2) 1]);
dataCube = reshape(dataCube,[s(1) s(2) 16]);

