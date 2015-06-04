#' A Function to read in and bind all the IPEDS csv in a specified folder.
#' @param directory.  A path to folder contianing only the csvs to be bound, such as "P:/Data/Work...etc"
#' @return a single bound csv written out to the same directory
#' @export
bindfiles <- function(directory){

currentdir <- getwd()
cat("orig wd was:", currentdir, "\n")

setwd(directory)
cat("files to bind are in:", directory, "\n")

#subset the directory supplied by the user to be used later when we write the
# bound file out to the directory.
filename = gsub(".*/", "", getwd())


# create empty list to be populated with individual dataframes

dflist=list()

# reads in all files in wd and assigns each one a unique name, with no spaces.
# checknames = FALSE prevents R from replacing spcaces with "." in column names
# gsub trims column names to remove everything before the "." that ipeds columns come with
#last line in the loop stores each unique df as a member of a list (dflist)


for (i in 1:length(list.files())){
  ds <- read.csv(list.files()[i], check.names=FALSE)
  colnames(ds)=gsub(".*\\.", "", colnames(ds))
    dflist [[i]]<- assign(paste("ds", i,sep=""), ds)
}

all<-plyr::rbind.fill(dflist)
write.csv(all, file =paste(filename, ".csv", sep=""), row.names = FALSE)


setwd(currentdir)

cat("wd returned to:", currentdir, "\n")

}

