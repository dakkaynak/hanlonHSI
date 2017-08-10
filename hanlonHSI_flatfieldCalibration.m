function parsedDataCube = hanlonHSI_flatfieldCalibration(parsedDataCube,inds)

%load 2015-08-21_Leif_conversion_files flatfield
load(fullfile('Hanlon Lab HSI calibration files','hanlonHSI_flatfieldCalibrationFile'),'flatfield')

flatfield = hanlonHSI_parseHSIFile(flatfield,inds);
flatfield(flatfield==Inf) = 0;
s = size(flatfield);
% 
% for iband = 1:16
%     temp = squeeze(flatfield(:,:,iband));
%     temp(4:end,:) = squeeze(flatfield(1:509,:,iband));
%     temp(1:3,:) = 0;
%     flatfield(:,:,iband) = temp;
% end
% 
% %*% shift down 3 rows the image, add 3 black rows to top, per Leif's code
% for iband = 1:16
%     temp = squeeze(parsedDataCube(:,:,iband));
%     temp(4:end,:) = squeeze(parsedDataCube(1:509,:,iband));
%     temp(1:3,:) = 0;
%     parsedDataCube(:,:,iband) = temp;
% end


flatfield = reshape(flatfield,[s(1)*s(2) 16]);

% Multiply the sensor image with the flatfield correction mask.
parsedDataCube = reshape(parsedDataCube,[s(1)*s(2) 16]);
parsedDataCube = reshape(parsedDataCube.*flatfield,[s(1) s(2) 16]);

