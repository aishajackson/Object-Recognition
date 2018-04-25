function [ FOREST, C, BOW_matrix_cars, BOW_matrix_faces]=SPM
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
addpath('./scripts');
addpath('C:/Users/sunny/Documents/MATLAB/vlfeat-0.9.20/toolbox/misc');
run('C:/Users/sunny/Documents/MATLAB/vlfeat-0.9.20/toolbox/vl_setup');

facesInfo = dir(['./faces/faces', '/*.jpg']);
carsInfo = dir(['./cars/cars', '/*.jpg']);
feature_matrix = [];

for i = 1:40
   faceName = facesInfo(i).name; 
   carName = carsInfo(i).name;
   path = ['./faces/faces/', faceName];
   pathcar = ['./cars/cars/', carName];
   rgb = imread(path);
   [r, c] = size(rgb(:, :, 1));
   if mod(r, 2) == 1
       r1 = (r+1)./2;
   else
       r1 = r./2;
   end
   if mod(c, 2) == 1
       c1 = (c+1)./2;
   else
       c1 = c./2;
   end
   rgbcar = imread(pathcar);
   [rcar, ccar] = size(rgbcar(:, :, 1));
   if mod(rcar, 2) == 1
       rcar1 = (rcar+1)./2;
   else
       rcar1 = rcar./2;
   end
   if mod(ccar, 2) == 1
       ccar1 = (ccar+1)./2;
   else
       ccar1 = ccar./2;
   end
   I = single(rgb2gray(rgb));
   Icar = single(rgb2gray(rgbcar));
   [f1, d1] = vl_sift(I(1:r1, 1:c1));
   [f4, d4] = vl_sift(I((r1+1):end, (c1+1):end));
   [f2, d2] = vl_sift(I((r1+1):end, 1:c1));
   [f3, d3] = vl_sift(I(1:r1, (c1+1):end));
   [fcar1, dcar1] = vl_sift(Icar(1:rcar1, 1:ccar1));
   [fcar4, dcar4] = vl_sift(Icar((rcar1+1):end, (ccar1+1):end));
   [fcar2, dcar2] = vl_sift(Icar((rcar1+1):end, 1:ccar1));
   [fcar3, dcar3] = vl_sift(Icar(1:rcar1, (ccar1+1):end));
   d = [d1, d2, d3, d4];
   dcar = [dcar1, dcar2, dcar3, dcar4];
   feature_matrix = [feature_matrix, d, dcar];
end
k=3;
feature_matrix = single(feature_matrix);
[C, A] = vl_kmeans(feature_matrix, k);
FOREST = vl_kdtreebuild(C);

BOW_matrix_cars = [];
BOW_matrix_faces = [];

for i = 1:40
   faceName = facesInfo(i).name; 
   path = ['./faces/faces/', faceName];
   rgb = imread(path);
   [r, c] = size(rgb(:, :, 1));
   if mod(r, 2) == 1
       r1 = (r+1)./2;
   else
       r1 = r./2;
   end
   if mod(c, 2) == 1
       c1 = (c+1)./2;
   else
       c1 = c./2;
   end
   I = single(rgb2gray(rgb));
   [~, d1] = vl_sift(I(1:r1, 1:c1));
   [~, d4] = vl_sift(I((r1+1):end, (c1+1):end));
   [~, d2] = vl_sift(I((r1+1):end, 1:c1));
   [~, d3] = vl_sift(I(1:r1, (c1+1):end));
   [index1, ~] = vl_kdtreequery(FOREST, C, single(d1));
   [index2, ~] = vl_kdtreequery(FOREST, C, single(d2));
   [index3, ~] = vl_kdtreequery(FOREST, C, single(d3));
   [index4, ~] = vl_kdtreequery(FOREST, C, single(d4));
   col = [];
   total1 = length(index1);
   total2 = length(index2);
   total3 = length(index3);
   total4 = length(index4);
   total = [total1, total2, total3, total4];
   for cen = 1:k
      itis1 = sum((index1 == cen));
      itis2 = sum((index2 == cen));
      itis3 = sum((index3 == cen));
      itis4 = sum((index4 == cen));
      itisnum = [itis1, itis2, itis3, itis4];
      col = [col; itisnum./total];
   end
   BOW_matrix_faces = [BOW_matrix_faces, col]
end


for i = 1:40
   carName = carsInfo(i).name; 
   path = ['./cars/cars/', carName];
   rgb = imread(path);
   [r, c] = size(rgb(:, :, 1));
   if mod(r, 2) == 1
       r1 = (r+1)./2;
   else
       r1 = r./2;
   end
   if mod(c, 2) == 1
       c1 = (c+1)./2;
   else
       c1 = c./2;
   end
   I = single(rgb2gray(rgb));
   [~, d1] = vl_sift(I(1:r1, 1:c1));
   [~, d4] = vl_sift(I((r1+1):end, (c1+1):end));
   [~, d2] = vl_sift(I((r1+1):end, 1:c1));
   [~, d3] = vl_sift(I(1:r1, (c1+1):end));
   [index1, ~] = vl_kdtreequery(FOREST, C, single(d1));
   [index2, ~] = vl_kdtreequery(FOREST, C, single(d2));
   [index3, ~] = vl_kdtreequery(FOREST, C, single(d3));
   [index4, ~] = vl_kdtreequery(FOREST, C, single(d4));
   col = [];
   total1 = length(index1);
   total2 = length(index2);
   total3 = length(index3);
   total4 = length(index4);
   total = [total1, total2, total3, total4];
   for cen = 1:k
      itis1 = sum((index1 == cen));
      itis2 = sum((index2 == cen));
      itis3 = sum((index3 == cen));
      itis4 = sum((index4 == cen));
      itisnum = [itis1, itis2, itis3, itis4];
      col = [col; itisnum./total];
   end
   BOW_matrix_cars = [BOW_matrix_cars, col];
end


end

