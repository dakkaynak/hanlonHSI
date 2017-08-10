function hanlonHSI_saveCalibratedImage(dataCube,rgbImg,savePath,imgName)

shortName = imgName(1:end-4);

% First save the datacube and rgb image
save(fullfile(savePath,[shortName,'_calibratedImage.mat']),'dataCube','rgbImg');

% Now save a jpg image for quick visualization
imwrite(mat2gray(rgbImg),fullfile(savePath,[shortName,'_RGBImage.jpg']))

% Show a message to the user
display([imgName,' successfully saved.'])