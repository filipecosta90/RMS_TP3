

%%% Random Early Detection (RED) 


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
full = csvread('loss_RED.gr');
link_0_8 = csvread('loss_0.0_8.0_RED.gr');
link_1_7 = csvread('loss_1.0_7.0_RED.gr');
link_2_6 = csvread('loss_2.0_6.0_RED.gr');
link_6_2 = csvread('loss_6.1_2.1_RED.gr');
link_7_1 = csvread('loss_7.1_1.1_RED.gr');
link_8_0 = csvread('loss_8.1_0.1_RED.gr');

%%%% TIME %%%%
time_full = full ( :, 1); 
time_0_8 = link_0_8 ( :, 1); 
time_1_7 = link_1_7 ( :, 1); 
time_2_6 = link_2_6 ( :, 1); 
time_6_2 = link_6_2 ( :, 1); 
time_7_1 = link_7_1 ( :, 1); 
time_8_0 = link_8_0 ( :, 1); 

%%%% LOSS %%%%
loss_full = full ( :, 2); 
loss_0_8 = link_0_8 ( :, 2);
loss_1_7 = link_1_7 ( :, 2); 
loss_2_6 = link_2_6 ( :, 2); 
loss_6_2 = link_6_2 ( :, 2);
loss_7_1 = link_7_1 ( :, 2); 
loss_8_0 = link_8_0 ( :, 2);


colorf = [0 0 0];

plot(time_full,loss_full,'-','Color', colorf,'LineWidth',2);

hold on;
plot(time_0_8,loss_0_8,'s-','Color', color0);
hold on;
plot(time_1_7,loss_1_7,'d-','Color', color1);
hold on;
plot(time_2_6,loss_2_6,'p-','Color', color2);
hold on;
plot(time_6_2,loss_6_2,'*-','Color', color6);
hold on;
plot(time_7_1,loss_7_1,'h-','Color', color7);
hold on;
plot(time_8_0,loss_8_0,'o-','Color', color8);
hold on;

grid on;
ylim([0 max(loss_full*1.50)]);

l = legend('full loss','flow 0 -> 8 #packet loss ( 3Mbps CBR App )  :: Client 1 to Client 6' ,'flow 1 -> 7 #packet loss ( 3Mbps CBR App )  :: Client 2 to Client 5' ,  'flow 2 -> 6 #packet loss ( 3Mbps CBR App )  :: Client 3 to Client 4', 'flow 6 -> 2 #packet loss ( 3Mbps CBR App )  :: Client 4 to Client 3',  'flow 7 -> 1 #packet loss ( 3Mbps CBR App )  :: Client 5 to Client 2' ,  'flow 8 -> 0 #packet loss ( 3Mbps CBR App )  :: Client 6 to Client 1');



  




set(l,'FontSize',12);
ylabel('# of packets lost');

xlabel('Time in sec.');
t = title({'Packet loss evolution by flow and aggregated','using Random Early Detection Gateways for Congestion Avoidance'},'interpreter','latex')

set(t,'FontSize',30);
set(gca,'fontsize',12);
