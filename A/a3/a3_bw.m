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
set(FigHandle, 'Position', [0, 0, 640, 480]);


%%%% FILES %%%%
full = csvread('bw_congestion.gr');
link_0_8 = csvread('bw_0.0_8.0_congestion.gr');
link_1_7 = csvread('bw_1.0_7.0_congestion.gr');
link_2_6 = csvread('bw_2.0_6.0_congestion.gr');

%%%% TIME %%%%
time_full = full ( :, 1); 
time_0_8 = link_0_8 ( :, 1); 
time_1_7 = link_1_7 ( :, 1); 
time_2_6 = link_2_6 ( :, 1); 

%%%% LOSS %%%%
bw_full = full ( :, 2); 
bw_0_8 = link_0_8 ( :, 2);
bw_1_7 = link_1_7 ( :, 2); 
bw_2_6 = link_2_6 ( :, 2);
bw_full = bw_full / ( 1 * 10^6) ;
bw_0_8 = bw_0_8 / ( 1 * 10^6) ;
bw_1_7 = bw_1_7 / ( 1 * 10^6) ;
bw_2_6 = bw_2_6 / ( 1 * 10^6) ;

colorf = [0 0 0];


plot(time_full,bw_full,'-','Color', colorf,'LineWidth',2);
hold on;
plot(time_0_8,bw_0_8,'s-','Color', color0);
hold on;
plot(time_1_7,bw_1_7,'d-','Color', color1);
hold on;
plot(time_2_6,bw_2_6,'p-','Color', color2);
hold on;

grid on;
ylim([0 max(bw_full*1.25)]);


l = legend('full bw','flow 0 -> 8 bw ( 5Mbps CBR ) :: Client 1 to Client 6' , 'flow 1 -> 7 bw ( 3Mbps CBR ) :: Client 2 to Client 5' , 'flow 2 -> 6 bw ( 3Mbps CBR ) :: Client 3 to Client 4' );


  




set(l,'FontSize',12);
ylabel('Bandwidth in Mbps');

xlabel('Time in sec.');
t = title({'Bandwidth analysis by flow and aggregated','on a simple FIFO queuing system'},'interpreter','latex')

set(t,'FontSize',30);
set(gca,'fontsize',12);
