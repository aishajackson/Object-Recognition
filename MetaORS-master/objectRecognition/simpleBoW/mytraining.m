function [ FOREST C BOW_matrix_cars BOW_matrix_faces ] = mytraining(k)
% MYTRAINING 
% implementation of BoW algorithm for classification task on CARs and FACEs
%
% inputs:
%   k: parameter k for k-means clustering
%
% outputs:
%   FOREST: k-d tree with k-means centers
%   C: k-means centeros
%   BOW_matrix_cars: histgram of CARs
%   BOW_matrix_faces: histgram of FACEs
%
% Note,
% (1) make sure you have /cars and /faces dataset under this folder
% (2) make sure you add subfolder into addpath
% (3) install vlfeat by yourself or use the (provided) previous version of vlfeat(http://www.vlfeat.org/overview/sift.html)
% (4) you may use your own clustering, or use k-means provided by vlfeat lib
% (5) all you need to modify is in TODOs, please search for TODOs

tic
%% setup dataset and helper functions
addpath('./scripts');
addpath('./vlfeat/toolbox/misc');

run('vlfeat/toolbox/vl_setup');
%% building clusters of words
% extract and collect the sift feature of each images
%addpath('./cars'); files_car = dir(['./cars' '/*.jpg']);
%addpath('./faces'); files_faces = dir(['./faces' '/*.jpg']);
feature_matrix = [];
% TODOs:
% use first 40 images in both /cars and /faces as training images
% transform each RGB image to gray image, and extract sift feature by vlfeat
% collect all features in 'feature_matrix'(128 by number of all features)


    





% find the centers of features by k-means
feature_matrix = single(feature_matrix);
[C, A] = vl_kmeans(feature_matrix, k);

% compute codewords by kd-tree(vl_kdtreebuild)
% TODOs:
% compute a kd-tree using vlfeat libariry using C above, and output to
% FOREST variable (should be just one line of code)

FOREST = [];








%% building bag-of-words for CARs and FACEs
% compute the histogram(frequency) of each training image
%addpath('./cars'); files_car = dir(['./cars' '/*.jpg']);
%addpath('./faces'); files_faces = dir(['./faces' '/*.jpg']);

BOW_matrix_cars = [];
BOW_matrix_faces = [];
% TODOs:
% now you have centers (codewords) 
%
% you can start to compute the histogram for each training image (/cars, and /faces)
% (1) First, for each image you extract sift descriptors
% (2) then for each extracted descriptor, use kd-tree above to query for index
% (3) build the histogram with all descriptor for one image (remember to normalize it)
% (4) collect all histogram in BOW_matrix_cars and BOW_matrix_faces
%
% hint: BOW_matrix_cars and BOW_matrix_faces are both k by number of images











toc









