function [totbranch,volbranch,direction]=calbranch(nodelist,branchlist)
    totbranch=[];
    volbranch=[];
    direction=[];
    for bi=1:size(branchlist,2)
        br=branchlist{bi};
        br_start=br(1);
        br_second=br(2);
        br_end=br(end);
        direct_dis=pdist2(nodelist(br_start,2:3),nodelist(br_end,2:3));
        point_dis=0;
        curvol=0;
        for brbi=1:size(br,2)-1
            point_dis=point_dis+pdist2(nodelist(br(brbi),2:3),nodelist(br(brbi+1),2:3));
            curvol=curvol+point_dis*(nodelist(br(brbi),4)+nodelist(br(brbi+1),4))/2;
        end
        xdir=nodelist(br_second,2)-nodelist(br_start,2);
        ydir=nodelist(br_start,3)-nodelist(br_second,3);
        curdirection=atan(ydir/xdir)/pi*180;
        if xdir<0
            curdirection=curdirection+180;
        end
        totbranch=[totbranch,point_dis/direct_dis];
        volbranch=[volbranch,curvol];
        direction=[direction,curdirection];
    end
end