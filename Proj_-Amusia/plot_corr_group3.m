function [h] = plot_corr_group3(X,Y,type, x_label, y_label, title_text, fsize) %symbolspec
% [h,ps] = plot_corr(X,Y,symbolspec, x_label, y_label, title_text, fsize)
% plot correlation of X and Y, return handle of the current axis
% Yuxuan Zhang

% if nargin < 3
%     symbolspec ='o';
% end

if nargin < 4
    x_label = [];
end

if nargin < 5
    y_label = [];
end

if nargin < 6
    title_text = [];
end

if nargin < 7
    fsize = 14;
end

switch type
    case 'g1'
        plt=plot(X,Y, 's','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);
    case 'g2'
        plt=plot(X,Y, 'v','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);
    case 'g3'
         plt=plot(X,Y, 'o','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);
end
        
% add labels
if nargin>3
xlabel(x_label, 'fontsize', fsize);
ylabel(y_label, 'fontsize', fsize);
elseif nargin > 5
title(title_text, 'fontsize', fsize);
end
% ps = p(1,2);
h.ax=gca;
h.plt = plt;
% h.txt = txt; 
end