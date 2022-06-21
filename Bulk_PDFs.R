#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Run the below first in your version of R.
# It only needs to be done the once.
#
# Install.packages(c("tidyverse","extrafont","remotes","tinytext", "devtools"))
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Run the below to enable you to use alternative fonts.
# Otherwise the extrafont package will bug out when trying to load the fonts.
# It only needs to be done the once.
#
# remotes::install_version("Rttf2pt1", version = "1.3.8")
# extrafont::font_import()
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Run the below to install the packages needed for the RMarkdown script.
# It only needs to be done the once.
#
# tinytex::install_tinytex()
# tinytex::tlmgr_install("fancyhdr")
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Load the required packages
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(tidyverse)
library(extrafont)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# It's presumed that you'll be using a csv file.
# I use a subfolder to hold such files called "data".
# Re-title the file name as needed.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
df <- read.csv(file = "data/examplecredentials.csv")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This function is for handling the knitting (i.e. creation from a RMarkdown file template) of the PDFs.
# Feel free to change the param names as needed.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
render_function <- function(surname, forenames, username, password){
  rmarkdown::render("PDF_Template.Rmd",
                    params = list(surname = surname, forenames = forenames, username = username, password = password),
                    output_dir = "pdfs",
                    output_file=paste0("New Credentials", " - ", username, " - ", format(Sys.Date(), format="%Y_%m_%d"), ".pdf")
  )
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This loop goes through the dataframe from your csv file,
# and creates a PDF from the data in the relevant fields from each row.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
for(i in 1:nrow(df)) {
  render_function(df$surname[i], df$forenames[i], df$username[i], df$password[i])
}
