### API GENE DATA PULL | Facto XI Deficiency | Judith Mbyui

# Library load
library(httr)
library(jsonlite)
library(xml2)
library(fs)

# Target disease phenotypes
fact_xi_geneids <- 'F11'

######################
### VERY IMPORTANT ###
######################

# Set directory below to a folder OTHER than the git env as I have done below
# If you upload the .rds files saved below to the repository I will kill you
start_dir <- getwd()
# CHANGE THIS PATH TO SOMETHING OTHER THAN YOUR GIT FOLDER
# rds_save_dir <- setwd('H:/R_Scripts/ProjectAPISaves/') # Zach's Windows PATH
rds_save_dir <- setwd('/media/sykes/BLUE/R_Scripts/ProjectAPISaves/') # Zach's Linux PATH

######################
### VERY IMPORTANT ###
######################

# Function to shift files from working directory
file_shift <- function(namedir, filename) {
  
  dir.create(paste0(rds_save_dir, namedir)) # Create new directory to store the .rds files in
  
  files_to_move <- list.files(rds_save_dir,
                              pattern = '\\.rds')
  save_path <- paste0(rds_save_dir, namedir)
  
  for (file in files_to_move) {
    file_move(file, save_path)
  }
}

##### GET request function to pull in disease data #####

# SOURCE: Ensembl
disease_pheno_json_pull <- function(geneid, filename) {
  
  # URL set
  core_url <- 'https://rest.ensembl.org'
  extension_url <- paste0('/phenotype/gene/homo_sapiens/', geneid, '?include_overlap=1;include_associated=1')
  
  pheno_json <- GET(paste0(core_url, extension_url),
                    content_type('application/json'),
                    user_agent('zachary.h.sykes@gmail.com -- Genetic risk prediction project')) # DO NOT CHANGE MY EMAIL
  
  # Save and move files into disease specific directory
  if(http_type(pheno_json) != 'application/json') {
    warning('No information returned for this gene id')
  } else {
    saveRDS(pheno_json, filename)
  }
} # API COMPLETE

### NOTE: Add path to Ophranet xml file here and parse data out in each disease section below

# Handling response JSON files for each target phenotype requested
### BE PATIENT IF YOU HAVE TO RUN THE API IT TAKES ABOUT 10 - 40 MINUTES

##############################################
##### Factor XI Deficiency JSON Response #####
##############################################

fact_xi_geneids_resp <- list()
for (gene in fact_xi_geneids) {
  disease_pheno_json_pull(
    geneid = gene,
    filename = paste0(tolower(gene), '_data_factxi_json.rds')
  )
  fact_xi_geneids_resp <- list(
    content(readRDS(paste0(tolower(gene), '_data_factxi_json.rds')))
  )
  Sys.sleep(15)
}

# Run this after the GET request above to clear the working directory
file_shift(
  namedir = '/fact_xi_pheno_data/',
  filename = paste0(tolower(fact_xi_geneids), '_data_factxi_json.rds')
)