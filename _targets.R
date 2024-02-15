#save this file as _targets.R
library(targets)
# This is an example _targets.R file. Every
# {targets} pipeline needs one.
# Use tar_script() to create _targets.R and tar_edit()
# to open it again for editing.
# Then, run tar_make() to run the pipeline
# and tar_read(data_summary) to view the results.

# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
# if you keep your functions in external scripts.
summarize_data <- function(dataset) {
  colMeans(dataset)
}

#fit the model
model_data <- function(dataset) {
  lm(y~x,dataset)
}

#make a prediction
predict_data <- function(x_values,model){
  newdata1 <- data.frame(x = x_values)
  data.frame(x = x_values,
             y = predict(model,newdata = newdata1))
}

plot_data <- function(dataset,prediction) {
  png(file="outputs/plot.png",width=600, height=350)
  plot(dataset)
  lines(prediction,col="red")
  title("My nice plot")
  dev.off()
  "outputs/plot.png"
}

# Set target-specific options such as packages:
# tar_option_set(packages = "utils") # nolint

# End this file with a list of target objects.
list(
  tar_target(data_file, "inputs/data.csv",format = "file"),
  
  tar_target(data, read.csv(data_file)),
  
  tar_target(data_summary, summarize_data(data)),
  tar_target(data_model, model_data(data)),
  
  tar_target(x_vals, 1:40),
  
  tar_target(data_predict, predict_data(x_vals,data_model)),
  
  tar_target(data_plot, plot_data(data,data_predict),format="file")
)




