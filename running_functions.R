library(lcmm)
source("helper_functions_parallel.R")

root = "lcmm_modelling_data"

centiloid_plot_data <- read.csv(file.path(root, "centiloid_lcmm_data.csv"))
tau_plot_data <- read.csv(file.path(root, "tau_lcmm_data.csv"))
ptau_plot_data <- read.csv(file.path(root, "ptau_lcmm_data.csv"))
abeta_plot_data <- read.csv(file.path(root, "abeta_lcmm_data.csv"))
npi_plot_data <- read.csv(file.path(root, "npi_lcmm_data.csv"))
mpacctrailsb_plot_data <- read.csv(file.path(root, "mpacctrailsb_lcmm_data.csv"))
cdrsb_plot_data <- read.csv(file.path(root, "cdrsb_lcmm_data.csv"))
mmse_plot_data <- read.csv(file.path(root, "mmse_lcmm_data.csv"))
fdg_plot_data <- read.csv(file.path(root, "fdg_lcmm_data.csv"))
meta_roi_plot_data <- read.csv(file.path(root, "meta_roi_lcmm_data.csv"))
hippocampal_volume_plot_data <- read.csv(file.path(root, "hippocampal_volume_lcmm_data.csv"))
adas13_plot_data <- read.csv(file.path(root, "adas13_lcmm_data.csv"))
ecog_s_plot_data <- read.csv(file.path(root, "ecog_s_lcmm_data.csv"))
ecog_p_plot_data <- read.csv(file.path(root, "ecog_p_lcmm_data.csv"))
datnew   <- data.frame(adjusted_new_time = seq(-8, 8, length = 200),
                       age = round(seq(55.7, 95.4, length = 200), 1),
                       apoe = sample(c("E2", "E3", "E4"), 200, prob = c(0.06, 0.56, 0.38), replace = TRUE),
                       PTGENDER = sample(c(1, 2), 200, prob = c(0.45, 0.55), replace = TRUE),
                       PTEDUCAT = sample(c(12, 13, 14, 15, 16, 17, 18, 19, 20), 200, prob = c(0.11, 0.03, 0.04, 0.05, 0.26, 0.05, 0.22, 0.08, 0.14), replace = TRUE)
)

#############################################################################
#Centiloid
#############################################################################

centiloid_splines <- lcmm(Centiloid ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                          random = ~adjusted_new_time, subject="RID", maxiter = 300, data = centiloid_plot_data, link = "3-equi-splines")

summary(centiloid_splines) #3-spline: 2385.50

centiloid_predict_splines <- predictlink(centiloid_splines)

centiloid_test <- predictY(centiloid_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

centiloid_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = centiloid_plot_data, name_of_biomarker = "Centiloid")

#output_root = "/home/vhasfccuneod/Biomarkers_bootstrap_parallel/Outputs"
write.csv(centiloid_bootstrapped_data, "centiloid_bootstrapped_data.csv")

#####################################################################################
# looking at change in fdg PET Meta-ROI
#####################################################################################
fdg_splines <- lcmm(adjusted_Meta_ROI ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                    random = ~adjusted_new_time, subject="RID", maxiter = 300, data = fdg_plot_data, link = "3-equi-splines")

summary(fdg_splines) #3-spline: -607.96

fdg_predict_splines <- predictlink(fdg_splines)

fdg_test <- predictY(fdg_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

fdg_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = fdg_plot_data, name_of_biomarker = "adjusted_Meta_ROI")

write.csv(fdg_bootstrapped_data, "fdg_bootstrapped_data.csv")

#####################################################################################
# ADAS13
#####################################################################################

adas13_splines <- lcmm(ADAS13 ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                       random = ~adjusted_new_time, subject="RID", ng = 1, maxiter = 300, data = adas13_plot_data, link = "3-equi-splines")

summary(adas13_splines) #3-spline: 3599.46

adas13_predict_splines <- predictlink(adas13_splines)

adas13_test <- predictY(adas13_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

adas13_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = adas13_plot_data, name_of_biomarker = "ADAS13")

write.csv(adas13_bootstrapped_data, "adas13_bootstrapped_data.csv")

########################################################################################################
#MMSE
########################################################################################################
mmse_splines <- lcmm(MMSE ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                     random = ~adjusted_new_time, subject="RID", maxiter = 300, data = mmse_plot_data, link = "3-equi-splines")

summary(mmse_splines) #3-spline: 2176.99

mmse_predict_splines <- predictlink(mmse_splines)

mmse_test <- predictY(mmse_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

mmse_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = mmse_plot_data, name_of_biomarker = "MMSE")

write.csv(mmse_bootstrapped_data, "mmse_bootstrapped_data.csv")

#########################################################################################################
# CDRSB
#########################################################################################################
cdrsb_splines <- lcmm(CDRSB ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                      random = ~adjusted_new_time, subject="RID", maxiter = 300, data = cdrsb_plot_data, link = "3-equi-splines")

summary(cdrsb_splines) #3-spline: 664.42

cdrsb_predict_splines <- predictlink(cdrsb_splines)

cdrsb_test <- predictY(cdrsb_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

cdrsb_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = cdrsb_plot_data, name_of_biomarker = "CDRSB")

write.csv(cdrsb_bootstrapped_data, "cdrsb_bootstrapped_data.csv")

##########################################################################################################
# mPACCtrailsB
##########################################################################################################
mpacctrailsb_splines <- lcmm(mPACCtrailsB ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                             random = ~adjusted_new_time, subject="RID", maxiter = 300, data = mpacctrailsb_plot_data, link = "3-equi-splines")

summary(mpacctrailsb_splines) #3-spline: 3074.27

mpacctrailsb_predict_splines <- predictlink(mpacctrailsb_splines)

mpacctrailsb_test <- predictY(mpacctrailsb_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

mpacctrailsb_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = mpacctrailsb_plot_data, name_of_biomarker = "mPACCtrailsB")

write.csv(mpacctrailsb_bootstrapped_data, "mpacctrailsb_bootstrapped_data.csv")

###########################################################################################################
# NPI
###########################################################################################################

npi_splines <- lcmm(NPISCORE ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                    random = ~adjusted_new_time, subject="RID", maxiter = 300, data = npi_plot_data, link = "3-equi-splines")

summary(npi_splines) #3-spline: 2853.32

npi_predict_splines <- predictlink(npi_splines)

npi_test <- predictY(npi_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

npi_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = npi_plot_data, name_of_biomarker = "NPISCORE")

write.csv(npi_bootstrapped_data, "npi_bootstrapped_data.csv")

###########################################################################################################
# TAU
###########################################################################################################
tau_splines <- lcmm(TAU ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                    random = ~adjusted_new_time, subject="RID", maxiter = 300, data = tau_plot_data, link = "3-equi-splines")

summary(tau_splines) #3-spline: 1979.6

tau_predict_splines <- predictlink(tau_splines)

tau_test <- predictY(tau_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

tau_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = tau_plot_data, name_of_biomarker = "TAU")

write.csv(tau_bootstrapped_data, "tau_bootstrapped_data.csv")

###########################################################################################################
# PTAU
###########################################################################################################
ptau_splines <- lcmm(PTAU ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                     random = ~adjusted_new_time, subject="RID", maxiter = 300, data = ptau_plot_data, link = "3-equi-splines")

summary(ptau_splines) #3-spline: 1002.72

ptau_predict_splines <- predictlink(ptau_splines)

ptau_test <- predictY(ptau_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

ptau_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = ptau_plot_data, name_of_biomarker = "PTAU")

write.csv(ptau_bootstrapped_data, "ptau_bootstrapped_data.csv")

###########################################################################################################
# ABETA
###########################################################################################################
abeta_splines <- lcmm(ABETA ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                      random = ~adjusted_new_time, subject="RID", maxiter = 300, data = abeta_plot_data, link = "3-equi-splines")

summary(abeta_splines) #3-spline: 1002.72

abeta_predict_splines <- predictlink(ptau_splines)

abeta_test <- predictY(abeta_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

abeta_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = abeta_plot_data, name_of_biomarker = "ABETA")

write.csv(abeta_bootstrapped_data, "abeta_bootstrapped_data.csv")

############################################################################################################
# MRI: Meta-ROI
############################################################################################################

meta_ROI_splines <- lcmm(meta_ROI ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                         random = ~adjusted_new_time, subject="RID", maxiter = 300, data = meta_roi_plot_data, link = "3-equi-splines")

summary(meta_ROI_splines) #3-spline: -854.1

meta_ROI_predict_splines <- predictlink(meta_ROI_splines)

meta_ROI_test <- predictY(meta_ROI_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

meta_ROI_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = meta_roi_plot_data, name_of_biomarker = "meta_ROI")

write.csv(meta_ROI_bootstrapped_data, "meta_ROI_bootstrapped_data.csv")

############################################################################################################
# MRI: Hippocampal Volume
############################################################################################################
hippocampal_splines <- lcmm(hippocampal_volume ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                            random = ~adjusted_new_time, subject="RID", maxiter = 300, data = hippocampal_volume_plot_data, link = "3-equi-splines")

summary(hippocampal_splines) #3-spline: 6444.02

hippocampal_predict_splines <- predictlink(hippocampal_splines)

hippocampal_test <- predictY(hippocampal_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

hippocampal_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = hippocampal_volume_plot_data, name_of_biomarker = "hippocampal_volume")

write.csv(hippocampal_bootstrapped_data, "hippocampal_bootstrapped_data.csv")

############################################################################################################
#E-COG: Subject
############################################################################################################
ecog_s_splines <- lcmm(EcogPtMem ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                       random = ~adjusted_new_time, subject="RID", maxiter = 300, data = ecog_s_plot_data, link = "3-equi-splines")

summary(ecog_s_splines) #3-spline: 6444.02

ecog_s_predict_splines <- predictlink(ecog_s_splines)

ecog_s_test <- predictY(ecog_s_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

ecog_s_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = ecog_s_plot_data, name_of_biomarker = "EcogPtMem")

write.csv(ecog_s_bootstrapped_data, "ecog_s_bootstrapped_data.csv")

############################################################################################################
#E-COG: Partner
############################################################################################################
ecog_p_splines <- lcmm(EcogSPMem ~ adjusted_new_time + age + age*adjusted_new_time + PTGENDER + PTEDUCAT + apoe, #link = c("5-quantsplines"),
                       random = ~adjusted_new_time, subject="RID", maxiter = 300, data = ecog_p_plot_data, link = "3-equi-splines")

summary(ecog_p_splines) #3-spline: 6444.02

ecog_p_predict_splines <- predictlink(ecog_p_splines)

ecog_p_test <- predictY(ecog_p_splines, datnew, var.time = "adjusted_new_time", draws = TRUE)

ecog_p_bootstrapped_data <- lcmm_bootstrap_ci(new_data = datnew, n_iterations = 1000, lcmm_data = ecog_p_plot_data, name_of_biomarker = "EcogPtMem")

write.csv(ecog_p_bootstrapped_data, "ecog_p_bootstrapped_data.csv")
