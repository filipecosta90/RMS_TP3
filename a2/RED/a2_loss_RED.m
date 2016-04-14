%%% Random Early Detection (RED) 

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


bg = [1 1 1; 0 0 0];
colors = distinguishable_colors(7,bg);

plot(time_full,loss_full,'ro-','Color', colors(1,:));
hold on;
plot(time_0_8,loss_0_8,'r+-','Color', colors(2,:));
hold on;
plot(time_1_7,loss_1_7,'r+-','Color', colors(3,:));
hold on;
plot(time_2_6,loss_2_6,'r*-','Color', colors(4,:));
hold on;
plot(time_6_2,loss_6_2,'r*-','Color', colors(5,:));
hold on;
plot(time_7_1,loss_7_1,'rx-','Color', colors(6,:));
hold on;
plot(time_8_0,loss_8_0,'rx-','Color', colors(7,:));
hold on;
grid on;



l = legend('full loss RED', 'flow 0 -> 8 loss RED' , 'flow 1 -> 7 loss RED' , 'flow 2 -> 6 loss RED',  'flow 6 -> 2 loss RED', 'flow 7 -> 1 loss RED', 'flow 8 -> 0 loss RED');


  




set(l,'FontSize',12);
ylabel('# of packets lost');

xlabel('Time in sec.');
t = title({'Packet loss evolution by flow and aggregated','using Random Early Detection Gateways for Congestion Avoidance'},'interpreter','latex')

set(t,'FontSize',30);
set(gca,'fontsize',12);
