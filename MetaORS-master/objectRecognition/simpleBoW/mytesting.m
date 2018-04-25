function [ correct_car correct_face correctness] = mytesting(  FOREST, C, BOW_matrix_cars, BOW_matrix_faces,k ) 
tic
%MYTESTING Summary of this function goes here
%   Detailed explanation goes here
% inputs
%   FOREST: k-d tree obtained from mytraining.m
%   C: k-means center obtained from mytraining.m
%   BOW_matrix_cars: BOW from mytraining.m
%   BOW_matrix_faces: BOW from mytraining.m
%   k: the same cluster number as mytraining.m
% 
%  outputs
%   correct_car: number of detection
%   correct_face: number of detection
%   correctness: overall recall

addpath('./scripts');
addpath('./vlfeat/toolbox/misc');
run('vlfeat/toolbox/vl_setup');

correct_car = 0;
correct_face = 0;

addpath('./cars'); files = dir(['./cars' '/*.jpg']);
for i=41:90
    disp(files(i).name); 
    I = imread(files(i).name);
    % TODOs:
    % for each of testing image, 
    % (1) extract sift descriptor as in training process
    % (2) compute histogram
    % (3) store normalized histogram as variable v for knnsearch
    % (4) assign it to the closer object
    
    
    
    
    
    
    
    
    
    [IDX d_car] = knnsearch(BOW_matrix_cars',v');
    [IDX d_face] = knnsearch(BOW_matrix_faces',v');
    if(d_car < d_face)
        correct_car = correct_car+1;
    end
end
clear files

addpath('./faces'); files = dir(['./faces' '/*.jpg']);
for i=41:90
    disp(files(i).name); 
    I = imread(files(i).name);
    % TODOs:
    % same as above except this is for face
    
    
    
    
    
    
    
    
    
    
    if(d_face < d_car)
        correct_face = correct_face+1;
    end
end
clear files

correctness = (correct_car+correct_face)/100;
toc

