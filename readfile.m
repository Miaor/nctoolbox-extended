function readfile
%This .m file try to read datasets form GRB file and visualize them.
%please use command "setup_nctoolbox" to setpath before you run this file
%at first time
%By maomao Feb.16.2017
setup_nctoolbox%set path
[filename, pathname] = uigetfile('*.GRB', 'choose a GRB file'); %choose a GRB file from computer
if isequal(filename,0)    
   msgbox('you choose nothing');
else
   pathfile=fullfile(pathname, filename); %get file path  
   ds= ncdataset(pathfile);%redad datasets 
   disp('file info:')
   ds.netcdf %display file details

%plot graph
GPMData = ds.data(ds.variables{2});
GPMData = squeeze(GPMData);
Temp = ds.time('time', ds.data('time', 1));
lat = ds.data('lat');
lon = ds.data('lon');
 
surf(lon,lat,GPMData);
xlabel('lontitude')
ylabel('latitude')
zlabel('GPM')
shading interp;
title({datestr(Temp),'3d'}); 
colorbar;


%write data to excel
 name = {'lontitude','latitude','GPM'};
 xlswrite(strcat(filename,'.xlsx'), name,1,'A1')
 xlswrite(strcat(filename,'.xlsx'), lon,1,'A2')
 xlswrite(strcat(filename,'.xlsx'), lat,1,'B2')
 xlswrite(strcat(filename,'.xlsx'), GPMData,1,'C2')
 
 

msgbox('finished!');
end