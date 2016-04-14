FigHandle = figure;
set(FigHandle, 'Position', [0, 0, 640, 480]);

%%%% FILES %%%%
full = csvread('bw.gr');
link_0_8 = csvread('bw_0.0_8.0.gr');
link_1_7 = csvread('bw_1.0_7.0.gr');
link_2_6 = csvread('bw_2.0_6.0.gr');

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

bg = [1 1 1; 0 0 0];
colors = distinguishable_colors(5,bg);

plot(time_full,bw_full,'ro-','Color', colors(1,:));
hold on;
plot(time_0_8,bw_0_8,'rx-','Color', colors(5,:));
hold on;
plot(time_1_7,bw_1_7,'r+-','Color', colors(2,:));
hold on;
plot(time_2_6,bw_2_6,'r*-','Color', colors(3,:));
hold on;


l = legend('full bw','flow 0 -> 8 bw' , 'flow 1 -> 7 bw' , 'flow 2 -> 6 bw' );


  




set(l,'FontSize',12);
ylabel('Bandwidth in Mbps');

xlabel('Time in sec.');
t = title({'Bandwidth analysis by flow and aggregated','on a simple FIFO queuing system'},'interpreter','latex')

set(t,'FontSize',30);
set(gca,'fontsize',12);
