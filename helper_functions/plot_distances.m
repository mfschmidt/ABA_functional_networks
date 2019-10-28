function [median_real,median_rand,medians_rand,X_rand] = plot_distances(ind,ind_rand,D);
% Use this function to plot average distances of the real vs null networks
% as in Figure 1 of the 2017 reply by Richiardi

% Labels generated by command labels=unique(dat(2:end,13)), and removing
% 'Z_restOfBrain'
labels={'Auditory','LECN','Language','Precuneus','RECN','Salience','Sensorimotor',...
    'Visuospatial','dDMN','high_Visual','post_Salience','prim_Visual','vDMN'};

[X_real,G_real]=return_XG(ind,D);

% Convert G_real to cell array for the boxplot
grouping=cell(size(G_real));
labels_num=unique(G_real);
for i=1:length(labels_num)
    ind=find(G_real==labels_num(i));
    for ii=1:length(ind)
        grouping{[ind(ii)]}=labels{i};
    end
end

% Create vector for the distances from the null networks
X_rand=[]; G_rand=[];
for n=1:length(ind_rand)
    [X_tmp,G_tmp]=return_XG(ind_rand(n),D);
    X_rand=[X_rand; X_tmp];
    G_rand=[G_rand; G_tmp];
    medians_rand(n,1)=median(X_tmp);
end

% comment out below if don't need the plots
subplot(2,1,1);
boxplot(X_real,grouping);
ylabel('Edge distance (mm)')
title('Resting state fMRI networks')

subplot(2,1,2);
boxplot(X_rand,G_rand);
ylabel('Edge distance (mm)')
title('Simulated networks')
% 
% disp('median distance of the real W')
median_real=median(X_real);
% 
% disp('median distance of the null W')
median_rand=median(X_rand);