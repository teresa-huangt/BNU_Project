%% plot regression line
function plot_regressionline(X,Y)
fsize=14;
% remove NaNs
indX = ~isnan(X); %0 if NaN, 1 if real
indY = ~isnan(Y);
indXY = indX.*indY; %0 if either X or Y == NaN;
ind = find(indXY==1);
X = X(ind);
Y = Y(ind);
% indicate correlation stats
[r,p]=corrcoef(Y,X); 
R=num2str(r(1,2));
P=num2str(p(1,2));
l = min([length(R),length(P),6]);
txt=text(0.75*max(X),0.75*max(Y), ['r=' R(1:l); 'p=' P(1:l)], 'FontSize', fsize);


% plot fitted regression line
if p(1,2)<0.05
stats = regstats(Y,X,'linear');
x = [min(X), max(X)];
y = stats.beta(1)+stats.beta(2)*x;
plot(x,y,'k--', 'linewidth', 1.8);
end

set(gca,'Box', 'off', 'LineWidth', 0.5, 'FontName', 'Arial', 'FontSize', fsize);
end