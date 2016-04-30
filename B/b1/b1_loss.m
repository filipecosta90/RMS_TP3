

%% tcl link colors
%% $ns color 1 red
%% $ns color 2 green
%% $ns color 3 blue
%% $ns color 4 yellow
%% $ns color 5 magenta
%% $ns color 6 brown


red = [ 255 0 0 ];
green = [ 0 255 0 ];
blue = [ 0 0 255 ];
yellow = [ 255 255 0 ];
magenta = [ 255 0 255 ];
brown = [ 165 42 42 ];
orange = [ 255 165 0 ];

color0 = red/255;
color1 = green/255;
color2 = blue/255;
color6 = yellow/255;
color7 = magenta/255;
color8 = brown/255;

color9 = orange/255;

FigHandle = figure;
set(FigHandle, 'Position', [0, 0, 640, 480]);

%%%% FILES %%%%

cd('loss');

full = csvread('loss.gr');
link_0_8 = csvread('loss_0.0_8.0.gr');
link_1_7 = csvread('loss_1.0_7.0.gr');
link_1_6 = csvread('loss_1.1_6.60.gr');
link_7_1 = csvread('loss_7.0_1.0.gr');
link_8_0 = csvread('loss_8.1_0.1.gr');

fnames = dir('loss_2.*_6.*.gr');

numfids = length(fnames);
link_2_6_ = cell(1,numfids);

number_rows = 0;
time_2_6 = [];

%% get the different times first
for K = 1:numfids
    link_2_6_{K} = csvread(fnames(K).name);
    time_2_6_{K} = link_2_6_{K} ( :,1);
    [current_rows,current_cols] = size(time_2_6_{K});
    if current_rows > number_rows
        number_rows = current_rows;
    end
    time_2_6 = [ time_2_6 ; time_2_6_{K} ];
    time_2_6 = unique( time_2_6 );
end

link_2_6 = zeros(number_rows,2);
link_2_6(:,1) = time_2_6;

for K = 1:numfids
    [row,col]=size (link_2_6_{K});
    for inner = 1:row
        loss_elm = link_2_6_{K}(inner,2);
        [I,J] = find(link_2_6==( link_2_6_{K}(inner,1) ));
        link_2_6(I,2)= link_2_6(I,2) + loss_elm;
    end
end




fnames = dir('loss_6.*_2.*.gr');

numfids = length(fnames);
link_6_2_ = cell(1,numfids);

number_rows = 0;
time_6_2 = [];

%% get the different times first
for K = 1:numfids
    link_6_2_{K} = csvread(fnames(K).name);
    time_6_2_{K} = link_6_2_{K} ( :,1);
    [current_rows,current_cols] = size(time_6_2_{K});
    if current_rows > number_rows
        number_rows = current_rows;
    end
    time_6_2 = [ time_6_2 ; time_6_2_{K} ];
    time_6_2 = unique( time_6_2 );
end

link_6_2 = zeros(number_rows,2);
link_6_2(:,1) = time_6_2;

for K = 1:numfids
    [row,col]=size (link_6_2_{K});
    for inner = 1:row
        loss_elm = link_6_2_{K}(inner,2);
        [I,J] = find(link_6_2==( link_6_2_{K}(inner,1) ));
        link_6_2(I,2)= link_6_2(I,2) + loss_elm;
    end
end


%%%% TIME %%%%
time_full = full ( :, 1); 
time_0_8 = link_0_8( :, 1); 
time_1_6 = link_1_6 ( :, 1); 
time_1_7 = link_1_7 ( :, 1); 
time_7_1 = link_7_1 ( :, 1); 
time_8_0 = link_8_0 ( :, 1); 

%%%% LOSS %%%%
loss_full = full ( :, 2); 
loss_0_8 = link_0_8 ( :, 2); 
loss_1_6 = link_1_6 ( :, 2); 
loss_1_7 = link_1_7 ( :, 2); 
loss_2_6 = link_2_6 ( :, 2); 
loss_7_1 = link_7_1 ( :, 2); 
loss_8_0 = link_8_0 ( :, 2);

colorf = [0 0 0];

plot(time_full,loss_full,'-','Color', colorf,'LineWidth',2);
hold on;
plot(time_0_8,loss_0_8,'s-','Color', color0);
hold on;
plot(time_1_6,loss_1_6,'d-','Color', color9);
hold on;
plot(time_1_7,loss_1_7,'d-','Color', color1);
hold on;
plot(link_2_6(:,1), link_2_6(:,2),'p-','Color', color2);
hold on;
plot(link_6_2(:,1), link_6_2(:,2),'p-','Color', color6);
hold on;
plot(time_7_1,loss_7_1,'h-','Color', color7);
hold on;
plot(time_8_0,loss_8_0,'o-','Color', color8);
hold on;
grid on;
ylim([0 max(loss_full*1.50)]);



l = legend('full loss','flow 0 -> 8 #packet loss ( 3Mb CBR App ) :: Client 1 to Client 6', 'flow 1 -> 6 #packet loss ( FTP connection ) :: Client 2 to Client 4',  'flow 1 -> 7 #packet loss ( FTP connection ) :: Client 2 to Client 5' , 'flow 2 -> 6 #packet loss ( VOIP connection over UDP ) :: Client 3 to Client 4', 'flow 6 -> 2 #packet loss ( VOIP connection over UDP ) :: Client 4 to Client 3',  'flow 7 -> 1 #packet loss ( FTP connection ) :: Client 5 to Client 2', 'flow 8 -> 0 #packet loss ( 3Mb CBR App ) :: Client 6 to Client 1');




set(l,'FontSize',12);
ylabel('# of packets lost');

xlabel('Time in sec.');
t = title({'Packet loss evolution by flow and aggregated','on a simple FIFO queuing system'},'interpreter','latex')

set(t,'FontSize',30);
set(gca,'fontsize',12);
