%calculate the mask of outside bone
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

n=length(FileFullName);
for i=1:n
    I=dicomread(FileFullName{i});
    metadata=dicominfo(FileFullName{i});
    serialno=metadata.InstanceNumber;
    %
    if serialno<10
        ii=['00',int2str(serialno)];
    elseif serialno<100
        ii=['0',int2str(serialno)];
    else
        ii=int2str(serialno);
    end
    Inew = imadjust(I, stretchlim(I), []);
    imwrite(Inew,['mra_stretch/out',ii,'.tiff']);
    imwrite(I,['mra_orig/out',ii,'.tiff']);
end