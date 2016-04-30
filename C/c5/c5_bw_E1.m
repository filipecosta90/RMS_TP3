%% tcl link colors
%% $ns color 1 red
%% $ns color 2 green
%% $ns color 3 blue
%% $ns color 4 yellow -- swap by teal
%% $ns color 5 magenta
%% $ns color 6 brown


red = [ 255 0 0 ];
green = [ 0 255 0 ];
blue = [ 0 0 255 ];
%yellow = [ 255 255 0 ];

yellow = [ 0 128 128 ];

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
set(FigHandle, 'Position', [0, 0, 640, 640]);

cd('bw_E1');
%%%% FILES %%%%
full = csvread('bw.gr');
%CBR 1->6
link_0_8 = csvread('bw_0.0_8.0.gr');
%CBR 2->4
link_1_6 = csvread('bw_1.1_6.0.gr');
%FTP 2->5
link_1_7 = csvread('bw_1.0_7.0.gr');
%EXP(VOIP) 3->4

fnames = dir('bw_2.*_6.*.gr');
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
        b_w_elm = link_2_6_{K}(inner,2);
        b_w_elm = b_w_elm / ( 1 * 10^6);
        [I,J] = find(link_2_6==( link_2_6_{K}(inner,1) ));
        link_2_6(I,2)= link_2_6(I,2) + b_w_elm;
    end
end


    
%%%% TIME %%%%
time_full = full ( :, 1); 
time_0_8 = link_0_8 ( :, 1); 
time_1_6 = link_1_6 ( :, 1); 
time_1_7 = link_1_7 ( :, 1); 
time_2_6 = link_2_6 ( :, 1); 


%%%% BW %%%%
bw_full = full ( :, 2); 
bw_0_8 = link_0_8 ( :, 2);
bw_1_6 = link_1_6 ( :, 2); 
bw_1_7 = link_1_7 ( :, 2); 
bw_2_6 = link_2_6 ( :, 2); 

bw_full = bw_full / ( 1 * 10^6) ;
bw_0_8 = bw_0_8 / ( 1 * 10^6) ;
bw_1_6 = bw_1_6 / ( 1 * 10^6) ;
bw_1_7 = bw_1_7 / ( 1 * 10^6) ;

colorf = [0 0 0];

%% FULL 
plot(time_full,bw_full,'-','Color', colorf,'LineWidth',2);
hold on;

%% 0 -> 8 Red (Client 1 to 6) CBR

plot(time_0_8,bw_0_8,'s-','Color', color0);
hold on;

%% 1 -> 6 Red (Client 2 to 4) CBR

plot(time_1_6,bw_1_6,'d-','Color', color9);
hold on;

%% 1 -> 7 Red (Client 2 to 5) FTP

plot(time_1_7,bw_1_7,'d-','Color', color1);
hold on;
grid on;

%% 2 -> 6 Red (Client 3 to 4) VOIP

plot(time_2_6, bw_2_6,'p-','Color', color2);
hold on;
ylim([0 max(bw_full*1.4)]);

l = legend('full bw','flow 0 -> 8 bw ( 4Mbps CBR App ) :: Client 1 to Client 6' , 'flow 1 -> 6 bw ( 4Mbps CBR App ) :: Client 2 to Client 4 ','flow 1 -> 7 bw ( FTP Connection ) :: Client 2 to Client 5' , 'flow 2 -> 6 bw ( 30 VOIP Connections over UDP ) :: Client 3 to Client 4' );



set(l,'FontSize',12);
ylabel('Bandwidth in Mbps');

xlabel('Time in sec.');
t = title({'\textbf{Bandwidth analysis by flow and aggregated on the network:}','\textbf{Edge router: E1, core router: C0 implementing Differentiated Services.}', '\textbf{DiffServ. properties:}', 'Weighted Round Robin scheduling and RIO-C Active Queue Management,', '\textbf{Policy Table:}',    'Flow (0 to 8): trTCM policer, initial code point 10, CIR 1Mbps, CBS 5KB, PIR 3Mbps, PBS 5KB.','Flow (1 to 6): trTCM policer, initial code point 10, CIR 1Mbps, CBS 5KB, PIR 3Mbps, PBS 5KB.' 'Flow (1 to 7): TSW3CM policer, initial code point 7, CIR 1Mbps, PIR 3Mbps.' ,'Flow (2 to 6): Token Bucket policer, initial code  point 4, CIR 1Mbps, CBS 5KB.'},'interpreter','latex');

set(t,'FontSize',30);
set(gca,'fontsize',12);
