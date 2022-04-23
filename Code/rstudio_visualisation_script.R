#load necessary libraries
library(tidyverse)
library(here)

#load data into data frame
df <- data.frame(read.csv(here("Data","LFP_HBT_trial_means.csv")))

#tidy up table to be code-friendly
df <- df[-1,]
rownames(df) <- c(1:30)
colnames(df) <- c("trial","whisk_hbt","motor_hbt","whisk_lfp","motor_lfp")
df <- data.frame(lapply(df,as.numeric))

#group data of whisker Hbt and lfp for synchronised and desync data
whisk_hbt_sync <- df$whisk_hbt[c(1:14)] #data for hbt 1-14
whisk_lfp_sync <- df$whisk_lfp[c(1:14)] #data of lfp 1-14

whisk_hbt_desync <- df$whisk_hbt[c(15:25)] #data of hbt 15-25
whisk_lfp_desync <- df$whisk_lfp[c(15:25)] #data of lfp 15-25


#as above, but for motor data
motor_hbt_sync <- df$motor_hbt[c(1:14)] #data for hbt 1-14
motor_lfp_sync <- df$motor_lfp[c(1:14)] #data of lfp 1-14

motor_hbt_desync <- df$motor_hbt[c(15:25)] #data of hbt 15-25
motor_lfp_desync <- df$motor_lfp[c(15:25)] #data of lfp 15-25


#running t-test to compare lfp of trials 1-14 and 15-25
inter_states_lfp <- t.test(x=whisk_lfp_sync,y=whisk_lfp_desync)

#as above, but for Hbt
inter_states_hbt <- t.test(x=whisk_hbt_sync,y=whisk_hbt_desync)

#as above, but comparing lfp between motor and whisker electrodes
inter_elect_lfp <- t.test(x=motor_lfp_sync,y=motor_lfp_desync)

#as above, but comparing Hbt between motor and whisker
inter_elect_hbt <- t.test(x=motor_hbt_sync,y=motor_hbt_desync)





#comparing both sets of hbt and lfp motor data
#For motor lfp
mean_lfp <- mean(df$motor_lfp)
mean_lfp[2] <- sd(df$motor_lfp)

mean_sync_lfp <- mean(df$motor_lfp[c(1:14)])
mean_sync_lfp[2] <- sd(df$motor_lfp[c(1:14)])

mean_desync_lfp <- mean(df$motor_lfp[c(15:25)])
mean_desync_lfp[2] <- sd(df$motor_lfp[c(15:25)])

avg_motor_lfp <- data.frame(rbind(mean_lfp,mean_sync_lfp,mean_desync_lfp))
colnames(avg_motor_lfp) <- c("mean","sd")


#Same for motor Hbt
mean_hbt <- mean(df$motor_hbt)
mean_hbt[2] <- sd(df$motor_hbt)

mean_sync_hbt <- mean(df$motor_hbt[c(1:14)])
mean_sync_hbt[2] <- sd(df$motor_hbt[c(1:14)])

mean_desync_hbt <- mean(df$motor_hbt[c(15:25)])
mean_desync_hbt[2] <- sd(df$motor_hbt[c(15:25)])

avg_motor_hbt <- data.frame(rbind(mean_hbt,mean_sync_hbt,mean_desync_hbt))
colnames(avg_motor_hbt) <- c("mean","sd")




#comparing both sets of hbt and lfp whisker data
#For whisker lfp
mean_lfp <- mean(df$whisk_lfp)
mean_lfp[2] <- sd(df$whisk_lfp)

mean_sync_lfp <- mean(df$whisk_lfp[c(1:14)])
mean_sync_lfp[2] <- sd(df$whisk_lfp[c(1:14)])

mean_desync_lfp <- mean(df$whisk_lfp[c(15:25)])
mean_desync_lfp[2] <- sd(df$whisk_lfp[c(15:25)])

avg_whisk_lfp <- data.frame(rbind(mean_lfp,mean_sync_lfp,mean_desync_lfp))
colnames(avg_whisk_lfp) <- c("mean","sd")


#Same for Whisker Hbt
mean_hbt <- mean(df$whisk_hbt)
mean_hbt[2] <- sd(df$whisk_hbt)

mean_sync_hbt <- mean(df$whisk_hbt[c(1:14)])
mean_sync_hbt[2] <- sd(df$whisk_hbt[c(1:14)])

mean_desync_hbt <- mean(df$whisk_hbt[c(15:25)])
mean_desync_hbt[2] <- sd(df$whisk_hbt[c(15:25)])

avg_whisk_hbt <- data.frame(rbind(mean_hbt,mean_sync_hbt,mean_desync_hbt))
colnames(avg_whisk_hbt) <- c("mean","sd")





#HbT Plot
hbt_line <- ggplot()+
  geom_line(data=df,aes(x=trial,y=whisk_hbt),
            colour="blue",
            size=1)+
  geom_line(data=df,aes(x=trial,y=motor_hbt),
            colour="red",
            size=1)+
  scale_x_continuous(breaks=seq(0,30,5),
                     minor_breaks=seq(0,30,1),
                     limits=c(0,31),
                     expand=c(0,0))+
  scale_y_continuous(breaks=seq(-2,7,1),
                     limits=c(-2,6.5),
                     expand=c(0,0))+
  theme_light()+
  labs(x="Trial Number",y="2D-OIS HbT Levels",
       title="HbT Values Over Trials",subtitle="Blue = Whisker ; Red = Motor")+
  theme(panel.grid.major=element_line(colour="grey75"),
        panel.grid.minor=element_line(colour="grey90"),
        axis.title.x = element_text(vjust=-0.35),
        axis.title.y = element_text(vjust=2.5))

#Saving HbT line plot
ggsave(here("Output","hbt_line.png"),plot=hbt_line,width=8,height=5)



#LFP Plot
lfp_line <- ggplot()+
  geom_line(data=df,aes(x=trial,y=whisk_lfp),
            colour="blue",
            size=1)+
  geom_line(data=df,aes(x=trial,y=motor_lfp),
            colour="red",
            size=1)+
  theme_light()+
  scale_x_continuous(breaks=seq(0,30,5),
                     minor_breaks=seq(0,30,1),
                     limits=c(0,31),
                     expand=c(0,0))+
  scale_y_continuous(breaks=seq(0,9,1),
                     limits=c(2,8.5),
                     expand=c(0,0))+
  labs(x="Trial Number",y="Electrode Recording (LFP)",
       title="LFP Values Over Trials",subtitle="Blue = Whisker ; Red = Motor")+
  theme(panel.grid.major=element_line(colour="grey75"),
        panel.grid.minor=element_line(colour="grey90"),
        axis.title.x = element_text(vjust=-0.35),
        axis.title.y = element_text(vjust=2.5))

#Saving LFP line plot
ggsave(here("Output","lfp_line.png"),plot=lfp_line,width=8,height=5)



#WHISK
#Plotting boxplot of whisk_lfp
df_box_whisk_lfp <- df[c(1,4)]
df_box_whisk_lfp$group <- "desync"
df_box_whisk_lfp$group[c(1:14)] <- "sync" 
df_box_whisk_lfp <- df_box_whisk_lfp[-c(26:30),]
df_box_whisk_lfp$total <- "total"

whisk_lfp_box <- ggplot()+
  geom_boxplot(data=df_box_whisk_lfp,aes(x=group,y=whisk_lfp))+
  geom_boxplot(data=df_box_whisk_lfp,aes(x=total,y=whisk_lfp))+
  theme_light()+
  labs(title="Whisker Region LFP Boxplots")+
  ylab("Electrode Recording (LFP)")+
  xlab("Group")+
  scale_y_continuous(breaks=seq(6,9,0.5),
                     minor_breaks=seq(6,9,0.1),
                     limits=c(6.5,8.3),
                     expand=c(0,0))+
  theme(panel.grid.major=element_line(colour="grey75"),
        panel.grid.minor=element_line(colour="grey90"),
        axis.title.x = element_text(vjust=-0.35),
        axis.title.y = element_text(vjust=2.5))

#Saving whisk lfp box plot
ggsave(here("Output","whisk_lfp_box.png"),plot=whisk_lfp_box,width=8,height=5)


#Plotting boxplot of whisk_hbt
df_box_whisk_hbt <- df[c(1,2)]
df_box_whisk_hbt$group <- "desync"
df_box_whisk_hbt$group[c(1:14)] <- "sync" 
df_box_whisk_hbt <- df_box_whisk_hbt[-c(26:30),]
df_box_whisk_hbt$total <- "total"

whisk_hbt_box <- ggplot()+
  geom_boxplot(data=df_box_whisk_hbt,aes(x=group,y=whisk_hbt))+
  geom_boxplot(data=df_box_whisk_hbt,aes(x=total,y=whisk_hbt))+
  theme_light()+
  labs(title="Whisker Region HbT Boxplots")+
  ylab("2D-OIS HbT levels")+
  xlab("Group")+
  scale_y_continuous(breaks=seq(0,7,0.5),
                     minor_breaks=seq(0,7,0.1),
                     limits=c(1.5,6.2),
                     expand=c(0,0))+
  theme(panel.grid.major=element_line(colour="grey75"),
        panel.grid.minor=element_line(colour="grey90"),
        axis.title.x = element_text(vjust=-0.35),
        axis.title.y = element_text(vjust=2.5))

#Saving whisk hbt box plot
ggsave(here("Output","whisk_hbt_box.png"),plot=whisk_hbt_box,width=8,height=5)



#MOTOR
#Plotting boxplot of motor_lfp
df_box_motor_lfp <- df[c(1,5)]
df_box_motor_lfp$group <- "desync"
df_box_motor_lfp$group[c(1:14)] <- "sync" 
df_box_motor_lfp <- df_box_motor_lfp[-c(26:30),]
df_box_motor_lfp$total <- "total"


motor_lfp_box <- ggplot()+
  geom_boxplot(data=df_box_motor_lfp,aes(x=group,y=motor_lfp))+
  geom_boxplot(data=df_box_motor_lfp,aes(x=total,y=motor_lfp))+
  theme_light()+
  labs(title="Motor Region LFP Boxplots")+
  ylab("Electrode Recording (LFP)")+
  xlab("Group")+
  scale_y_continuous(breaks=seq(2,5,0.5),
                     minor_breaks=seq(2,5,0.1),
                     limits=c(2.6,4.8),
                     expand=c(0,0))+
  theme(panel.grid.major=element_line(colour="grey75"),
        panel.grid.minor=element_line(colour="grey90"),
        axis.title.x = element_text(vjust=-0.35),
        axis.title.y = element_text(vjust=2.5))

#Saving motor lfp box plot
ggsave(here("Output","motor_lfp_box.png"),plot=motor_lfp_box,width=8,height=5)



#Plotting boxplot of motor_hbt
df_box_motor_hbt <- df[c(1,3)]
df_box_motor_hbt$group <- "desync"
df_box_motor_hbt$group[c(1:14)] <- "sync" 
df_box_motor_hbt <- df_box_motor_hbt[-c(26:30),]
df_box_motor_hbt$total <- "total"


motor_hbt_box <- ggplot()+
  geom_boxplot(data=df_box_motor_hbt,aes(x=group,y=motor_hbt))+
  geom_boxplot(data=df_box_motor_hbt,aes(x=total,y=motor_hbt))+
  theme_light()+
  labs(title="Motor Region HbT Boxplots")+
  ylab("2D-OIS HbT levels")+
  xlab("Group")+
  scale_y_continuous(breaks=seq(-2,1,0.5),
                     minor_breaks=seq(-2,1,0.1),
                     limits=c(-1.4,0.7),
                     expand=c(0,0))+
  theme(panel.grid.major=element_line(colour="grey75"),
        panel.grid.minor=element_line(colour="grey90"),
        axis.title.x = element_text(vjust=-0.35),
        axis.title.y = element_text(vjust=2.5))

#Saving motor hbt box plot
ggsave(here("Output","motor_hbt_box.png"),plot=motor_hbt_box,width=8,height=5)

#Visualising all plots
whisk_lfp_box
whisk_hbt_box
motor_lfp_box
motor_hbt_box
lfp_line
hbt_line
