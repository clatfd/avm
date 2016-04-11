function [MR,DSA]=find_vessel()
geshi={'*.dcm','Dicom image (*.dcm)';...
       '*.bmp','Bitmap image (*.bmp)';...
       '*.jpg','JPEG image (*.jpg)';...
       '*.*','All Files (*.*)'};
[FileName FilePath]=uigetfile(geshi,'Load MR files','*.dcm','MultiSelect','on');
if ~isequal([FileName,FilePath],[0,0]);
    FileFullName=strcat(FilePath,FileName);
    if  ~ischar(FileFullName)
        FileFullName=FileFullName([2:end 1])';
    end
else
    return;
end
MRo=[];
MR=[];
n=length(FileFullName);
for i=1:n
    I=dicomread(FileFullName{i});
    metadata=dicominfo(FileFullName{i});
    serialno=metadata.InstanceNumber;
    %I=rgb2gray(I);
    %
    MRo(:,:,serialno)=I;
    MR(:,:,serialno)=im2bw(imadjust(mat2gray(I),[],[]));
end

%calculate the mask of outside bone
geshi={'*.dcm','Dicom image (*.dcm)';...
       '*.bmp','Bitmap image (*.bmp)';...
       '*.jpg','JPEG image (*.jpg)';...
       '*.*','All Files (*.*)'};
[FileName FilePath]=uigetfile(geshi,'Load DSA files','*.dcm','MultiSelect','on');
if ~isequal([FileName,FilePath],[0,0]);
    FileFullName=strcat(FilePath,FileName);
    if  ~ischar(FileFullName)
        FileFullName=FileFullName([2:end 1])';
    end
else
    return;
end
DSAo=[];
DSA=[];
n=length(FileFullName);
for i=1:n
    I=dicomread(FileFullName{i});
    metadata=dicominfo(FileFullName{i});
    serialno=metadata.InstanceNumber;
    %I=rgb2gray(I);
    %
    DSAo(:,:,serialno)=I;
    DSA(:,:,serialno)=im2bw(imadjust(mat2gray(I),[],[]));
end
end