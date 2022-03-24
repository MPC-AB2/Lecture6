function [trajectories] = cobolaci(path)
cd(path);

imagefiles = dir('*.jpg');
nfiles = length(imagefiles);
threshed = zeros(1024,1024);
point = [];
    Points = [];
    PointsCell = {};
PointsMat = [];
frame = 0;
for ii=1:nfiles
    frame = frame+1
    currentfilename = imagefiles(ii).name;
    I = rgb2gray(imread(currentfilename));

    level = 48;
    threshed(I>level) = 255;
    threshed(I<level) = 0;
    threshed(threshed == 255) = 1;
     threshed = logical(threshed);
     threshed = medfilt2( threshed, [7 7]);
     L = bwlabel(~threshed);
    count = 1;
%     Points = {};
    if ii == 1
         for index = 1:length(L)
              x = L(L==index);  
               if length(x) > 20
                    [y x] = find(L == index);
                    point = [round(median(x)) round(median(y))];
                    Points(count,1:2) = point;
                    PointsCell{count} = point;
                    count = count+1;
               end
         end
    else

         for index = 1:length(L)
              x = L(L==index);  
               if length(x) > 20 && count<=6
                    [y x] = find(L == index);
                    point = [round(median(x)) round(median(y))];
                    Points(count,1:2) = point;
                    count = count+1;
               end
         end

         if length(Points) == 6

                 if ii == 2
                     PointsOld = [PointsCell{1}; PointsCell{2} ;PointsCell{3}; PointsCell{4}; PointsCell{5}; PointsCell{6}];
                 else
                     PointsOld = [PointsCell{1}(ii-1,:); PointsCell{2}(ii-1,:);PointsCell{3}(ii-1,:); PointsCell{4}(ii-1,:); PointsCell{5}(ii-1,:); PointsCell{6}(ii-1,:)];
                 end

                        freePositions = [1:6];
                     for index2 = 1:6
                       s = sum(abs(Points(index2,:) - PointsOld(freePositions,:))');
                       
                       [val pos] = min((s));
                       
                      PointsCell{freePositions(pos)} = [PointsCell{freePositions(pos)}; Points(freePositions(pos),:)];
                      freePositions(pos) = [];
                     end
                     
         else
                    for index2 = 1:6
                      PointsCell{index2} = [PointsCell{index2}; Points(index2,:)];
                     end
         end


         end

    end
trajectories = PointsCell;




    
end