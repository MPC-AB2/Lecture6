function trajectories = ToNebudeFungovat(cesta) 

cesta_pom = cesta + "\*.jpg";

files = dir(cesta_pom);
n = length(files);  
for i=1:n
   soubor = [cesta '\' files(i).name];
   obr = imread(soubor);
   mravenci_all{i} = obr;
end


im=rgb2gray(im2double(mravenci_all{1,1}));
T = 0.11;
im = imbinarize(im,T);
im=1-im;
im=bwareaopen(im, 120);

trajectories = cell(1,6);
stredy = struct2cell(regionprops(im,'centroid'));
for i=1:6
    pozice(i,:)=stredy{1,i};
    trajectories{1,i}  = [trajectories{1,i};pozice(i,:)];
end

pointTracker = vision.PointTracker;
pointTracker = vision.PointTracker('NumPyramidLevels',4,'BlockSize',[19 19],'MaxIterations',10);
initialize(pointTracker,pozice,mravenci_all{1,1});   %initialize(pointTracker,points,I)



for k=2:n
    pt=pointTracker(mravenci_all{1,k}); % pozice centroidu v daném snímku
    
    for i = 1:length(pt)
      trajectories{1,i}  = [trajectories{1,i};pt(i,:)];
    end
end

% [errorTracking] = EvaluationAnts (trajectories)

end
%% trajektorie




