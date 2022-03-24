function [trajectories] = prvni(path)
img_paths = dir([path, '\*.jpg']);
trajectories = cell(1,6);

I = im2double(rgb2gray(imread([img_paths(1).folder, '\', img_paths(1).name])));
BW = imbinarize(I,0.22);
BW = ~BW;
BW2 = bwareafilt(BW,6);

% [B,L] = bwboundaries(BW2, 'noholes');
% Find the centroid

measurements = regionprops(BW2, 'Centroid');
centroids = cat(1,measurements.Centroid);

for k = 1:length(centroids)
    trajectories{k}(1,:) = centroids(k,:);
end

for i = 2:length(img_paths)
    I = im2double(rgb2gray(imread([img_paths(i).folder, '\', img_paths(i).name])));
    BW = imbinarize(I,0.22);
    BW = ~BW;
    BW2 = bwareafilt(BW,6);

%     [B,L] = bwboundaries(BW2, 'noholes');

    measurements = regionprops(BW2, 'Centroid');
    centroids = cat(1,measurements.Centroid);

%     figure
%     imshow(BW)
%     hold on
%     plot(centroids(:,1),centroids(:,2), 'r+','MarkerSize',10)
%     hold off

    for k = 1:length(centroids)
        trajectories{k}(i,:) = centroids(k,:);
    end

end
end


