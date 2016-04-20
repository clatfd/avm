function [totbranch,volbranch]=calbranch(nodelist,branchlist)
    totbranch=[];
    volbranch=[];
    for bi=1:size(branchlist,2)
        br=branchlist{bi};
        br_start=br(1);
        br_end=br(end);
        direct_dis=pdist2(nodelist(br_start,2:3),nodelist(br_end,2:3));
        point_dis=0;
        curvol=0;
        for brbi=1:size(br,2)-1
            point_dis=point_dis+pdist2(nodelist(br(brbi),2:3),nodelist(br(brbi+1),2:3));
            curvol=curvol+point_dis*(nodelist(br(brbi),4)+nodelist(br(brbi+1),4))/2;
        end
        totbranch=[totbranch,point_dis/direct_dis];
        volbranch=[volbranch,curvol];
    end
end