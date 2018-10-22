clc;
clear all;
close all;
imtool close all;

im = imread('proj5.gif');
imwrite(im,'input_img.gif');
[rows col] = size(im);

%% Morphological Image Processing

%Histogram Plot
histogram = histo_pcap(im);
y=1:1:409;
h= figure;
plot(y,histogram);
xlabel('r'); ylabel('p^r(r)');
title('Histogram of input image');
saveas(h,'histogram_input.jpg');

% Thresholding the image to two values
for i=1:rows
    for j=1:col
        if (im(i,j)> 50)        %Thresholding at 50
            im(i,j) = 0;
        else
            im(i,j)=255;
        end
    end
end
figure;imshow(im);
imwrite(uint8(im),'threshold_image.gif');

%% Noise removal
% for i=1:rows
%     for j=2:col-1
%         im(i,j) = median([im(i,j-1),im(i,j),im(i,j+1)]);
%     end
% end
% 
% new_opened_im = im;

% Erosion by a 3x3 mask
new_eroded_im = erosion(im,3,3);
figure;imshow(new_eroded_im)
imwrite(uint8(new_eroded_im),'Filtered_pepper_noise_img.gif');

% Dilation by a 3x3 mask
new_opened_im = dilation(new_eroded_im,3,3);
figure;imshow(new_opened_im);
imwrite(uint8(new_opened_im),'Filtered_noise_img.gif');

%% Removing the small letters

[rows col]=size(new_opened_im);
marker_im=zeros(rows,col);

% % Erosion by a 44x1 mask
% mask_44_cross_1 = 255*ones(44,1);
% for i=1:rows-44
%     for j=1:col
%         if(uint8(new_opened_im(i:i+43,j))& uint8(mask_44_cross_1))
%             marker_im(i,j)=255;
%         end
%     end
% end

% Erosion by 45x1 mask
marker_im = erosion(new_opened_im,45,1);
figure; imshow(marker_im);
imwrite(uint8(marker_im),'Marker_points_img.gif');

%% Reconstruction of tall characters

output_im = reconstruct(marker_im,new_opened_im);
output_im =255*output_im;
figure; imshow(output_im);
imwrite(uint8(output_im),'Tall_characters_img.gif');

%% Edge Detection
[thick_edged_im edged_im] = edge_detection(output_im);
figure;imshow(edged_im);
imwrite(uint8(thick_edged_im),'Thick_edged_img.gif');

figure;imshow(thick_edged_im);
imwrite(uint8(edged_im),'Thin_edged_img.gif');