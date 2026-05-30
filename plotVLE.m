function plotVLE(fuel, yeq, x, Teq)
close all


[a, b] = size(Teq);
hold on
marker = 'sod';
nmark = 15;

h = zeros(2*a);

for i = 1:a
Teqi = Teq(i, :);
[maximum, imax] = max(Teqi);
Teqi = Teqi(1:imax);
yeqi = yeq(i, 1:length(Teqi));

%% plot full data set
g = line([x(1:length(Teqi)) fliplr(yeqi)], [Teqi fliplr(Teqi)]);
set(g, 'Color', [0 0 0]);
set(g, 'LineWidth', 3);

%% plot markers on downselected data
sparsex = round(linspace(1, length(Teqi), nmark));
sparsey = round(linspace(1, length(Teqi), round(nmark/3)));
sparsey = sparsey(1:end-1);
h(i) = plot([x(sparsex) fliplr(yeqi(sparsey))], [Teqi(sparsex) fliplr(Teqi(sparsey))], [marker(i) 'k'], 'MarkerSize', 10, 'MarkerFaceColor', 'white');
end

legend(h(1:a), '3 MPa', '4.5 MPa', '6 MPa', 'Location', 'Best')

xlabel('Fuel mixture fraction', 'FontSize', 14, 'FontWeight', 'Bold');
ylabel('Temperature(K)', 'FontSize', 14, 'FontWeight', 'Bold');
title(fuel, 'FontSize', 14, 'FontWeight', 'Bold');

h = gca;
set(h, 'FontSize', 14)
set(h, 'FontWeight', 'Bold')
set(h, 'LineWidth', 2)
set(h, 'YGrid', 'on')
set(h, 'XGrid', 'on')

print(gcf, '-dpng', ['D:\Users\falgout.NET\Desktop\' fuel ' VLE'])

