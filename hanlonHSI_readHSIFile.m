function dataCube = hanlonHSI_readHSIFile(filePath)

% Read the raw file from the camera
dataCube = fread(fopen(filePath), [2048 2048], 'uint16');




