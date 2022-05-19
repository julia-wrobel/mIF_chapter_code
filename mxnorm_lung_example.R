library(mxnorm)
library(tidyverse)

# subset lung data to just 20 subjects for faster code / illustrative purposes
load(file = "/Users/juliawrobel/Documents/lung_subset.rda")
str(lung_subset)


length(unique(lung_subset$slide_id)) # 20 slides/subjects
length(unique(lung_subset$sample_id)) # 99 total images



mx_data = mx_dataset(data = lung_subset,
                     slide_id = "slide_id",
                     image_id = "sample_id",
                     marker_cols = c("cd19",
                                     "cd3",
                                     "cd14",
                                     "cd8",
                                     "hladr",
                                     "ck",
                                     "dapi"
                     ),
                     metadata_cols = c("tissue_category"))


## says the object has 1 slide, when it should say 20
summary(mx_data)



# normalize the data
mx_norm = mx_normalize(mx_data,
                       transform = "log10_mean_divide",
                       method = "None")


# breaks
summary(mx_norm)




# normalize the data using registration, also breaks. FWIW I tried combat too.
mx_norm = mx_normalize(mx_data,
                       transform = "log10_mean_divide",
                       method = "ComBat")

summary(mx_norm)




