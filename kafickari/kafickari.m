function [trajectories] = kafickari(path_directory)
%KAFICKARI Summary of this function goes here
%   Detailed explanation goes here
original_files=dir([path_directory '/*.jpg']); 
 obr = {};

 
 for k=1:length(original_files)
    filename=[path_directory '\' original_files(k).name];
    obr{k}= imread(filename);
    
 end
 %%

 %%

 pom = obr{1};
 imshow(pom,[])
 pom = im2double(rgb2gray(pom));

A_otsu_thresh = zeros(size(pom));
A_otsu_thresh(pom<0.25) = 1;
imshow(A_otsu_thresh);
Ierod = imerode(A_otsu_thresh, strel('diamond',3));
Ierod = imdilate(Ierod, strel('diamond',2));
Ierod = bwareafilt(logical(Ierod),6);
%%

% s = regionprops(Ierod,'centroid');
% centroids = cat(1,s.Centroid);

CC = bwconncomp(Ierod);
S = regionprops(CC,'Centroid');
S_mat = cell2mat(struct2cell(S));
matica = zeros(6,2);
for i=1:length(S)
    tmp = S(i).Centroid;
    matica(i,:) = tmp;
end


tracker = vision.PointTracker('NumPyramidLevels',15 ,  'MaxBidirectionalError', 3, 'BlockSize', [81 81], 'MaxIterations', 50 );
%points = detectMinEigenFeatures(im2gray(obr{1}));
initialize(tracker,matica, obr{1});
trajectories = cell(1, 6);
for i = 1:length(original_files)
    points = [];
    validity = [];
    [points,validity] = tracker(obr{i});

     pom = obr{i};
     pom = im2double(rgb2gray(pom));   
    
    A_otsu_thresh = zeros(size(pom));
    A_otsu_thresh(pom<0.25) = 1;
    Ierod = imerode(A_otsu_thresh, strel('diamond',3));
    Ierod = imdilate(Ierod, strel('diamond',2));
    Ierod = bwareafilt(logical(Ierod),6);
    CC = bwconncomp(Ierod);
    S = regionprops(CC,'Centroid');
    S_mat = cell2mat(struct2cell(S));

    matica_temp = matica;
    matica = zeros(6,2);
    for j=1:length(S)
        tmp = S(j).Centroid;
        matica(j,:) = tmp;
    end

    if (min(min(matica))==0)
        matica = matica_temp;
    end

    if((sum(validity) < 6) || (length(points) < 6))
        print('oprava')
        setPoints(tracker,matica)
        [points,validity] = tracker(obr{i});



    end

    for ants = 1:6
        if isempty(trajectories{ants})
            trajectories{ants} = points(ants,:);
        else
            pomocna = trajectories{ants};
            [~,ind] = min(sum(abs(repmat(pomocna(end,:),7-ants,1) - points),2));
            pomocna(end+1,:) = points(ind,:);
            points(ind,:) = [];
            trajectories{ants} = pomocna;
        end

    end

end

end

