clear all;
close all;
format bank;
%There are two options: To read the results of Faster-RCNN o AlexNet
%[mread,framenum] = readmetaJEEO;
%[mread,framenum] = readmetaJEEOAlexNet;
fread = xmlRead();
%This frame num corresponds to the total of frames used to create the dataset
framenum=10000;
gtread = transfer(fread,framenum);

temp_gt = gtread;
%temp_meta = mread;
gtout = temp_gt;
%mout = temp_meta;
temp = [];

rownumgt = size(temp_gt);
%rownummeta = size(temp_meta);

frameid = 0;
gtnum = 0;
occf = [0 0];

detections=cell(framenum,1);

%----------------- match each GT bbox with Detected bboxs ---------------
for igt = 1:rownumgt(1)-1
    %check the GT if there are objects detected (ask for rows pairs)
    if (temp_gt(igt,2)==0&&temp_gt(igt+1,2)==0)
    %check when it found an detected object in GT    
    elseif (temp_gt(igt,2)==0&&temp_gt(igt+1,2)>0)
        %identify the framenumber where the object is detected in GT
             frameid = temp_gt(igt,1);
             temp=[];
    %check once the GT detected object is identify 
    elseif (temp_gt(igt,2)>0&&temp_gt(igt,3)>0) 
       %Verify in All rows of the System Detection (eg FasterRCNN)
       if temp_gt(igt,7)==1
           box=[temp_gt(igt,4),temp_gt(igt,5),temp_gt(igt,3),temp_gt(igt,2)]
           detections{frameid,1}=[temp;box];
           temp=detections{frameid,1};
       end
    end
   
      
end
%%
%-------------------------------------------------------------------------
% To copy the directory file names
%Locate in to the directiry you want to copy
cd 'D:\Videos\DronTomas\images10k';
%Edit the collumns an just reserve the Filename column
directory=dir;
directory(1:2) = [];
%This is done for erase the remaining 9 files names
directory(10001:10009) = [];
directory = rmfield(directory, {'date', 'bytes', 'isdir', 'datenum'});
%Create the Tabla dataset with vehicles
d=struct2cell(directory);
d=d';
%Creatye the data Table suitable for Faster R-CNN
VehicleDataset=table(d,detections);
%rename the columns
VehicleDataset.Properties.VariableNames{1} = 'imageFilename';
VehicleDataset.Properties.VariableNames{2} = 'motorbike';
%%
%-------------------------------------------------------------------------
%For counting the total number of annotations in all frames
[nImages,dummy]=size(VehicleDataset);
bboxCounter=0;
bboxMax=0;
for i=1:nImages
    [nBoxes,dummy]=size(VehicleDataset.motorbike{i,1});
    bboxCounter=bboxCounter+nBoxes;
    if nBoxes >bboxMax
        bboxMax=nBoxes;
        bboxMaxFrame=i;
    end
end


disp(bboxCounter);
%Displays the max number of boxes found in one frame
disp(bboxMax);
%Display the Frame number whgich has the greatest quantity of boxes annotated
disp(bboxMaxFrame);

%Save the struct for EspinNet
save('Motos10k.mat');


