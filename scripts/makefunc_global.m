function makefunc_global( area )
%MAKEMASK - Uses HCP data of the subject to make specific-area masks.

atlasFolder     = '/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/global/';

cd(atlasFolder)
atlas_R = gifti(char(strcat(atlasFolder,'BA_atlas_1p_R.func.gii')));
atlas_L = gifti(char(strcat(atlasFolder,'BA_atlas_1p_L.func.gii')));
atlas_aparc_R = gifti(char(strcat(atlasFolder,'aparc_atlas_50p_R.func.gii')));
atlas_aparc_L = gifti(char(strcat(atlasFolder,'aparc_atlas_50p_L.func.gii')));


    switch lower(area)

      case {'surf'}
        disp('Making parietal mask...')
        % Right hemisphere
        parietal.cdata = atlas_R.cdata;
        parietal.cdata(:) = 1;
        %figure
        %plot(surf_R,parietal);
        saveimgfile(parietal.cdata,'Surface_R.func.gii','R');
        clear parietal;

        % Left hemisphere
        parietal.cdata = atlas_L.cdata;
        parietal.cdata(:) = 1;
        %figure
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
        frontal.cdata(find(frontal.cdata(:,1)~=4455)) = 0;
         %figure
         %plot(surf_R,frontal);
        saveimgfile(frontal.cdata,'Broca_1_R.func.gii','R');
        clear frontal;

        % Left hemisphere
        frontal.cdata = atlas_L.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=4455)) = 0;
%         figure
%         plot(surf_L,frontal);
        saveimgfile(frontal.cdata,'Broca_1_L.func.gii','L');
        clear frontal;
        disp('Done.')
        
        case {'insula'}
        disp('Making frontal mask...(including prefrontal)')
        % Right hemisphere
        frontal.cdata = atlas_aparc_R.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=35)) = 0;
         %figure
         %plot(surf_R,frontal);
        saveimgfile(frontal.cdata,'Insula_R.func.gii','R');
        clear frontal;

        % Left hemisphere
        frontal.cdata = atlas_aparc_L.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=35)) = 0;
%         figure
%         plot(surf_L,frontal);
        saveimgfile(frontal.cdata,'Insula_L.func.gii','L');
        clear frontal;
        disp('Done.')
        
        case {'temporal'}
        disp('Making frontal mask...(including prefrontal)')
        % Right hemisphere
        frontal.cdata = atlas_aparc_R.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=5012)) = 0;
         %figure
         %plot(surf_R,frontal);
        saveimgfile(frontal.cdata,'Temporal_R.func.gii','R');
        clear frontal;

        % Left hemisphere
        frontal.cdata = atlas_aparc_L.cdata;
        frontal.cdata(find(frontal.cdata(:,1)~=5012)) = 0;
%         figure
%         plot(surf_L,frontal);
        saveimgfile(frontal.cdata,'Temporal_L.func.gii','L');
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

cd('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest')
end
