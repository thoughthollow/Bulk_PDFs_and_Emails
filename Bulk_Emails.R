#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# IMPORTANT! Only run this code AFTER you have created the PDFs!
#
# Alternatively if you simply wish to send regular emails in bulk, simply remove the line "Email[["attachments"]]..."
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# You'll need to install the package RDCOMClient, however the master has a bug.
# Instead use this installation method:
# remotes::install_github("BSchamberger/RDCOMClient", ref = "main")

# The above should install a fork that works by removing some buggy error log or something I believe.
# Use the below to install the package that will allow Rstudio to create emails using Microsoft Outlook.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Load the required packages.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(RDCOMClient)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Run the package.
# Re-title the path & file name as needed.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
df <- read.csv(file = "data/examplecredentials.csv")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# IMPORTANT: Make sure to change the email attachment file path to a directory of your own!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# This function creates the emails.
# It will save them as drafts, not send them.
# It needs optimisation, but it works fine.
# Change the email text, subject etc. as needed.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bulkemails <- function(emailAddress,
                       forenames,
                       surname,
                       username){
  Outlook <- COMCreate("Outlook.Application")
  Email = Outlook$CreateItem(0)
  Email[["to"]] = emailAddress
  Email[["subject"]] = paste0("New Credentials - ",
                              forenames, " ", toupper(surname))
  Email[["htmlbody"]] =
    paste0("<p>Dear ", forenames, " ", toupper(surname), ", ","</p>
  <p><em> THE ORGANISATION</em> is happy to announce that we are able to provide you with new credentials so you can access <strong>THE VENDOR'S SITE</strong>.</p>
  <br>
  <strong>Please see the attached PDF with instructions.</strong>
  <br>
  <p><em>If you encounter any issues,  then please let us know by contacting us at:
    <a href=' https://yourhomepage.org/form/'>
       https://yourhomepage.org/form/
    </a>
  </em></p>
  <p>Kind regards,<br>
  YOUR NAME
  </p>

  <b><span>YOUR NAME</span></b>
  <br>
  <span>Job Title</span>
  <br>
  <span>Your Department</span>
  <br><span>Your Organisation</span>
           ")
  Email[["attachments"]]$Add(paste0("C:/Users/EXAMPLE/Documents/R/Projects/Bulk_PDFs_and_Emails/pdfs/","New Credentials", " - ", username, " - ", format(Sys.Date(), format="%Y_%m_%d"), ".pdf"))
  Email$Save()
  Outlook$Quit()
  rm(Outlook, Email)
  gc()
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This loop goes through the dataframe from your csv file,
# and creates an email from the data in the relevant fields from each row.
#
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# IMPORTANT: It attaches a PDF as it loops.
# so if you haven't created the PDFs then it'll bug out.
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
for(i in 1:nrow(df)) {
  bulkemails(df$emailAddress[i],
             df$forenames[i],
             df$surname[i],
             df$username[i])
}

# The below opens Outlook in the background...
# Outlook <- COMCreate("Outlook.Application")

# The below creates the email
# Email = Outlook$CreateItem(0)

# Email[["to"]] = "example@example.com"
# Email[["cc"]] = ""
# Email[["bcc"]] = ""
# Email[["subject"]] = "Test"
# Email[["htmlbody"]] =
#  "<h1>Header</h1>
#  <p>You can write the body not using the html method, although I prefer it for stylising reasons.</p>
#  <p>Here's an example of a link:
#    <a href='https://www.google.com/'>
#      Google
#    </a>
#  </p>"

# Email[["attachments"]]$Add("C:/Users/EXAMPLE/Documents/R/Projects/Bulk_PDFs_and_Emails/pdfs/example.pdf")


# This saves the message as a draft. To send it instead, use "Send()".
# Email$Save()

# This chunk quits out of Outlook. The object needs to be out of memory for Outlook to be properly closed.
# Sometimes you may have to quit manually using ALT CTRL DEL.
# Outlook$Quit()
# rm(Outlook, Email)
# gc()
