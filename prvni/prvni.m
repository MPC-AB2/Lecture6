function [trajectories] = prvni(path)
img_paths = dir([path, '\*.jpg']);
trajectories = cell(1,6);

Im = im2double(rgb2gray(imread([img_paths(1).folder, '\', img_paths(1).name])));
I_med = medfilt2(Im,[3 3]);
BW = imbinarize(I_med,0.20);
BW = ~BW;

% D = -bwdist(BW);
% D = imhmin(D,3);
% D(BW) = -Inf;
% Ld = watershed(D);
% BW2 = BW;
% BW2(Ld == 0) = 0;
% se1 = strel('sphere',2);
% BW2 = imerode(BW2, se1);
% se2 = strel('line',6, 90);
% BW2 = imerode(BW2, se2);
BW = bwareafilt(BW,6);


measurements = regionprops(BW, 'Centroid');
centroids = cat(1,measurements.Centroid);

for k = 1:length(centroids)
    trajectories{k}(1,:) = centroids(k,:);
end


for i = 2:length(img_paths)

    Im = im2double(rgb2gray(imread([img_paths(i).folder, '\', img_paths(i).name])));
    I_med = medfilt2(Im,[3 3]);
    BW = imbinarize(I_med,0.20);
    BW = ~BW;
    BW = bwareafilt(BW,6);
    
    centroids_old = centroids;
    measurements = regionprops(BW, 'Centroid');
    centroids = cat(1,measurements.Centroid);

    if size(centroids,1)<6
        BW = ~BW;
        Di = -bwdist(BW);
        Di = imhmin(Di,3);
        Di(BW) = -Inf;
        Ld = watershed(Di);
        BW2 = BW;
        BW2(Ld == 0) = 0;
        se1 = strel('sphere',2);
        BW2 = imerode(BW2, se1);
        se2 = strel('line',6, 90);
        BW2 = imerode(BW2, se2);
        BW3 = bwareafilt(BW2,6);
        
        measurements = regionprops(BW3, 'Centroid');
        centroids = cat(1,measurements.Centroid);

    end
%     figure
%     imshow(BW)
%     hold on
%     plot(centroids(:,1),centroids(:,2), 'r+','MarkerSize',10)
%     hold off
    D = zeros(6,6);
    for ii = 1:6
        for kk = 1:6
            D(ii,kk) = sqrt((centroids_old(ii,1)-centroids(kk,1))^2 + (centroids_old(ii,2)-centroids(kk,2))^2);
        end
    end

%     D = pdist2(centroids_old, centroids);
    [M,I] = min(D);

    for k = 1:length(I)
        trajectories{k}(i,:) = centroids(I(k),:);
    end 
    
%     if length(centroids)<6
%         disp(i)
%     end
%     if sum(I)<21
%         disp(i)
%     end

    if (102<i) && (i<103)
        figure
        imshow(BW3)
        hold on
        plot(centroids(:,1),centroids(:,2), 'r+','MarkerSize',10)
        hold off
    end
end



end