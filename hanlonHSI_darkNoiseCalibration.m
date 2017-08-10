function parsedDataCube = hanlonHSI_darkNoiseCalibration(parsedDataCube,IT,calFile)

load(fullfile('Hanlon Lab HSI calibration files',calFile,['IT_',num2str(IT),'.mat']));

s = size(parsedDataCube);
parsedDataCube = parsedDataCube - repmat(reshape(dark_noise_by_band,[1 1 16]),[s(1) s(2) 1]);
parsedDataCube(parsedDataCube<0) = 0;
