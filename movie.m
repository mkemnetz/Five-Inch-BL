close all;

% for i = 1:500
% %     figure(1); 
% %     surf(x_Final_r{i}, y_Final_r{i}, phase_Final_r{i}, 'EdgeColor', 'none'); 
% %     colormap jet; 
% %     view(2); 
% %     drawnow; 
% %     
% %     figure(2); 
% %     surf(x_Final{i}, y_Final{i}, phase_Final{i}, 'EdgeColor', 'none'); 
% %     colormap jet; 
% %     view(2); 
% %     drawnow; 
% 
%     figure(1); 
%     surf(POD_Modes(:,:,i), 'EdgeColor', 'none');
%     colormap jet; 
%     view(2); 
%     drawnow; 
% 
%     
%     pause(0.25); 
% end

%%
loops = 500;
Mov(loops) = struct('cdata',[],'colormap',[]);

% test
for iframe=1:loops

    surf(x_Final_r{iframe},y_Final_r{iframe},phase_Final_r{iframe},'edgecolor','none')
    shading interp;
    colormap jet;
    box off;
    set(gcf, 'color', 'w');   

%     axis equal;
    title(['WF(x, y), Frame # ' num2str(iframe)]);


    %You could use something like this to change the view
    %    count = count+1;
    %    view(-count,45)
    %    
    %Or zoom in and out?
    %zoom(2*cos(i/25) - 0.2)

    %This is the stuff that makes the surface pretty, need to play with it
    %    lightangle(-45,50)
    %    h.FaceLighting = 'gouraud';
    %    h.AmbientStrength = 0.50;
    %    h.DiffuseStrength = 0.875;
    %    h.SpecularStrength = 0.05;
    %    h.SpecularExponent = 25;
    %    h.BackFaceLighting = 'unlit';
    view(2)
%     lightangle(-45,30)
    %     h.FaceLighting = 'gouraud';
    %     h.AmbientStrength = 1;
    %     h.DiffuseStrength = 1;
    %     h.SpecularStrength = 1;
    %     h.SpecularExponent = 25;
    %     h.BackFaceLighting = 'unlit';

    Mov(iframe)=getframe(gcf);

   
end

filelead = 'test';
movie2avi(Mov,['Movie',filelead,'.avi'],'fps',10)


