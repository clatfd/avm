% DSAmainlabel=bwlabeln(DSA); %label connected components in binary image.
% props = regionprops(DSAmainlabel, 'Area');
% [~,maxareaindex]=max([props.Area]);
% DSAmain = ismember(DSAmainlabel,maxareaindex);  %find max area in each slice of images
%