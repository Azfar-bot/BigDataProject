### BigData Disease Prediction Model Outline
### 07.02.2020

# Vector of group member names
Group_Members <- c('Zachary Sykes', 'Joshua Russell', 'Ellie Sparling', 
                   'Andrew Gyesi', 'Judith Mbuyi')

# Package import (there will be more)
library(tidyverse)
library(ggplot2)
library(knitr)

### First Step

# Build a web scraper and API to pull data from openSNP.org

### Second Step

# Place that data into a data frame with various factors as colnames
  # SNP ID
  # Phenotype
  # Chromosome Location
  # Protein Affected
  # others...
  # (rownames should be patient IDs from scraped data)
# Remove / clean erroneous data

### Third Step

# Build a second web sraper?

# Pull more data from other sources (maybe openSNP.org too...?)
  # Place these into a dataframe of unknowns
  # Unknown SNP or unknown disease? or both? 
  # Maybe just chromosome location is no SNP or disease

# Remove / clean erroneous data

### Fourth Step

# Compare the two data frames in plots and graphs 
  # Highlight the unknown in a different colour and see where they lay
  # Example:
    # Plot SNP vs disease associated in the known patients
    # Plot the unknowns with just SNP (different colour) to predict where they lay
  # MORE GRAPHS IF INCONCLUSIVE