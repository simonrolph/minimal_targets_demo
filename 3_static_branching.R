# you will need R package tarchetypes for the tar_map function

# in this example we use the iris dataset and want to make a plot for each species

library(targets)
library(tarchetypes)
library(ggplot2)

#static branching means we predefine our branches
species <- data.frame(species_names = c("setosa","versicolor","virginica"))

# a filter function, could use dplyr if you have it installed/loaded
filter_species <- function(df,species_to_filter){
  df[df$Species==species_to_filter,]
}

plot_species <- function(species_df,name_of_species){
  p1 <- ggplot(species_df,aes(x = Sepal.Length,y = Sepal.Width))+
    geom_point()+
    ggtitle(name_of_species)+
    theme_minimal()
}

#save the plot with ggsave
save_plot <- function(plot_obj,name_of_species){
  filename <- paste0("outputs/plot_",name_of_species,".png")
  ggsave(filename,plot_obj)
  filename
}

list(
  #load the file as before
  tar_target(data_file, "inputs/iris.csv",format = "file"),
  tar_target(data, read.csv(data_file)),
  
  #define the branching
  tar_map(
    values = species,
    names = species_names,
    
    #separate only the data for each species
    tar_target(species_data, filter_species(data,species_names)),
    
    #make a plot
    tar_target(species_plot, plot_species(species_data,species_names)),
    
    #save the plot
    tar_target(species_plot_saved, save_plot(species_plot,species_names),format = "file")
  )
  
)