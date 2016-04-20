function paintswc(varargin)
swcfile=varargin{1};
if nargin>=2
    voltlist=varargin{2};
end
if nargin>=3
    voltlist_n=varargin{3};
end
%function [nodelist,linkfrom,linkto]=paintswc(swcfile,imgfile)
SWC=load(swcfile);
%draw in picture
% ori_img=imread(imgfile);
% img=zeros([size(ori_img),3]);
% img(:,:,1)=ori_img;img(:,:,2)=ori_img;img(:,:,3)=ori_img;
% for ni=1:size(SWC,1)
%     img(round(SWC(ni,4)),round(SWC(ni,3)),:)=[1,0,0];
% end

%draw in figure
figure;
title(swcfile);
hold on
for ni=1:size(SWC,1)
    plot(SWC(ni,3),-SWC(ni,4),'o');
    hold on 
    if nargin==1
        text(SWC(ni,3),-SWC(ni,4),mat2str(round(SWC(ni,6)*10)/10));
    elseif nargin==2
        text(SWC(ni,3),-SWC(ni,4),[mat2str(round(SWC(ni,6)*10)/10),' ',mat2str(round(voltlist(ni)*10)/10)]);
    elseif nargin==3
        text(SWC(ni,3),-SWC(ni,4),[mat2str(round(SWC(ni,6)*10)/10),' ',mat2str(round(voltlist(ni)*10)/10),' ',mat2str(round(voltlist_n(ni)*10)/10)]);
    end
    hold on 
    if ni>1
        linkto_id=SWC(ni,7);
        if linkto_id > 0
            line([SWC(ni,3),SWC(linkto_id,3)],[-SWC(ni,4),-SWC(linkto_id,4)]);
            diff0=round((SWC(ni,6)-SWC(linkto_id,6))*10)/10;
            if nargin>=2
            %    diffv1=round((voltlist(ni)-voltlist(linkto_id))*10)/10;
            %    text((SWC(ni,3)+SWC(linkto_id,3))/2,(-SWC(ni,4)-SWC(linkto_id,4))/2,[mat2str(diff0),',',mat2str(diffv1)],'color','red');
            elseif nargin==3
             %   diffv2=round((voltlist_n(ni)-voltlist_n(linkto_id))*10)/10;
             %   text((SWC(ni,3)+SWC(linkto_id,3))/2,(-SWC(ni,4)-SWC(linkto_id,4))/2,[mat2str(diff0),',',mat2str(diffv1),',',mat2str(diffv2)],'color','red');
            end
        end
    end
end
end