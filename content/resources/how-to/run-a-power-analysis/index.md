---
title: ...run a power analysis
type: book
weight: 40
#date: '2021-01-01'

# display table-of-contents for this particular page on the right-hand side?
toc: false
---

{{% callout warning %}}
This R script runs a simulation-based power analysis for a simple 2AFC experimental design. This is **by no means** a one-size-fits-all solution to all your power needs. *Use at your own risk!*
{{% /callout %}}

The R script shared here is first and foremost intended as a **lab template**, providing code that we adjust each time we run a new 2AFC (two alternative forced choice) experiment. This means **it requires customization** for each individual new project.

It is based on [Kumle et al. (2021, BRM)](https://doi.org/10.3758/s13428-021-01546-0), adapting code from its github repo (Scenario #3) to fit our needs. It runs a simulation-based GLMM power analysis with 1000 iterations for a 2AFC design with {10, 20, 30, 40, 50} participants, each presented with 100 trials sampling from a single 5-step phonetic continuum. The estimates for fixed effects and random effects are drawn from pilot data, but can also be adopted from previous literature.

The script can be adjusted to run LMM power analysis (instead of GLMM) and to include >1 random effects; see comments in script.

> Download the [R_power_analysis.R](R_power_analysis.R) script here.

```r
##### Hans Rutger Bosker, Radboud University Nijmegen
##### SPEAC research group, hrbosker.github.io
##### HansRutger.Bosker@ru.nl
##### License: CC BY-NC 4.0
##### Last updated: July 20, 2022

##### Code adapted from Kumle et al. (2021, Behavior Research Methods)
##### doi: 10.3758/s13428-021-01546-0
##### who introduced the R package 'mixedpower' comparing it to 'simr'.
##### Specifically: https://lkumle.github.io/power_notebooks/Scenario3_notebook.html
#####           and https://github.com/lkumle/analyses_power_tutorial/blob/master/Scenario%203/Analysis_Scenario3.R

##### In its present form, the script runs a simulation-based GLMM power analysis
##### for a 2AFC experimental design with 20 participants and 100 trials per pp.
##### BinomResp is the binomial dependent variable of 0s and 1s.
##### Predictors are Group (between-participant) and ScaledStep (within-participant).
#####	> For LMMs, see: https://lkumle.github.io/power_notebooks/Scenario3_notebook.html 
##### 	> For adding additional random effects, see suggestions in script below.

########################################################################################
# REQUIRED PACKAGES
########################################################################################
library(lme4)
library(simr) # for comparison to mixedpower

##### Apparently, 'mixedpower' does not live on the 'default' package R server.
##### In order to install it, you need another package 'remotes' to access it.
##### Note: you only need to install these packages once. Once they're installed,
##### simply running the library() statements suffices.

#install.packages("remotes")
#library(remotes)
#remotes::install_github("DejanDraschkow/mixedpower")

library(mixedpower)






########################################################################################
# RETRIEVING ESTIMATES FROM PILOT DATA
########################################################################################

pilot <- read.table(file="pilotdata.txt", sep="\t", header=T)

head(pilot)
# ppid = participant number (hence, a unique entry for each pp)
# trialnr = test item order (1:100)
# step = step on the test continuum: 1,2,3,4,5
# stepscaled = scaled version of step (z-scored), resulting from: scale(pilot$step)
# group = group, with 2 levels: Group_1 or Group_2
# group_devcod = deviance coded 'group': -0.5 is Group_1, +0.5 is Group_2
# BinomResp = binomial coding of participants' responses (0s and 1s)

pilot_m <- glmer(BinomResp ~ group_devcod * stepscaled +
                   (1|ppid),
                 data=pilot, family="binomial")
summary(pilot_m)






########################################################################################
# CREATING ARTIFICIAL DATA
########################################################################################

##### This creates a dataset in which 20 participants are presented 100 trials each.
##### Half of the participants are assigned to Group 1, the other half to Group 2.
##### The 100 trials per participant include steps 1, 2, 3, 4, and 5 from a phonetic continuum.
##### So each step is repeated 20 times per participant.

# 1: RANDOM EFFECTS
# including variables used as random effects in artificial data
number_of_participants = 20
number_of_trials_per_participant = 100
artificial_data <- expand.grid(TrialID = (1:number_of_trials_per_participant), 
                               ParticipantID = (1:number_of_participants))
# At present, the script is designed for an analysis with only 1 random intercept.
# If requiring >1 random effects
# ...adjust the 'artificial_data';
# ...add an estimate for 'estim_ran_effs';
# ...adjust the 'artificial_glmer'.
							   
# 2. FIXED EFFECTS
#  generate continuum steps
continuum_steps <- c(1:5)

# repeat for every ParticipantID in data (e.g., 20 times)
artificial_data["Continuum_step"] <- rep(continuum_steps, number_of_participants)
artificial_data$ScaledStep <- scale(artificial_data$Continuum_step)

# include group
artificial_data["Group"] <- 0.5
artificial_data[artificial_data$ParticipantID<=(0.5*number_of_participants),]$Group <- -0.5
summary(as.factor(artificial_data$Group))

# 3. VERIFICATION OF DATAFRAME DESIGN
head(artificial_data)
summary(artificial_data)
table(artificial_data$ParticipantID,artificial_data$Continuum_step)
table(artificial_data$ParticipantID,artificial_data$TrialID)
table(artificial_data$ParticipantID,artificial_data$Group)






########################################################################################
# CREATING ARTIFICIAL MODEL
########################################################################################

##### See summary(pilot_m) above for random and fixed effect estimates.

# summary(pilot_m)

##### estim_fix_effs <- c(intercept, firstSimpleEffect, secondSimpleEffect, interaction)
estim_fix_effs <- c(0.125, 0.838, -1.072)
##### estim_ran_effs <- c(firstRandomIntercept, secondRandomIntercept)
estim_ran_effs <- c(0.627)

##### NOTE: it is very important that the order of estimates in 'estim_fix_effs' and 'estim_ran_effs'
##### 	is identical to the other of predictors in 'artificial_glmer'
#####	and in 'power_S3' below.

artificial_glmer <- makeGlmer(formula = BinomResp ~ Group + ScaledStep +
                                (1 | ParticipantID),
                              fixef = estim_fix_effs, VarCorr = list(estim_ran_effs), 
                              family = "binomial",  data = artificial_data)
summary(artificial_glmer)
##### NOTE: at present, only testing for two simple effects without interaction
##### and a single random intercept for Participants.







########################################################################################
# POWER ANALYSIS
########################################################################################

# USING THE PACKAGE simr

#power_simr <- powerSim(fit = artificial_glmer, test = fixed("Group"), nsim = 1000)
#print(power_simr)



# USING THE PACKAGE mixedpower

# SESOI = Smallest Effect Size Of Interest
# A simple justification strategy is to reduce all beta coefficients by 15%

power_mixed <- mixedpower(model = artificial_glmer, data = artificial_data,
                       fixed_effects = c("Group", "ScaledStep"),
                       simvar = "ParticipantID", steps = c(10,20,30,40,50),
                       critical_value = 2, n_sim = 1000, 
                       SESOI = (estim_fix_effs*0.85))
print(power_mixed)
multiplotPower(power_mixed)

################################################################################
# End of script
################################################################################

```

*Happy R'ing!*
