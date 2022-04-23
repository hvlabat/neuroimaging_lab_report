%%
%% Local matlab startup configuration

%%% 1. Add main code path -> genpath = include subdirectories
addpath(genpath('C:\Users\hvlab\OneDrive\Documents\All Documents\Sheffield\Modules\neuroimaging_2\lab_1\LabClassOne\code\Run'));
addpath(genpath('C:\Users\hvlab\OneDrive\Documents\All Documents\Sheffield\Modules\neuroimaging_2\lab_2\lab_2_project\Code\teachingData'));
%%% 2. Choose where to start matlab 
cd('C:\Users\hvlab\OneDrive\Documents\All Documents\Sheffield\Modules\neuroimaging_2\lab_report_hugo\codework\Data'); %%% Change path to data on your local PC!

%%
% Plot overall haem data
load('haemContinuousData.mat');

figure;subplot(211);plot(tim,hbt(1,:),'g',tim,hbo(1,:),'r',tim,hbr(1,:),'b')
axis tight; set(gca,'xtick',[0:70:2100]); grid;
hold on;
title('Whisker Region OIS')

subplot(212);plot(tim,hbt(2,:),'g',tim,hbo(2,:),'r',tim,hbr(2,:),'b')
axis tight; set(gca,'xtick',[0:70:2100]); grid;
title('Motor Region OIS')

%%
%Load neural data and interact with it
load('whisker_neural_1point5Khz.mat');
size(data_raw)

figure(11);clf;plot(tim,data_raw(:,8)),set(gca,'xlim',[0 2200]); %plotting LFP from channel 8 -> in data_raw(:,8)

%Remove artefacts of stimulating whisker base stim duration 16s, @ 5Hz
data_proc=artegoContinuousData(data_raw, tim,stim_points,16,5);
figure(11); hold on;
plot(tim,data_proc(:,8));

%%
%Comparing LFP with haem data, side-by-side
load('haemContinuousData.mat');
figure;subplot(211);plot(tim,hbt(1,:),'g',tim,hbo(1,:),'r',tim,hbr(1,:),'b')
axis tight; set(gca,'xtick',[0:70:2100]); grid;
hold on;
title('Whisker Region OIS')

load('whisker_neural_1point5Khz.mat');
subplot(212);plot(tim,data_raw(:,8)),set(gca,'xlim',[0 2200]);
title('Whisker Region Electrode')

%% 
%Trail-averaged neural activity data - WHISKER
load('Neural_data_whisker.mat')
figure;imagesc(tim,[],FP1to15);colorbar; colormap jet
xlabel('Time');ylabel('Channel');
set(gca,'xlim',[-0.1 1]); % zooms to the first 5 stimuli (remember there are 80 stim in 16s)

set(gca,'xlim',[-0.01 0.05]); %focuses on first stimulus, channels 5-10 are the right depth to identify the barrel


%look at mean LFP across channels 5 to 10 -> mean of trials 1-15 in channels 5-10 
figure;plot(tim,mean(FP1to15(5:10,:),1));
set(gca,'xlim',[-3 20],'ylim', [-.0045 .0005]);
%Another group with smaller limits (-1 to +2)
figure;plot(tim(1,1:427603),mean(FP1to15(5:10,1:427603),1));
set(gca,'xlim',[-1 2],'ylim', [-.0045 .0005]);


%Doing the above, but for 15-24
%Trail-averaged neural activity data - WHISKER
load('Neural_data_whisker.mat')
figure;imagesc(tim,[],FP15to24);colorbar; colormap jet
xlabel('Time');ylabel('Channel');
set(gca,'xlim',[-0.1 1]); % zooms to the first 5 stimuli (remember there are 80 stim in 16s)

set(gca,'xlim',[-0.01 0.05]); %focuses on first stimulus, channels 5-10 are the right depth to identify the barrel

%look at mean LFP across channels 5 to 10 -> mean of trials 15-24 in channels 5-10 
figure;plot(tim,mean(FP15to24(5:10,:),1));
set(gca,'xlim',[-3 20],'ylim', [-.0045 .0005]);
%Another group with smaller limits (-1 to +2)
figure;plot(tim(1,1:427603),mean(FP15to24(5:10,1:427603),1));
set(gca,'xlim',[-1 2],'ylim', [-.0045 .0005]);


%%
% doing the same for motor data

%Trail-averaged neural activity data - MOTOR
%1-15
load('Neural_data_motor.mat')
figure;imagesc(tim,[],FP1to15);colorbar; colormap jet
xlabel('Time');ylabel('Channel');
set(gca,'xlim',[-0.1 1]); % zooms to the first 5 stimuli (remember there are 80 stim in 16s)

set(gca,'xlim',[-0.01 0.05]); %focuses on first stimulus, channels 5-10 are the right depth to identify the barrel


%look at mean LFP across channels 5 to 10 -> mean of trials 1-15 in channels 5-10 
figure;plot(tim(1,1:427603),mean(FP1to15(5:10,1:427603),1));
set(gca,'xlim',[-3 20],'ylim', [-.0045 .0005]);

%Another group with smaller limits (-1 to +2)
figure;plot(tim(1,1:427603),mean(FP1to15(5:10,1:427603),1));
set(gca,'xlim',[-1 2],'ylim', [-.0045 .0005]);



%15-25
figure;imagesc(tim,[],FP15to25);colorbar; colormap jet
xlabel('Time');ylabel('Channel');
set(gca,'xlim',[-0.1 1]); % zooms to the first 5 stimuli (remember there are 80 stim in 16s)

set(gca,'xlim',[-0.01 0.05]); %focuses on first stimulus, channels 5-10 are the right depth to identify the barrel


%look at mean LFP across channels 5 to 10 -> mean of trials 15-24 in channels 5-10 
figure;plot(tim(1,1:427603),mean(FP15to25(5:10,1:427603),1));
set(gca,'xlim',[-3 20],'ylim', [-.0045 .0005]);

%Another group with smaller limits (-1 to +2)
figure;plot(tim(1,1:427603),mean(FP15to25(5:10,1:427603),1));
set(gca,'xlim',[-1 2],'ylim', [-.0045 .0005]);

