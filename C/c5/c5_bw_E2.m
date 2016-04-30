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

cd('bw_E2');
%%%% FILES %%%%
full = csvread('bw.gr');

%FTP Client 4 -> Client 2
link_6_1 = csvread('bw_6.61_1.2.gr');

%CBR Client 5 -> Client 2
link_7_1 = csvread('bw_7.1_1.3.gr');

%CBR Client 6 -> Client 1
link_8_0 = csvread('bw_8.1_0.1.gr');

%EXP(VOIP) 4->3
fnames = dir('bw_6.*_2.*.gr');
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
time_6_1 = link_6_1 ( :, 1); 
time_6_2 = link_2_6 ( :, 1); 
time_7_1 = link_7_1 ( :, 1); 
time_8_0 = link_8_0 ( :, 1); 


%%%% BW %%%%
bw_full = full ( :, 2); 
bw_6_1 = link_6_1 ( :, 2); 
bw_6_2 = link_2_6 ( :, 2); 
bw_7_1 = link_7_1 ( :, 2); 
bw_8_0 = link_8_0 ( :, 2);

bw_full = bw_full / ( 1 * 10^6) ;
bw_6_1 = bw_6_1 / ( 1 * 10^6) ;
bw_7_1 = bw_7_1 / ( 1 * 10^6) ;
bw_8_0 = bw_8_0 / ( 1 * 10^6) ;


colorf = [0 0 0];

%% FULL 
plot(time_full,bw_full,'-','Color', colorf,'LineWidth',2);
hold on;

%% 6 -> 1  (Client 4 to Cliente 2 ) FTP
plot(time_6_1,bw_6_1,'*-','Color', color9);
hold on;

%% 6 -> 2  (Client 4 to Cliente 3 ) VOIP
plot(time_6_2,bw_6_2,'*-','Color', color6);
hold on;

%% 7 -> 1  (Client 5 to Cliente 2 ) CBR starting at 10s
plot(time_7_1,bw_7_1,'h-','Color', color7);
hold on;

%% 8 -> 0  (Client 6 to Cliente 1 ) CBR starting at 10s
plot(time_8_0,bw_8_0,'o-','Color', color8);
hold on;

grid on;

ylim([0 max(bw_full*1.4)]);

l = legend('full bw','flow 6 -> 1 bw ( FTP Connection ) :: Client 4 to Client 2' , 'flow 6 -> 2 bw ( VOIP Connection over UDP ) :: Client 4 to Client 3','flow 7 -> 1 bw ( 4Mbps CBR App )  :: Client 5 to Client 2' , 'flow 8 -> 0 bw ( 4Mbps CBR App )  :: Client 6 to Client 1' );



set(l,'FontSize',12);
ylabel('Bandwidth in Mbps');

xlabel('Time in sec.');
t = title({'\textbf{Bandwidth analysis by flow and aggregated on the network:}','\textbf{Edge router: E2, core router: C0 implementing Differentiated Services.}', '\textbf{DiffServ. properties:}', 'Weighted Round Robin scheduling and RIO-C Active Queue Management,', '\textbf{Policy Table:}',   'Flow (6 to 1): TSW3CM policer, initial code point 7, CIR 1Mbps, PIR 3Mbps.', 'Flow (6 to 2): Token Bucket policer, initial code  point 4, CIR 1Mbps, CBS 5KB.','Flow (7 to 1): trTCM policer, initial code point 10, CIR 1Mbps, CBS 5KB, PIR 3Mbps, PBS 5KB.', 'Flow (8 to 0): trTCM policer, initial code point 10, CIR 1Mbps, CBS 5KB, PIR 3Mbps, PBS 5KB.'},'interpreter','latex');

set(t,'FontSize',30);
set(gca,'fontsize',12);
