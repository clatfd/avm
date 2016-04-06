function [MR,DSA]=readseg()
MR=squeeze(dicomread('MRA_SEG_Objects_1/SEG_0.dcm'));
DSA=squeeze(dicomread('DSA_SEG_Objects_2/SEG_0.dcm'));
end