function makefunc( area )
%MAKEMASK - Uses HCP data of the subject to make specific-area masks.

test_retest = 'test';
hcpFolder       = strcat('/vol/neuroecology-y/HCP_test_retest/',test_retest,'/');
masksFolder     = strcat('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/',test_retest,'/HCP_Masks/');
dirinfo = dir(hcpFolder);
dirinfo(~[dirinfo.isdir]) = [];  %remove non-directories
dirinfo_cell = struct2cell(dirinfo);
[~,n] = size(dirinfo_cell);
li=1;
subject_folder_list = zeros(45,1);
subject_folder_list = string(subject_folder_list);

for i = 1:n
    if length(dirinfo_cell{1,i})>2
            subject_folder_list(li)=strcat(dirinfo_cell{2,i},'/',dirinfo_cell{1,i});
            li=li+1;
    end
end

for i = 1:length(subject_folder_list)

surfFolder      = strcat(subject_folder_list(i),'/MNINonLinear/fsaverage_LR32k/');
atlasFolder     = strcat(subject_folder_list(i),'/MNINonLinear/fsaverage_LR32k/');
output = replace(subject_folder_list(i),hcpFolder,masksFolder);
outputFolder    = strcat(output,'/');
subjID = regexp(output, '\d+', 'match'); 

cd(surfFolder);
surf_R = gifti(char(strcat(subjID,'.R.pial.32k_fs_LR.surf.gii')));
surf_L = gifti(char(strcat(subjID,'.L.pial.32k_fs_LR.surf.gii')));

cd(atlasFolder)
atlas_R = gifti(char(strcat(subjID,'.R.BA.32k_fs_LR.label.gii')));
atlas_L = gifti(char(strcat(subjID,'.L.BA.32k_fs_LR.label.gii')));
atlas_aparc_R = gifti(char(strcat(subjID,'.R.aparc.32k_fs_LR.label.gii')));
atlas_aparc_L = gifti(char(strcat(subjID,'.L.aparc.32k_fs_LR.label.gii')));

mkdir(outputFolder);

cd(outputFolder);

    switch lower(area)

      case {'surf'}
        disp('Making parietal mask...')
        % Right hemisphere
        parietal.cdata = atlas_aparc_R.cdata;
        parietal.cdata(find(parietal.cdata(:,1)==0),:)=0;
        %figure
        %plot(surf_R,parietal);
        saveimgfile(parietal.cdata,'Surface_R.func.gii','R');
        clear parietal;

        % Left hemisphere
        parietal.cdata = atlas_aparc_L.cdata;
        parietal.cdata(find(parietal.cdata(:,1)==0),:)=0;        %figure
        %plot(surf_L,parietal);
        saveimgfile(parietal.cdata,'Surface_L.func.gii','L');
        clear parietal;
        disp('Done.')

      case {'v1'}
        disp('Making frontal mask...(including prefrontal)')
        % Right hemisphere
        frontal.cdata = atlas_R.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=10),:) = 0;
         %figure
         %plot(surf_R,frontal);
        saveimgfile(frontal.cdata,'V1_R.func.gii','R');
        clear frontal;

        % Left hemisphere
        frontal.cdata = atlas_L.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=10),:) = 0;
%         figure
%         plot(surf_L,frontal);
        saveimgfile(frontal.cdata,'V1_L.func.gii','L');
        clear frontal;
        disp('Done.')
      
      case {'v'}
        disp('Making frontal mask...(including prefrontal)')
        % Right hemisphere
        frontal.cdata = atlas_R.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=10 & frontal.cdata(:,1)~=11),:) = 0;
         %figure
         %plot(surf_R,frontal);
        saveimgfile(frontal.cdata,'V_R.func.gii','R');
        clear frontal;

        % Left hemisphere
        frontal.cdata = atlas_L.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=10 & frontal.cdata(:,1)~=11),:) = 0;
%         figure
%         plot(surf_L,frontal);
        saveimgfile(frontal.cdata,'V_L.func.gii','L');
        clear frontal;
        disp('Done.')
        
        
       case {'broca'}
        disp('Making frontal mask...(including prefrontal)')
        % Right hemisphere
        frontal.cdata = atlas_R.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=8 & frontal.cdata(:,1)~=9),:) = 0;
         %figure
         %plot(surf_R,frontal);
        saveimgfile(frontal.cdata,'Broca_R.func.gii','R');
        clear frontal;

        % Left hemisphere
        frontal.cdata = atlas_L.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=8 & frontal.cdata(:,1)~=9),:) = 0;
%         figure
%         plot(surf_L,frontal);
        saveimgfile(frontal.cdata,'Broca_L.func.gii','L');
        clear frontal;
        disp('Done.')
        
        case {'ba_44'}
        disp('Making frontal mask...(including prefrontal)')
        % Right hemisphere
        frontal.cdata = atlas_R.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=8),:) = 0;
         %figure
         %plot(surf_R,frontal);
        saveimgfile(frontal.cdata,'BA44_R.func.gii','R');
        clear frontal;

        % Left hemisphere
        frontal.cdata = atlas_L.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=8),:) = 0;
%         figure
%         plot(surf_L,frontal);
        saveimgfile(frontal.cdata,'BA44_L.func.gii','L');
        clear frontal;
        disp('Done.')
        
        case {'ba_45'}
        disp('Making frontal mask...(including prefrontal)')
        % Right hemisphere
        frontal.cdata = atlas_R.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=9),:) = 0;
         %figure
         %plot(surf_R,frontal);
        saveimgfile(frontal.cdata,'BA45_R.func.gii','R');
        clear frontal;

        % Left hemisphere
        frontal.cdata = atlas_L.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=9),:) = 0;
%         figure
%         plot(surf_L,frontal);
        saveimgfile(frontal.cdata,'BA45_L.func.gii','L');
        clear frontal;
        disp('Done.')
        
       case {'ba_4'}
        disp('Making frontal mask...(including prefrontal)')
        % Right hemisphere
        frontal.cdata = atlas_R.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=5 & frontal.cdata(:,1)~=6),:) = 0;
         %figure
         %plot(surf_R,frontal);
        saveimgfile(frontal.cdata,'BA_4_R.func.gii','R');
        clear frontal;

        % Left hemisphere
        frontal.cdata = atlas_L.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=5 & frontal.cdata(:,1)~=6),:) = 0;
%         figure
%         plot(surf_L,frontal);
        saveimgfile(frontal.cdata,'BA_4_L.func.gii','L');
        clear frontal;
        disp('Done.')
        
       case {'m1'}
        disp('Making frontal mask...(including prefrontal)')
        % Right hemisphere
        frontal.cdata = atlas_aparc_R.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=24),:) = 0;
         %figure
         %plot(surf_R,frontal);
        saveimgfile(frontal.cdata,'M1_R.func.gii','R');
        clear frontal;

        % Left hemisphere
        frontal.cdata = atlas_aparc_L.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=24),:) = 0;
%         figure
%         plot(surf_L,frontal);
        saveimgfile(frontal.cdata,'M1_L.func.gii','L');
        clear frontal;
        disp('Done.')
               
               

      otherwise
        %disp('Unknown brain region encountered. Please resubmit.')
        disp('Searching for the region in atlas keys...')
        areaIndex = strmatch(area, atlas_R.labels.name, 'exact');
        % areaIndex = find(strcmp(area, atlas_R.labels.name));
        if isempty(areaIndex)
            disp('Couldnot find the area. Please resubmit.')
        else
            disp('Region found in atlas. Proceeding to make func file...')
            key = areaIndex-1;

            % Right hemisphere
            areax.cdata = atlas_R.cdata;
            areax.cdata(find(areax.cdata(:,1)~=key),:)=0;
            figure
            plot(surf_R,areax);
            saveimgfile(areax.cdata,strcat(area,'_R'),'R');
            clear areax;

            % Left hemisphere
            areax.cdata = atlas_L.cdata;
            areax.cdata(find(areax.cdata(:,1)~=key),:)=0;
            figure
            plot(surf_L,areax);
            saveimgfile(areax.cdata,strcat(area,'_L'),'L');
            clear areax;
            disp('Done.');
end
    end
end
cd('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest')
end
