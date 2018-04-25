function [ ] = mykmeans( )
%MYKMEANS Summary of this function goes here
% under the algorithmic steps carefully and implement each step below
%
% All you have to modify are in:
% (1)  'K-mean algorithm' section
% (2)  'assign RGB color to each cluster' section
% also, feel free to modify the ite(iteration number in 'settings' 
% check or seach TODOs 
%
% note, 
%  (1) varaible 'im_array' is a 1 by row*col by 4 matrix. For each pixel in original testing image, we store its R,G,B value as well as temporal class.
%      To be specific, for each i in row*col, the four elements represent R,G,B, and class for each pixel. Please check the pre-processing for details.  
%  (2) variable 'center_vector' is a 3 by 1 by 3 matrix. center_vector(k, 1, 3) denotes the center of class k
%  (3) variable 'process_idx_array' is the index without background
%  (4) after running clustering algorithm, you should pass 'im_array' with k kind of color. And you can pass down the imshow it. 

%% settings
% testing image
im = imread('segmentation.jpg');
% clustering number k
k = 3;
% iteration number ite, modify it 
ite = 5;

imgray = rgb2gray(im);
im = double(im);
[row col height] =  size(im);
total_element = row*col;

% if center does not move in few steps, then stop
center_vector = zeros(k,1,3);
last_center_vector = zeros(k,1,3);

%% initialization
im_array = reshape(im,1,total_element,3);
imgray_array = reshape(imgray,1,total_element);
% remove the background
process_idx_array = find(imgray_array ~= 255);
% re-calculating pixels
total_process_element = length(process_idx_array);
% randly choose three points as starting points
rand_array = randperm(total_process_element); 
for idx = 1:k,
    chosen_idx = process_idx_array(rand_array(idx));
    center_vector(idx,1,:) = im_array(1, chosen_idx, 1:3);
end

%% K-mean algorithm      
im_array(:,:,4) = 0;
for iter = 1:ite,
    % assigning each point to cluster with nearest mean
    for idx = process_idx_array,
        class = 0;
        % TODOs: 
        
        

        % you should update im_array(1, idx, 4) = class;
    end
    % re-calculatin new mean 
    for idx = 1:k
        % TODOs:
        
        
        
        % you should update 'center_vector'
    end  
    % If no mean has changed more than some one time, stop 
    if(isequal(center_vector, last_center_vector))
        % TODOs:

    else
        % TODOs:

        
    end            
iter        
center_vector  
end

%% assign RGB color to each cluster
% TODOs:
% implement a way to assign the color for each clustering



%% show image
k_im = reshape(im_array,row,col,4);
k_im = k_im(:,:,1:3);
imshow(k_im/256);


