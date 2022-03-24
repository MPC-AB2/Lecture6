function [trajectories] = Radiologove(path)

%% LOADING
<<<<<<< HEAD
listing = dir([path '*.jpg']);
=======
listing = dir([path '\' '*.jpg']);
>>>>>>> 64bb7b3ea7f620da63a9d3c09c0e7ab947f4c862
Obr = cell(length(listing),1);
for i = 1:length(listing)
    Obr{i} = im2double(imread([path, listing(i).name]));
end

centroids = cell(size(Obr,1),1);
% load('data_ants.mat')
for i = 1:length(Obr)

    pomocny = rgb2gray(Obr{i});
<<<<<<< HEAD
    pomocny = pomocny < 0.2;
    SE = strel('diamond',2);
    pomocny = imopen(pomocny,SE);
=======
    pomocny = pomocny < 0.1;
>>>>>>> 64bb7b3ea7f620da63a9d3c09c0e7ab947f4c862
    [y,x] = find(pomocny);
    fcmdata = [x,y];
    [centers,~] = fcm(fcmdata,6);
    
%     temp = false(size(pomocny));
%     for j = 1:6
%         temp(round(centers(j,2)), round(centers(j,1))) = true;
%     end
    centroids{i} = centers;

%     CC = bwconncomp(pomocny);
%     n_obj = CC.NumObjects;
%     n_obj_o = n_obj;
%     if n_obj > 6
%         while n_obj ~= 6 && n_obj_o >= n_obj && n_obj > 6
%             SE = strel('diamond',j);
%             J = imopen(pomocny,SE);
%             J = imfill(J,'holes');
%     
%             CC = bwconncomp(J);
%             n_obj_o = n_obj;
%             n_obj = CC.NumObjects;
%             j = j+1;
%         end
%     end
%     SE = strel('diamond',2);
%     J = imopen(pomocny,SE);
% %     if n_obj_o < n_obj || n_obj ~= 6
% %         j = 1;
% %         while n_obj ~= 6 && n_obj_o >= n_obj
% %             SE = strel('diamond',j);
% %             J = imerode(J,SE);
% %             J = imfill(J,'holes');
% %     
% %             CC = bwconncomp(J);
% %             n_obj_o = n_obj;
% %             n_obj = CC.NumObjects;
% %             j = j+1;
% %         end
% %     end
%     a(i) = n_obj;
%     Obr{i} = double(J);
end
move_x = zeros(size(centroids,1),6);
move_y = zeros(size(centroids,1),6);
move_x(1,:) = centroids{1}(:,1);
move_y(1,:) = centroids{1}(:,2);
for i = 1:length(centroids)-1
    for j = 1:6
        k = dsearchn(centroids{i+1} ,[move_x(i,j) move_y(i,j)]);
        move_x(i+1,j) = centroids{i+1}(k,1);
        move_y(i+1,j) = centroids{i+1}(k,2);
    end
end
trajectories = cell(1,6);
matrix = zeros(size(Obr,1),2);
for i = 1:6
ant = matrix;
ant(:,1) = move_x(:,i);
ant(:,2) = move_y(:,i);
trajectories{1,i} = ant;
end

end