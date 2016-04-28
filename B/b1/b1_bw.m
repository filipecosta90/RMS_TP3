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

cd('bw');
%%%% FILES %%%%
full = csvread('bw.gr');
link_0_8 = csvread('bw_0.0_8.0.gr');
link_1_7 = csvread('bw_1.0_7.0.gr');
link_1_6 = csvread('bw_1.1_6.60.gr');

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
time_1_7 = link_1_7 ( :, 1); 
time_1_6 = link_1_6 ( :, 1); 


%%%% BW %%%%
bw_full = full ( :, 2); 
bw_0_8 = link_0_8 ( :, 2);
bw_1_7 = link_1_7 ( :, 2); 
bw_1_6 = link_1_6 ( :, 2); 

bw_full = bw_full / ( 1 * 10^6) ;
bw_0_8 = bw_0_8 / ( 1 * 10^6) ;
bw_1_7 = bw_1_7 / ( 1 * 10^6) ;
bw_1_6 = bw_1_6 / ( 1 * 10^6) ;

colorf = [0 0 0];


plot(time_full,bw_full,'-','Color', colorf,'LineWidth',2);
hold on;

%% 0 -> 8 Red (Client 1 to 6)
%% CBR
plot(time_0_8,bw_0_8,'s-','Color', color0);
hold on;

%% 1 -> 6 Red (Client 2 to 4)
%% FTP
plot(time_1_6,bw_1_6,'d-','Color', color9);
hold on;

%% 1 -> 7 Red (Client 2 to 5)
%% FTP
plot(time_1_7,bw_1_7,'d-','Color', color1);
hold on;

%% 2 -> 6 Red (Client 3 to 4)
%% UDP
plot(link_2_6(:,1), link_2_6(:,2),'p-','Color', color2);
hold on;
ylim([0 max(bw_full*1.35)]);


l = legend('full bw','flow 0 -> 8 bw ( 3Mb CBR App ) :: Client 1 to Client 6' , 'flow 1 -> 6 bw ( FTP connection ) :: Client 2 to Client 4' , 'flow 1 -> 7 bw ( FTP connection ) :: Client 2 to Client 5' , 'flow 2 -> 6 bw ( VOIP connection over UDP ) :: Client 3 to Client 4' );


  




set(l,'FontSize',12);
ylabel('Bandwidth in Mbps');

xlabel('Time in sec.');
t = title({'Bandwidth analysis by flow and aggregated','on a simple FIFO queuing system'},'interpreter','latex')

set(t,'FontSize',30);
set(gca,'fontsize',12);
