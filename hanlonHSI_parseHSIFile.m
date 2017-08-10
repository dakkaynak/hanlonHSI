function parsedDataCube = hanlonHSI_parseHSIFile(rawDataCube,inds)

rawDataCube = double(rawDataCube);

% output
%fun = @(block_struct) transpose(block_struct.data);
%rawDataCube = blockproc(rawDataCube,[4 4],fun);
B = im2col(rawDataCube,[4 4],'distinct');
parsedDataCube = fliplr(reshape(B',[512 512 16]));
parsedDataCube = parsedDataCube(:,:,inds);

%parsedDataCube = parsedDataCube(:,:,[1 5 9 13 2 6 10 14 3 7 11 15 4 8 12 16]);

% parsedDataCube = zeros(512,512,16);
% for i = 1:4
%     parsedDataCube(:,:,i)=rawDataCube(i:4:2048,1:4:2048);
% end
% for i = 5:8
%     parsedDataCube(:,:,i)=rawDataCube(i-4:4:2048,2:4:2048);
% end
% for i = 9:12
%     parsedDataCube(:,:,i)=rawDataCube(i-8:4:2048,3:4:2048);
% end
% for i = 13:16
%     parsedDataCube(:,:,i)=rawDataCube(i-12:4:2048,4:4:2048);
% end
% 
% for j = 1:16
%     parsedDataCube(:,:,j) = fliplr(parsedDataCube(:,:,j));
% end
% 
% temp = parsedDataCube;
% for j = 1:16
%     parsedDataCube(:,:,j) = temp(:,:,inds(j));
% end
