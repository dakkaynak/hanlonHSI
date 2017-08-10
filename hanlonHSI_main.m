% This code calibrates images taken by the Hanlon Lab HSI (in .3d format).
% See the "Hanlon Lab HSI Calibration Document" for details
%
% Derya Akkaynak + Stephanie Palmer
% August 2017

clear;close;clc;warning off

% This is the folder containing .3d images. Modify as needed.
folder = '/Users/deryaakkaynak/Dropbox/Raja Ampat HSI/Roger HSI measurements in air of color standards 25 Jan 17';

% Calibration files are all in a folder called: Hanlon Lab HSI calibration
% files. This is where the code will look for them.
% Be sure to put new versions in that folder.
darkNoiseCalibrationFile = 'hanlonHSI_darkNoiseCalibrationFiles.mat';
flatfieldCalibrationFile = 'hanlonHSI_flatfieldCalibrationFile.mat';
deconvolutionCalibrationFile = 'hanlonHSI_deconvolutionCalibrationFile.mat';
radianceCalibrationFile = 'hanlonHSI_radianceCalibrationFile2015.mat';
badPixelCalibrationFile = 'hanlonHSI_badPixelCalibrationFile.mat';

% Outputs (datacube and rgb image) are saved in the same folder as the raw
% images. Change below if needed.
saveFolder = folder;

% List of .3d files in the selected folder
filesInFolder = dir([folder,'/*.3d']);

% This is the mosaic pattern of the camera
WL = [ 560 620 660 436;520 405 380 640;540 360 460 580;600 420 480 500];
WL = sort(WL(:));

% These are the indices we will use to access the mosaic
inds = [10 7 6 14 4 11 15 16 5 9 1 12 13 2 8 3];


% Loop over for all images in the chosen folder
for i = 10%1:numel(filesInFolder)
    
    % Raw data cube from the camera
    imgName = filesInFolder(i).name;
    
    % Read off IT from the filename
    IT = str2double(regexp(imgName,'(?<=_)(.*?)(?=ms.3d)','match'));
    
    % Read the raw datacube
    rawDataCube = hanlonHSI_readHSIFile(fullfile(folder,imgName));
    
    % Demosaic the datacube
    parsedDataCube = hanlonHSI_parseHSIFile(rawDataCube,inds);
    
    % CALIBRATIONS
    % Flatfield correction
    parsedDataCube = hanlonHSI_flatfieldCalibration(parsedDataCube,inds);
    
    % Dark Noise Correction - WE DONT HAVE THE CALIBRATION FILES FOR THIS
    % YET
    % parsedDataCube = hanlonHSI_darkNoiseCalibration(parsedDataCube,IT,darkNoiseCalibrationFile);
    
    % Bad pixel calibration
    parsedDataCube = hanlonHSI_badPixelCalibration(parsedDataCube,badPixelCalibrationFile);
    
    % Deconvolution
    parsedDataCube = hanlonHSI_deconvolution(parsedDataCube,inds,deconvolutionCalibrationFile);
    
    % Radiance Correction
    parsedDataCube = hanlonHSI_radianceConversion(parsedDataCube,IT,radianceCalibrationFile);
    
    % SynthesizeRGB image
    [linearRGB,sRGB] = hanlonHSI_synthesizeRGBImg(parsedDataCube,WL);
    
    % Save the datacube and sRGB image
    hanlonHSI_saveCalibratedImage(parsedDataCube,sRGB,saveFolder,imgName);
end



